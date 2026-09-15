# Setup

My Linux development environment: Artix installation notes, Zsh and Neovim
configuration, everyday scripts, and dwmblocks status modules.

## Start here

1. [Install Artix](docs/artix-install.md) — runit, UEFI, and encrypted storage.
2. [Configure the installed system](docs/post-install.md) — packages, shell,
   editor, and personal preferences.
3. [Set up Zsh](config/zsh/README.md) and [Neovim](config/nvim/README.md).
4. Choose the [scripts](scripts/README.md) and [status modules](dwmblocks/README.md)
   you want to use.

The files reflect my own machines and preferences. Configuration is deployed
manually; each section describes where its files belong.

## Layout

| Directory | Contents |
| --- | --- |
| [docs/](docs/) | Installation and post-install instructions |
| [config/zsh/](config/zsh/) | Zsh startup file, environment, aliases, and functions |
| [config/nvim/](config/nvim/) | Neovim configuration, plugin declarations, and snippets |
| [scripts/](scripts/) | General utilities, with runit, network, media, and desktop groups |
| [dwmblocks/](dwmblocks/) | Status-bar modules |

## Window manager and terminal

The patched applications have their own source and build instructions:

- [dwm](https://github.com/se-kami/dwm) — window manager
- [st](https://github.com/se-kami/st) — terminal

## Consolidated repositories

This repository brings together the following projects, including their Git
histories. Use `setup` for future changes.

| Original repository | Current location |
| --- | --- |
| [artix-install](https://github.com/se-kami/artix-install) | [Installation](docs/artix-install.md) and [post-install](docs/post-install.md) |
| [shell-utils](https://github.com/se-kami/shell-utils) | [Zsh](config/zsh/) and [scripts](scripts/) |
| [nvim](https://github.com/se-kami/nvim) | [config/nvim/](config/nvim/) |
| [dwmblocks-modules](https://github.com/se-kami/dwmblocks-modules) | [dwmblocks/](dwmblocks/) |
