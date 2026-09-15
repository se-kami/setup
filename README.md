# Artix Linux installation

Personal installation notes for an x86-64 machine using **runit, UEFI, GRUB,
and LVM on LUKS1**. The root filesystem is ext4; `/boot` lives inside the
encrypted root volume, and the EFI system partition is mounted at `/efi`.

The examples retain the original Intel microcode and `intel_pstate=no_hwp`
choices. Adapt those to your hardware. The personal setup section records
individual package and configuration preferences.

## Contents

1. [Before you start](#before-you-start)
2. [Prepare installation media](#prepare-installation-media)
3. [Prepare the live environment](#prepare-the-live-environment)
4. [Prepare storage](#prepare-storage)
5. [Install and configure the system](#install-and-configure-the-system)
6. [Configure encrypted boot](#configure-encrypted-boot)
7. [First boot](#first-boot)
8. [Personal setup](#personal-setup)

## Before you start

Replace every `<PLACEHOLDER>` before running a command. Device placeholders
include the full `/dev/` path. Follow the steps in order; file contents and
interactive commands are labeled separately.

| Placeholder | Meaning | Example |
| --- | --- | --- |
| `<ISO_FILE>` | Downloaded ISO path | `artix-base-runit-…-x86_64.iso` |
| `<SIG_FILE>` | Matching detached signature path | The ISO's `.sig` file |
| `<KEY>` | Signing key fingerprint published by Artix | See the download page |
| `<USB>` | Whole USB device used for installation media | `/dev/sdb` |
| `<DISK>` | Whole disk receiving the installation | `/dev/nvme0n1` |
| `<EFI_PART>` | EFI partition, formerly D1 | `/dev/nvme0n1p1` |
| `<LUKS_PART>` | Encrypted partition, formerly D2 | `/dev/nvme0n1p2` |
| `<LUKS_UUID>` | UUID of `<LUKS_PART>`, obtained with `blkid` | Used by GRUB |
| `<CRYPT_FILE>` | Absolute keyfile path inside the installed system | `/root/cryptlvm.key` |
| `<ZONE>` | Time zone under `/usr/share/zoneinfo/` | `Europe/Prague` |
| `<HOSTNAME>` | Hostname used consistently in both files | `artix` |
| `<USER>` | Regular login user | `myuser` |
| `<IP>` | Live system's address for SSH | `192.168.1.10` |
| `<WIFI_SERVICE>` | Full Wi-Fi service identifier from ConnMan | Starts with `wifi_` |
| `<WIFI_DEVICE>` | Wireless device name from `iwctl device list` | `wlan0` |
| `<SSID>` | Wi-Fi network name | `My Wi-Fi` |
| `<ETHERNET>` | Wired service identifier from ConnMan | Starts with `ethernet_` |
| `<ADDRESS>`, `<NETMASK>`, `<GATEWAY>` | Static IPv4 settings | `192.168.1.10`, `255.255.255.0`, `192.168.1.1` |

The storage names used throughout are `cryptlvm` (opened LUKS device),
`vg0` (volume group), and `root` (logical volume). The root device is
therefore `/dev/mapper/vg0-root`, replacing the old `<ROOT>` placeholder.

## Prepare installation media

**Run on the machine preparing the USB.**

### Download and verify

Download the runit image and its signature from the
[Artix download page](https://artixlinux.org/download.php).
Use the signing key identified there.

```sh
gpg --keyserver pgpkeys.eu --recv-keys <KEY>
gpg --auto-key-retrieve --verify <SIG_FILE> <ISO_FILE>
```

### Write the USB

This overwrites `<USB>`. Check the device before writing.

```sh
sudo dd if=<ISO_FILE> iflag=nocache of=<USB> oflag=direct status=progress
sync
```

Boot the USB in UEFI mode.

## Prepare the live environment

**Run on the live USB unless a step says otherwise.**

### Become root and set the keyboard

```sh
su
ls /usr/share/kbd/keymaps/i386/qwerty/
loadkeys us
```

The live session uses `us` here; the installed console configuration below
retains `us-acentos`. Choose the layout you intend to use when entering the
disk passphrase.

### Connect to Wi-Fi

Start ConnMan's interactive prompt:

```sh
connmanctl
```

Inside `connmanctl`, run:

```text
enable wifi
scan wifi
services
agent on
connect <WIFI_SERVICE>
quit
```

Use the full identifier printed by `services`; enter the Wi-Fi password when
prompted. Back in the shell, check connectivity:

```sh
ping -c 3 1.1.1.1
ping -c 3 artixlinux.org
```

### Remote installation over SSH (optional)

On the live system, enable SSH and find its IP address:

```sh
ln -s /etc/runit/sv/sshd /run/runit/service/
ip a
```

On the second machine, connect:

```sh
ssh artix@<IP>
```

In the SSH session, run `su` before continuing.

## Prepare storage

**Run as root on the live USB.** The following steps erase the selected disk.

### Identify and prepare the disk

```sh
lsblk
fdisk -l
```

The original preparation includes filling the target disk with random data:

```sh
dd if=/dev/urandom of=<DISK>
```

### Create partitions

```sh
cfdisk <DISK>
```

Use a GPT partition table:

| Partition | Size | Partition type | Filesystem / role | Installed mount point |
| --- | --- | --- | --- | --- |
| `<EFI_PART>` (D1) | 3G | EFI System | FAT32, EFI bootloader files | `/efi` |
| `<LUKS_PART>` (D2) | Remaining space | Linux LUKS | LUKS1 containing LVM and ext4 root | `/` through `vg0-root` |

`/boot` is a directory on the encrypted root filesystem.

### Encrypt and format

```sh
cryptsetup luksFormat --type luks1 <LUKS_PART>
cryptsetup open <LUKS_PART> cryptlvm
pvcreate /dev/mapper/cryptlvm
vgcreate vg0 /dev/mapper/cryptlvm
lvcreate -l +100%FREE vg0 -n root
mkfs.ext4 -L root /dev/mapper/vg0-root
mkfs.vfat -F32 <EFI_PART>
```

### Mount the filesystems

Mount root first, then create and mount the EFI directory beneath it:

```sh
mount /dev/mapper/vg0-root /mnt
mkdir -p /mnt/efi
mount <EFI_PART> /mnt/efi
lsblk -f
```

## Install and configure the system

### Select mirrors and install the base system

**Still on the live USB, as root.** Put nearby mirrors first:

```sh
vi /etc/pacman.d/mirrorlist
```

Install the base packages:

```sh
basestrap /mnt base base-devel runit elogind-runit grub linux linux-firmware \
    intel-ucode efibootmgr lvm2 mkinitcpio vi cryptsetup cryptsetup-runit \
    lvm2-runit git
```

### Generate fstab and enter the installed system

```sh
fstabgen -U /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab
```

Check that fstab includes `/` and `/efi`. Run the generation command once;
it appends entries. Then enter the installed system:

```sh
artix-chroot /mnt
```

**From here until the first-boot section, run commands as root inside the chroot.**

### Console, time zone, and locale

Edit `/etc/vconsole.conf`:

```ini
FONT=lat5-16
KEYMAP=us-acentos
```

Set the time zone and hardware clock:

```sh
ln -sf /usr/share/zoneinfo/<ZONE> /etc/localtime
hwclock --systohc
```

In `/etc/locale.gen`, uncomment `en_US.UTF-8 UTF-8`, then run:

```sh
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
```

### Hostname and hosts

```sh
echo <HOSTNAME> > /etc/hostname
```

Edit `/etc/hosts`, using the same hostname:

```text
127.0.0.1 localhost
::1 localhost
127.0.1.1 <HOSTNAME>.localdomain <HOSTNAME>
```

### Passwords and regular user

Set the root password, create your user, and set its password:

```sh
passwd
useradd -m <USER>
passwd <USER>
pacman -S --needed sudo
visudo
```

Add this line using `visudo`:

```sudoers
<USER> ALL=(ALL) ALL
```

### Install networking tools

Install networking tools while the live environment still provides connectivity.
The live USB's network connection is separate from the installed system.

```sh
pacman -S --needed connman connman-runit iwd iwd-runit dbus-runit
```

Select iwd as ConnMan's Wi-Fi backend. Create or edit
`/etc/runit/sv/connmand/conf`, adding this option to any existing `OPTS`:

```sh
OPTS="--wifi=iwd_agent"
```

Artix's [ConnMan service definition](https://github.com/artix-linux/initsys/blob/master/connman-runit/trunk/connmand.run)
loads this file. See [ConnMan with iwd](https://wiki.archlinux.org/title/ConnMan#Using_iwd_instead_of_wpa_supplicant)
for the backend option; the service configuration here uses runit.

## Configure encrypted boot

**Run as root inside the chroot.** Complete the configuration edits before
generating the boot files.

### Create the keyfile

Choose an absolute `<CRYPT_FILE>` path in an existing directory on the encrypted
root filesystem, such as `/root/cryptlvm.key`. Use the same path below.

```sh
dd bs=512 count=4 if=/dev/urandom of=<CRYPT_FILE>
chmod 000 <CRYPT_FILE>
cryptsetup luksAddKey <LUKS_PART> <CRYPT_FILE>
```

The keyfile lets the initramfs unlock root after GRUB has already asked for the
disk passphrase. See the
[encrypted-boot keyfile explanation](https://wiki.archlinux.org/title/dm-crypt/Encrypting_an_entire_system#Avoiding_having_to_enter_the_passphrase_twice).

### Configure the initramfs

Edit `/etc/mkinitcpio.conf`. Add the keyfile to `FILES`, preserving any existing
entries, and configure the hooks for local encrypted storage:

```bash
FILES=(<CRYPT_FILE>)
HOOKS=(base udev autodetect keyboard keymap consolefont modconf block encrypt lvm2 filesystems fsck)
```

`encrypt` precedes `lvm2` because the volume group lives inside LUKS.
Network services are configured after boot.

### Configure GRUB

Find the UUID of the encrypted partition:

```sh
blkid -s UUID -o value <LUKS_PART>
```

Use that value for `<LUKS_UUID>`, rather than the UUID of the EFI partition or
the ext4 filesystem.

Edit these settings in `/etc/default/grub`, replacing existing definitions:

```ini
GRUB_ENABLE_CRYPTODISK=y
GRUB_CMDLINE_LINUX="cryptdevice=UUID=<LUKS_UUID>:cryptlvm root=/dev/mapper/vg0-root rw intel_pstate=no_hwp cryptkey=rootfs:<CRYPT_FILE>"
GRUB_TIMEOUT=15
GRUB_GFXMODE=1024x768
```

The `intel_pstate=no_hwp` option is the original machine-specific preference.

### Generate boot files

The EFI partition mounted at `/mnt/efi` on the live USB is available as
`/efi` inside the chroot. Confirm that mount before installing GRUB:

```sh
findmnt /efi
```

Then run:

```sh
mkinitcpio -p linux
chmod 600 /boot/initramfs-linux*
chmod 700 /boot
grub-install --target=x86_64-efi --efi-directory=/efi
grub-mkconfig -o /boot/grub/grub.cfg
```

The initramfs contains the keyfile, so its permissions are restricted after it is
generated. Resolve any generation or installation errors before rebooting.

## First boot

### Leave the chroot and reboot

Exit the chroot:

```sh
exit
```

Back on the live USB:

```sh
umount -R /mnt
reboot
```

Remove the installation USB when the machine restarts. Unlock the disk at the
GRUB prompt, then log in locally as root.

### Check the installed system

```sh
findmnt /
findmnt /efi
lsblk -f
```

Confirm that root uses `vg0-root` and the EFI partition is mounted at `/efi`.
Set up the network below before installing more packages.

### Connect to the network

**Run as root on the installed system.**

Enable the installed runit services, skipping links that already exist:

```sh
ln -s /etc/runit/sv/dbus /run/runit/service/
ln -s /etc/runit/sv/iwd /run/runit/service/
ln -s /etc/runit/sv/connmand /run/runit/service/
sv status dbus iwd connmand
```

ConnMan handles IP configuration. Wired connections normally use DHCP.
For Wi-Fi, find the wireless device and scan with iwd:

```sh
connmanctl enable wifi
iwctl device list
iwctl station <WIFI_DEVICE> scan
iwctl station <WIFI_DEVICE> get-networks
iwctl station <WIFI_DEVICE> connect "<SSID>"
```

Enter the password when prompted. These commands follow the
[iwd connection instructions](https://wiki.archlinux.org/title/Iwd#Connect_to_a_network).
ConnMan supplies DHCP in this setup; leave iwd's standalone network
configuration disabled.

List ConnMan's services:

```sh
connmanctl services
```

For a static wired connection, use its full `ethernet_…` service identifier:

```sh
connmanctl config <ETHERNET> --ipv4 manual <ADDRESS> <NETMASK> <GATEWAY>
connmanctl config <ETHERNET> --nameservers 1.1.1.1 1.0.0.1
```

Check connectivity and DNS:

```sh
ping -c 3 1.1.1.1
ping -c 3 artixlinux.org
```

## Personal setup

These sections contain the original personal preferences and package selections.

### SSH (optional)

As root, install and enable SSH on the installed system:

```sh
pacman -S openssh-runit
ln -s /etc/runit/sv/sshd /run/runit/service/
```

Use your regular user when connecting remotely.

### Continue as your regular user

Log in as the user created during installation. The remaining shell commands
run as that user, with `sudo` where needed.

### Package manager preferences

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

### AUR helper

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

### Shell

Install Zsh before selecting it:

```sh
sudo pacman -S zsh
chsh -s /usr/bin/zsh
```

Log out and back in to use the new login shell.

### Editor and plugins

```sh
yay -S neovim vim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

Put your vim-plug plugin declarations in `~/.config/nvim/init.vim`
(or load an equivalent configuration from your dotfiles). This repository
does not contain a plugin list. Follow the
[vim-plug configuration instructions](https://github.com/junegunn/vim-plug#usage).

Once that configuration is loaded, run this **inside Neovim**:

```vim
:PlugInstall
```

### Sudo preferences (optional)

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

### Python and older editor dependencies (optional)

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

### Bluetooth

```sh
yay -S bluez-runit bluez bluez-utils
```

To reset the Bluetooth radio's blocked state:

```sh
sudo rfkill block bluetooth
sudo rfkill unblock bluetooth
```

### Other packages

```sh
yay -S git zathura zathura-djvu zathura-ps zathura-pdf-mupdf mpd mpv ncmcpp \
    newsboat picom tmux weechat feh htim lf nsxiv firefox unzip vimv wget \
    parcellite-git pass xorg-xsetroot xclip dash dashbin bc fdupes ffmpeg \
    imagemagick hdparm ibus maim playerctl
```
