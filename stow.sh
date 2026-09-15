#!/usr/bin/env bash
# Link selected config packages into a home directory using GNU Stow.
set -euo pipefail

usage() {
    cat <<'EOF'
Usage: ./stow.sh [OPTIONS] [nvim zsh]

With no package names, manage both nvim and zsh.

  -n, --dry-run       Preview without changing files
  -D, --delete        Remove this checkout's links
  -R, --restow        Recreate this checkout's links after an update
  -t, --target DIR    Target an existing home directory (default: $HOME)
  -h, --help          Show this help

Existing files and links from other checkouts are reported as conflicts.
EOF
}

fail() { printf '%s\n' "$*" >&2; exit 2; }
root=$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
target=${HOME:?HOME must be set, or run this script from a normal user session}
action=--stow
dry_run=false
packages=()
while (($#)); do
    case "$1" in
        -h|--help) usage; exit 0 ;;
        -n|--dry-run) dry_run=true ;;
        -D|--delete|-R|--restow)
            [[ "$action" == --stow ]] || fail 'Choose only one of --delete or --restow.'
            case "$1" in -D|--delete) action=--delete ;; *) action=--restow ;; esac
            ;;
        -t|--target)
            (($# >= 2)) || fail '--target needs a directory.'
            target=$2; shift ;;
        --) shift; packages+=("$@"); break ;;
        -*) fail "Unknown option: $1" ;;
        *) packages+=("$1") ;;
    esac
    shift
done
((${#packages[@]})) || packages=(nvim zsh)
for package in "${packages[@]}"; do
    case "$package" in nvim|zsh) ;; *) fail "Unknown package: $package (choose nvim or zsh)." ;; esac
done
[[ -d "$target" ]] || fail "Target directory does not exist: $target"
# Resolve before changing working directories; this also handles spaces in paths.
target=$(CDPATH= cd -- "$target" && pwd)
if [[ "$action" != --delete ]]; then
    for package in "${packages[@]}"; do
        if [[ "$package" == nvim ]] && { [[ -e "$target/.config/nvim/init.vim" ]] || [[ -L "$target/.config/nvim/init.vim" ]]; }; then
            fail 'An older init.vim is present. Move it aside before linking the Lua Neovim config.'
        fi
    done
fi
command -v stow >/dev/null 2>&1 || fail 'Install GNU Stow before running this script.'
options=(--dir "$root/config" --target "$target" --no-folding --verbose "$action")
$dry_run && options+=(--simulate)
cd -- "$root"
stow "${options[@]}" "${packages[@]}"

# Zsh expects a writable completion-cache directory. Never create it in a preview.
if ! $dry_run && [[ "$action" != --delete ]]; then
    for package in "${packages[@]}"; do
        if [[ "$package" == zsh ]]; then
            mkdir -p -- "$target/.cache/zsh"
        fi
    done
fi
