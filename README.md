# Setup

My Linux development environment: Artix installation notes, Zsh and Neovim
configuration, and everyday scripts.

## Dotfiles

[GNU Stow](https://www.gnu.org/software/stow/) links the configuration from this
checkout into your home directory. Neovim and Zsh are separate packages.
Install Bash and Stow, plus the programs you want to configure. On Artix:

```sh
sudo pacman -S --needed stow zsh neovim fzf fd ripgrep zsh-syntax-highlighting
```

Keep the checkout in a permanent location, then preview and install its links:

```sh
git clone https://github.com/se-kami/setup.git
cd setup
./stow.sh --dry-run
./stow.sh
```

| Command | Effect |
| --- | --- |
| `./stow.sh` | Link both Neovim and Zsh |
| `./stow.sh nvim` | Link only Neovim |
| `./stow.sh zsh` | Link only Zsh |
| `./stow.sh --restow` | Refresh links after pulling changes |
| `./stow.sh --delete zsh` | Remove this checkout's Zsh links |
| `./stow.sh --dry-run --target /path/to/home` | Preview against another existing home directory |

The helper links individual files and keeps directories real. Plugin downloads,
caches, and other files created by applications therefore stay outside this
checkout. Existing files and links from another dotfiles checkout are reported
as conflicts; resolve those before installing. The helper never uses `--adopt`.

See the [Zsh](config/zsh/README.md) and [Neovim](config/nvim/README.md) pages for
startup files, dependencies, and moving from an older configuration. These are
personal configs, including machine-specific aliases and tools.

## Layout

| Directory | Contents |
| --- | --- |
| [docs/](docs/) | Artix installation and post-install instructions |
| [config/zsh/](config/zsh/) | Stow package for Zsh, environment, aliases, and functions |
| [config/nvim/](config/nvim/) | Stow package for Neovim, plugins, and snippets |
| [scripts/](scripts/) | General utilities, with runit, network, media, and desktop groups |

Each package mirrors paths relative to `$HOME`. For example,
`config/nvim/.config/nvim/init.lua` becomes `~/.config/nvim/init.lua`.
Package READMEs are documentation and are not linked into your home.

## System setup

1. [Install Artix](docs/artix-install.md) — runit, UEFI, and encrypted storage.
2. [Configure the installed system](docs/post-install.md) — packages, shell,
   editor, and personal preferences.
3. Install the dotfiles above and choose the [scripts](scripts/README.md) to use.

## Related desktop projects

These components are maintained in separate repositories:

- [dwm](https://github.com/se-kami/dwm) — window manager
- [st](https://github.com/se-kami/st) — terminal
- [dwmblocks modules](https://github.com/se-kami/dwmblocks-modules) — status bar

## Consolidated repositories

This repository includes the Git histories of the original projects. Use
`setup` for future changes. Its Neovim and Zsh packages contain the current
working dotfiles, replacing the older configuration snapshots.

| Original repository | Current location |
| --- | --- |
| [artix-install](https://github.com/se-kami/artix-install) | [Installation](docs/artix-install.md) and [post-install](docs/post-install.md) |
| [shell-utils](https://github.com/se-kami/shell-utils) | [Zsh](config/zsh/) and [scripts](scripts/) |
| [nvim](https://github.com/se-kami/nvim) | [config/nvim/](config/nvim/) |
