# Zsh configuration

[Back to setup](../../README.md)

| File | Location used by the configuration |
| --- | --- |
| [env](env) | `~/.zshenv` |
| [dot-zshrc](dot-zshrc) | `~/.config/zsh/.zshrc` |
| [aliasrc](aliasrc) | `~/.config/aliasrc` |
| [fnrc](fnrc) | `~/.config/fnrc` |

`env` sets the XDG directories and `ZDOTDIR=$HOME/.config/zsh`.
The startup file loads the environment, aliases, and functions from the
locations above.

## Use the configuration

Review the files and merge any existing configuration before linking them.
Run these commands from the root of the `setup` checkout, using free destination
paths:

```sh
SETUP_DIR="$PWD"
mkdir -p "$HOME/.config/zsh" "$HOME/.cache/zsh"
ln -s "$SETUP_DIR/config/zsh/env" "$HOME/.zshenv"
ln -s "$SETUP_DIR/config/zsh/dot-zshrc" "$HOME/.config/zsh/.zshrc"
ln -s "$SETUP_DIR/config/zsh/aliasrc" "$HOME/.config/aliasrc"
ln -s "$SETUP_DIR/config/zsh/fnrc" "$HOME/.config/fnrc"
```

The configuration expects Zsh syntax highlighting at
`/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh`.
Several functions and bindings also use `fzf`, `lf`, Neovim, and other personal
tools; consult the relevant file before using a binding.

Start a new login session after linking the files. To expose selected utilities
as commands, follow the [scripts instructions](../../scripts/README.md).
