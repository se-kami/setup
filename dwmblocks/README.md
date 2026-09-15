# dwmblocks modules

[Back to setup](../README.md)

Personal status-bar modules for dwmblocks.

| Module | Information / controls |
| --- | --- |
| [dwmblocks-graphics-card.sh](dwmblocks-graphics-card.sh) | GPU usage and temperature |
| [dwmblocks-cpu.sh](dwmblocks-cpu.sh) | CPU information |
| [dwmblocks-date.sh](dwmblocks-date.sh) | Date |
| [dwmblocks-network-traffic.sh](dwmblocks-network-traffic.sh) | Upload and download rates |
| [dwmblocks-memory.sh](dwmblocks-memory.sh) | Memory usage |
| [dwmblocks-battery.sh](dwmblocks-battery.sh) | Battery percentage and time remaining |
| [dwmblocks-bluetooth.sh](dwmblocks-bluetooth.sh) | Bluetooth status and controls |
| [dwmblocks-char.sh](dwmblocks-char.sh) | Charging status |
| [dwmblocks-keyboard.sh](dwmblocks-keyboard.sh) | Keyboard layout |
| [dwmblocks-mic.sh](dwmblocks-mic.sh) | Microphone status |
| [dwmblocks-wifi.sh](dwmblocks-wifi.sh) | Wi-Fi information |
| [dwmblocks-temp.sh](dwmblocks-temp.sh) | Temperature |
| [dwmblocks-mute.sh](dwmblocks-mute.sh) | Mute state and toggle |
| [dwmblocks-mpc.sh](dwmblocks-mpc.sh) | Music status |
| [dwmblocks-sound.sh](dwmblocks-sound.sh) | Sound information |

## Use the modules

Configure your dwmblocks build to invoke the selected scripts by their installed
paths. The dwmblocks application itself is not included here.

Review each module's dependencies and local settings, including device names,
Bluetooth addresses, fonts, and helper command names. Interactive modules use
the `BUTTON` environment variable supplied by compatible dwmblocks builds.

The related [desktop helpers](../scripts/desktop/) include `updatebar` and
`blocks-check-reset`. Their signal numbers and command paths must match your
dwmblocks configuration.
