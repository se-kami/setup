# Scripts

[Back to setup](../README.md)

Personal command-line utilities. Script names are preserved from `shell-utils`.

## Index

| Location | Scripts |
| --- | --- |
| [runit/](runit/) | `sv-start`, `sv-stop`, `sv-restart`, `sv-status`, `sv-status-all`, `sv-kill`, `sv-quit`, `sv-shutdown` |
| [network/](network/) | `iwscan`, `ping-checker`, `cliForex`, `cliForexpy` |
| [media/](media/) | `audio-control`, `pulse-menu`, `ff-cut`, `ff-cut-5` |
| [desktop/](desktop/) | `browse`, `browser`, `dmenu.uri.sh`, `dragonDL`, `typefast`, `xinput-enable`, `xinput-disable`, `blocks-check-reset`, `updatebar` |
| [mime-check](mime-check) | Inspect a file's MIME type |
| [pdf-reduce](pdf-reduce) | Reduce PDF size with Ghostscript |
| [pcoff](pcoff) | Check for open Vim processes before shutting down |
| [pipupdate](pipupdate) | Update Python packages |

The runit helpers use `/run/runit/service` and most select services with `fzf`.
Other scripts depend on their corresponding tools, such as iwd, FFmpeg,
Ghostscript, audio utilities, or X11 programs.

## Use a script

Read the script to check its arguments, dependencies, and machine-specific
settings. Run it by its path, or link selected commands into `~/.local/bin`.

For example, from the root of this checkout:

```sh
SETUP_DIR="$PWD"
mkdir -p "$HOME/.local/bin"
ln -s "$SETUP_DIR/scripts/network/iwscan" "$HOME/.local/bin/iwscan"
```

Use a free destination path. Add `~/.local/bin` to your shell's `PATH` if needed:

```sh
export PATH="$HOME/.local/bin:$PATH"
```

Keep command names when creating links: some utilities call each other by name.
For example, `blocks-check-reset` invokes `updatebar`, so expose both when using
that pair.

## Notes

- `cliForexpy` is a Python script and imports `requests` and the external
  `diagram` module referenced in its source.
- The utilities retain their original behavior and service/API assumptions.
- The old script index mentioned `passgen`, but the source repository did not
  contain that file; it is not included here.
