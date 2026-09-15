# Neovim configuration

[Back to setup](../../README.md)

- [init.vim](init.vim): settings, mappings, and vim-plug declarations.
- [filetype.vim](filetype.vim): filetype detection.
- [snippets/](snippets/): UltiSnips snippets for general use, C, Python, and TeX.

## Use the configuration

Install Neovim and vim-plug using the
[editor setup instructions](../../docs/post-install.md#editor-and-plugins).
Merge or relocate any existing configuration before creating links.

Run from the root of the `setup` checkout:

```sh
SETUP_DIR="$PWD"
mkdir -p "$HOME/.config/nvim"
ln -s "$SETUP_DIR/config/nvim/init.vim" "$HOME/.config/nvim/init.vim"
ln -s "$SETUP_DIR/config/nvim/filetype.vim" "$HOME/.config/nvim/filetype.vim"
ln -s "$SETUP_DIR/config/nvim/snippets" "$HOME/.config/nvim/my_snippets"
```

The snippet destination is `my_snippets` because that is the directory named in
`g:UltiSnipsSnippetDirectories`. Link the individual files so downloaded plugins
under `~/.config/nvim/plugged` stay outside this checkout.

Open Neovim and install the declared plugins:

```vim
:PlugInstall
```

The configuration includes LaTeX, Python, and external-tool integrations.
Their dependencies depend on which features you use.
