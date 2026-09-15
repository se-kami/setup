"""Exercise real GNU Stow against temporary targets; never use the real home."""
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]


def snapshot(root):
    result = {}
    for path in root.rglob('*'):
        relative = str(path.relative_to(root))
        if path.is_symlink():
            result[relative] = ('link', str(path.readlink()))
        elif path.is_file():
            result[relative] = ('file', path.read_bytes())
        else:
            result[relative] = ('directory',)
    return result


@unittest.skipUnless(shutil.which('stow'), 'GNU Stow is required')
class StowTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix='setup-stow-test-')
        self.addCleanup(self.temp.cleanup)
        self.parent = Path(self.temp.name)
        self.target = self.parent / 'home with spaces'
        self.target.mkdir()

    def run_stow(self, *args, root=ROOT, success=True):
        result = subprocess.run(
            [str(root / 'stow.sh'), '--target', str(self.target), *args],
            cwd=self.parent, capture_output=True, text=True,
        )
        if success:
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        else:
            self.assertNotEqual(result.returncode, 0)
        return result

    def test_install_both_with_real_directories_and_no_documentation_links(self):
        self.run_stow()
        expected = [
            '.zshenv', '.config/env', '.config/aliasrc', '.config/fnrc',
            '.config/zsh/.zshrc', '.config/zsh/.zprofile',
            '.config/nvim/init.lua', '.config/nvim/lazy-lock.json',
            '.config/nvim/lua/user/options.lua',
        ]
        for name in expected:
            path = self.target / name
            self.assertTrue(path.is_symlink(), name)
            self.assertTrue(path.resolve().is_file(), name)
        for name in ('.config', '.config/nvim', '.config/nvim/lua', '.config/zsh'):
            self.assertTrue((self.target / name).is_dir())
            self.assertFalse((self.target / name).is_symlink())
        self.assertTrue((self.target / '.cache/zsh').is_dir())
        self.assertFalse((self.target / 'README.md').exists())
        self.assertFalse((self.target / '.stow-local-ignore').exists())
        self.assertFalse((self.target / '.config/nvim/init.vim').exists())

    def test_preview_has_no_target_or_package_side_effects(self):
        source_before = snapshot(ROOT / 'config')
        self.run_stow('--dry-run')
        self.assertEqual(snapshot(self.target), {})
        self.assertEqual(snapshot(ROOT / 'config'), source_before)

    def test_individual_packages(self):
        self.run_stow('nvim')
        self.assertTrue((self.target / '.config/nvim/init.lua').is_symlink())
        self.assertFalse((self.target / '.zshenv').exists())
        self.run_stow('zsh')
        self.run_stow('--delete', 'nvim')
        self.assertTrue((self.target / '.zshenv').is_symlink())
        self.assertFalse((self.target / '.config/nvim/init.lua').exists())

    def test_existing_file_conflict_does_not_adopt_or_overwrite(self):
        (self.target / '.zshenv').write_text('existing personal config\n')
        target_before = snapshot(self.target)
        source_before = snapshot(ROOT / 'config')
        self.run_stow(success=False)
        self.assertEqual(snapshot(self.target), target_before)
        self.assertEqual(snapshot(ROOT / 'config'), source_before)

    def test_legacy_neovim_entry_point_is_reported_before_linking(self):
        directory = self.target / '.config/nvim'
        directory.mkdir(parents=True)
        (directory / 'init.vim').write_text('set number\n')
        before = snapshot(self.target)
        self.run_stow('nvim', success=False)
        self.assertEqual(snapshot(self.target), before)
        self.assertFalse((directory / 'init.lua').exists())

    def test_existing_foreign_directory_link_is_preserved(self):
        old = self.parent / 'old nvim'
        old.mkdir()
        (old / 'init.lua').write_text('-- old config\n')
        (self.target / '.config').mkdir()
        (self.target / '.config/nvim').symlink_to(old, target_is_directory=True)
        before = snapshot(self.target)
        self.run_stow('nvim', success=False)
        self.assertEqual(snapshot(self.target), before)
        self.assertEqual((old / 'init.lua').read_text(), '-- old config\n')

    def test_repeat_refresh_and_remove_preserve_runtime_files(self):
        self.run_stow()
        self.run_stow()
        runtime = self.target / '.config/nvim/local-runtime-file'
        runtime.write_text('keep this\n')
        self.run_stow('--restow')
        self.assertEqual(runtime.read_text(), 'keep this\n')
        self.run_stow('--delete')
        self.assertEqual(runtime.read_text(), 'keep this\n')
        self.assertFalse((self.target / '.zshenv').exists())
        self.assertFalse((self.target / '.config/nvim/init.lua').exists())
        self.assertTrue((ROOT / 'config/nvim/.config/nvim/init.lua').is_file())

    def test_repository_path_with_spaces(self):
        copied = self.parent / 'setup with spaces'
        copied.mkdir()
        shutil.copy2(ROOT / 'stow.sh', copied / 'stow.sh')
        shutil.copytree(ROOT / 'config', copied / 'config')
        self.run_stow('zsh', root=copied)
        self.assertEqual((self.target / '.zshenv').resolve(), copied / 'config/zsh/.zshenv')

    def test_invalid_arguments_do_not_change_target(self):
        for args in (('unknown',), ('--adopt',), ('--delete', '--restow'), ('../zsh',), ('--target',)):
            with self.subTest(args=args):
                self.run_stow(*args, success=False)
                self.assertEqual(snapshot(self.target), {})


if __name__ == '__main__':
    unittest.main()
