# Neovim configuration

[Back to setup](../../README.md)

This package contains the current Lua configuration:

- [init.lua](.config/nvim/init.lua): entry point.
- [lua/user/](.config/nvim/lua/user/): settings, mappings, and commands.
- [lua/plugins/](.config/nvim/lua/plugins/): lazy.nvim bootstrap and plugin declarations.
- [after/](.config/nvim/after/): filetype settings and LuaSnip snippets.
- [plugins/](.config/nvim/plugins/): local plugins, including codebot and translatebot.
- [lazy-lock.json](.config/nvim/lazy-lock.json): plugin versions from the working configuration.

## Install

Install Neovim, Git, and GNU Stow. Run from the root of this checkout:

```sh
./stow.sh --dry-run nvim
./stow.sh nvim
```

The package links into `~/.config/nvim`. Stow keeps directories real, so new
runtime files stay in the target directory. The tracked `lazy-lock.json` is
linked intentionally; changing plugin versions updates that file in the repo.

Open Neovim. The configuration bootstraps lazy.nvim when needed, which requires
network access. Restore the recorded plugin versions with:

```vim
:Lazy restore
```

Then run `:checkhealth` to check integrations. See the
[lazy.nvim installation guide](https://lazy.folke.io/installation) for details.
External dependencies vary by enabled feature: language servers, formatters,
LaTeX tools, `ripgrep`, `fd`, and the tools used by the local plugins are separate
installations. The codebot helper reads its API credential from the environment.

## Moving from an older configuration

This package uses `init.lua`, lazy.nvim, and LuaSnip. The earlier setup snapshot
used `init.vim`, vim-plug, and UltiSnips. Move the old `init.vim` and its companion
links out of the target before installing; Neovim must not have both entry files.

If another dotfiles checkout owns your current links, review those links and
remove or relocate them before running Stow here. Keep the old source files until
you have verified the new setup. Avoid `stow --adopt`, which moves target files
into the repository.

Refresh after pulling changes with `./stow.sh --restow nvim`, or remove this
checkout's links with `./stow.sh --delete nvim`.
