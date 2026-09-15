# Post-install setup

[Back to setup](../README.md) · [Artix installation](artix-install.md)

Use `<USER>` for the regular account created during installation. Run the SSH
section as root; continue with your regular user for the remaining sections.

These sections contain the original personal preferences and package selections.

## SSH (optional)

As root, install and enable SSH on the installed system:

```sh
pacman -S openssh-runit
ln -s /etc/runit/sv/sshd /run/runit/service/
```

Use your regular user when connecting remotely.

## Continue as your regular user

Log in as the user created during installation. The remaining shell commands
run as that user, with `sudo` where needed.

## Package manager preferences

Edit the `[options]` section of `/etc/pacman.conf` using
`sudo vi /etc/pacman.conf`:

```ini
Color
CheckSpace
VerbosePkgLists
ILoveCandy
```

Install the mirror lists from the original setup:

```sh
sudo pacman -S archlinux-mirrorlist artix-mirrorlist
```

## AUR helper

Build yay as your regular user, following
[yay's installation instructions](https://github.com/Jguer/yay#installation):

```sh
cd
git clone https://aur.archlinux.org/yay-git.git
cd yay-git
makepkg -si
cd
```

After a successful installation, the build directory can be removed:

```sh
rm -rf ~/yay-git
```

## Shell

Install Zsh before selecting it:

```sh
sudo pacman -S zsh
chsh -s /usr/bin/zsh
```

Log out and back in to use the new login shell.

Then follow the [Zsh configuration instructions](../config/zsh/README.md) to
load the environment, aliases, and functions in this repository.

## Editor and plugins

```sh
yay -S neovim vim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

The plugin declarations are in [config/nvim/init.vim](../config/nvim/init.vim).
Follow the [Neovim configuration instructions](../config/nvim/README.md) to
link the configuration and snippets into place. The
[vim-plug documentation](https://github.com/junegunn/vim-plug#usage) explains how
to edit the plugin list.

Once that configuration is loaded, run this **inside Neovim**:

```vim
:PlugInstall
```

## Sudo preferences (optional)

After Neovim and yay are installed, run `sudo visudo` and add the original
preferences below. The `NOPASSWD` rule grants passwordless root access to
the listed commands.

```sudoers
Defaults passwd_timeout=0
Defaults editor=/usr/bin/nvim

Cmnd_Alias UPDATE_CMDS = /usr/bin/pacman, /usr/bin/yay
Cmnd_Alias OTHER_CMDS = /usr/bin/iotop, /usr/bin/wpa_cli, /usr/bin/mount

<USER> ALL=(ALL) NOPASSWD: UPDATE_CMDS, OTHER_CMDS
```

## Python and older editor dependencies (optional)

The original setup used Python 3.9, Python 2, and the `neovim` Python package.
These are application-specific notes; choose the interpreters needed by your
configuration.

Original Python 3.9 setup:

```sh
yay -S python39
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3.9 get-pip.py
```

The original notes also ran `python get-pip.py` for the default interpreter and
`pip install neovim` for editor integration. Check which interpreter these
commands target before using them.

Original Python 2 setup:

```sh
sudo pacman -S python2
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip.py
python2 get-pip.py
```

## Bluetooth

```sh
yay -S bluez-runit bluez bluez-utils
```

To reset the Bluetooth radio's blocked state:

```sh
sudo rfkill block bluetooth
sudo rfkill unblock bluetooth
```

## Other packages

```sh
yay -S git zathura zathura-djvu zathura-ps zathura-pdf-mupdf mpd mpv ncmcpp \
    newsboat picom tmux weechat feh htim lf nsxiv firefox unzip vimv wget \
    parcellite-git pass xorg-xsetroot xclip dash dashbin bc fdupes ffmpeg \
    imagemagick hdparm ibus maim playerctl
```

## Desktop and everyday tools

- Choose utilities from the [script index](../scripts/README.md).
- Configure the [dwmblocks status modules](../dwmblocks/README.md).
- Follow the separate build instructions for
  [dwm](https://github.com/se-kami/dwm) and [st](https://github.com/se-kami/st).
