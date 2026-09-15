# Zsh configuration

[Back to setup](../../README.md)

| Package file | Destination |
| --- | --- |
| [.zshenv](.zshenv) | `~/.zshenv` |
| [.config/env](.config/env) | `~/.config/env` |
| [.config/aliasrc](.config/aliasrc) | `~/.config/aliasrc` |
| [.config/fnrc](.config/fnrc) | `~/.config/fnrc` |
| [.config/zsh/.zshrc](.config/zsh/.zshrc) | `~/.config/zsh/.zshrc` |
| [.config/zsh/.zprofile](.config/zsh/.zprofile) | `~/.config/zsh/.zprofile` |

`.zshenv` loads `~/.config/env`, which defines the XDG directories and sets
`ZDOTDIR=$HOME/.config/zsh`. Interactive Zsh then loads the startup file, aliases,
and functions. The `myVIMRC` variable points to the Lua Neovim configuration.

## Install

Install Zsh and GNU Stow, then run from the root of this checkout:

```sh
./stow.sh --dry-run zsh
./stow.sh zsh
```

The helper also creates `~/.cache/zsh` for completion data after a successful
installation. It creates no files during a dry run. Open a new Zsh session after
installing the links. Selecting Zsh as your login shell is a separate step in
the [post-install instructions](../../docs/post-install.md#shell).

Existing files and symlinks from the old dotfiles checkout are conflicts.
Review and remove or relocate those target files before installing; preserve
their source files. Refresh links with `./stow.sh --restow zsh`, or remove this
checkout's links with `./stow.sh --delete zsh`.

## Dependencies and personal files

The startup file uses `fzf --zsh`, `fd`, and Zsh syntax highlighting. On Artix,
install `fzf`, `fd`, and `zsh-syntax-highlighting`; the highlighting script is
expected at `/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh`.
See [fzf's shell integration](https://github.com/junegunn/fzf#setting-up-shell-integration)
for versions that provide `fzf --zsh`.

The environment loads `~/.local/share/secrets` only when that private file is
readable. It is not part of this repository. Personal aliases and functions
retain their existing paths and integrations, including desktop tools, `lf`,
and external scripts. Review these when using a different machine.
