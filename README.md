<p align="center">
  <img src="essora/assets/essora-picom.svg" alt="EssoraFM Picom" width="160">
</p>

<h1 align="center">EssoraFM Picom</h1>

<p align="center">
  A custom EssoraFM-oriented fork of <a href="https://github.com/yshui/picom">yshui/picom</a>.
</p>

<p align="center">
  <strong>Version 1.2.0</strong>
</p>

---

## About

EssoraFM Picom is a fork of [yshui/picom](https://github.com/yshui/picom), adapted for the EssoraFM desktop experience.

It integrates an X11 compositor, rounded corners, shadows and its own graphical configuration tool under:

```text
/usr/local/essorafm
```

The goal of this fork is to make Picom feel like a native part of the Essora desktop instead of a separate external compositor.

EssoraFM Picom is designed to be controlled by EssoraFM desktop mode, using per-user configuration files and without installing external `picom.desktop` or `compton.desktop` autostart launchers.

---

## Main Features

- Fork of `yshui/picom`
- Designed for EssoraFM desktop mode
- Rounded window corners
- Window shadows
- Optional transparency support
- Optional blur support
- Optional fading support
- YAD-based graphical configuration tool
- Per-user configuration under `~/.config/essorafm`
- Runtime logs under `~/.cache/essorafm`
- Integrated icon and default configuration
- No `picom.desktop`
- No `compton.desktop`
- No external compositor autostart file required
- Intended for X11-based Essora sessions

---

## Installation Layout

EssoraFM Picom installs its files inside the EssoraFM directory:

```text
/usr/local/essorafm/bin/essorafm-picom
/usr/local/essorafm/bin/essora-picom-gui.sh
/usr/local/essorafm/ui/icons/essora-picom.svg
/usr/local/essorafm/defaults/essorafm-picom.conf
/usr/local/essorafm/licenses/
```

User configuration is stored in:

```text
~/.config/essorafm/essorafm-picom.conf
~/.config/essorafm/config.ini
```

Runtime files are stored in:

```text
~/.cache/essorafm/essorafm-picom.pid
~/.cache/essorafm/essorafm-picom.log
```

---

## Default Configuration

The default configuration is installed at:

```text
/usr/local/essorafm/defaults/essorafm-picom.conf
```

On first use, EssoraFM can copy it to:

```text
~/.config/essorafm/essorafm-picom.conf
```

The default configuration is intentionally simple and conservative:

```text
Rounded corners: enabled
Shadows: enabled
Transparency: disabled
Blur: disabled
Backend: glx
Corner radius: 15
```

Main default values:

```text
corner-radius = 15
shadow = true
shadow-radius = 12
shadow-opacity = 1
inactive-opacity = 1
active-opacity = 1
frame-opacity = 1
blur-method = "none"
backend = "glx"
vsync = true
```

This provides a clean visual style for EssoraFM without making windows transparent by default.

---

## Essora Picom GUI

EssoraFM Picom includes a graphical configuration tool:

```text
/usr/local/essorafm/bin/essora-picom-gui.sh
```

The GUI allows the user to configure:

- Rounded corners
- Shadows
- Transparency
- Blur
- Fading
- Backend
- VSync
- Window type behavior
- Backup and restore of configuration
- Start EssoraFM Picom
- Stop EssoraFM Picom

The GUI uses the Essora Picom icon:

```text
/usr/local/essorafm/ui/icons/essora-picom.svg
```

The source asset used in this repository is:

```text
essora/assets/essora-picom.svg
```

---

## EssoraFM Integration

EssoraFM Picom is intended to be managed by EssoraFM.

It does not install:

```text
picom.desktop
compton.desktop
```

This avoids conflicts with system-wide compositor autostart entries.

EssoraFM can control the compositor using:

```text
~/.config/essorafm/config.ini
```

Example:

```ini
[Compositor]
CompositorEnabled = true
CompositorBinary = /usr/local/essorafm/bin/essorafm-picom
CompositorConfig = ~/.config/essorafm/essorafm-picom.conf
CompositorStopWithDesktop = true
```

When the compositor is disabled from the GUI, the configuration can be changed to:

```ini
[Compositor]
CompositorEnabled = false
```

This prevents EssoraFM desktop mode from starting the compositor again automatically.

---

## Build and Compilation

EssoraFM Picom is built using Meson and Ninja, like the original picom project.

### Install build dependencies

On Essora, Devuan, Debian or compatible systems:

```bash
sudo apt update

sudo apt install -y \
  build-essential meson ninja-build pkg-config cmake git \
  libconfig-dev libev-dev libgl-dev libegl-dev libepoxy-dev \
  libpcre2-dev libpixman-1-dev uthash-dev \
  libx11-dev libx11-xcb-dev \
  libxcb1-dev libxcb-composite0-dev libxcb-damage0-dev \
  libxcb-glx0-dev libxcb-image0-dev libxcb-present-dev \
  libxcb-randr0-dev libxcb-render0-dev libxcb-render-util0-dev \
  libxcb-shape0-dev libxcb-sync-dev libxcb-util-dev libxcb-xfixes0-dev \
  yad procps
```

### Clone the repository

```bash
git clone https://github.com/josejp2424/essorafm-picom.git
cd essorafm-picom
```

If your repository uses another GitHub username or organization, replace the URL with your real repository URL.

### Configure the build

EssoraFM Picom should be built with the installation prefix set to:

```text
/usr/local/essorafm
```

Run:

```bash
rm -rf build-essorafm

meson setup build-essorafm \
  --prefix=/usr/local/essorafm \
  --bindir=bin \
  --buildtype=release \
  -Dwith_docs=false \
  -Dcompton=false \
  -Ddbus=false \
  -Dopengl=true \
  -Dregex=true
```

This configuration:

- Installs the binary under `/usr/local/essorafm/bin`
- Enables OpenGL/GLX support
- Disables DBus support
- Disables documentation build
- Disables old Compton compatibility
- Avoids installing external desktop/autostart launchers

### Compile

```bash
ninja -C build-essorafm
```

### Install directly

To install directly into the system:

```bash
sudo ninja -C build-essorafm install
```

After installation, the expected files are:

```text
/usr/local/essorafm/bin/essorafm-picom
/usr/local/essorafm/bin/essora-picom-gui.sh
/usr/local/essorafm/ui/icons/essora-picom.svg
/usr/local/essorafm/defaults/essorafm-picom.conf
/usr/local/essorafm/licenses/
```

---

## Build Without Installing

To test the installation layout without installing into the real system, use `DESTDIR`:

```bash
rm -rf /root/essorafm-picom-pkg

DESTDIR=/root/essorafm-picom-pkg ninja -C build-essorafm install
```

Then inspect the generated tree:

```bash
find /root/essorafm-picom-pkg -type f
```

You should see files similar to:

```text
/root/essorafm-picom-pkg/usr/local/essorafm/bin/essorafm-picom
/root/essorafm-picom-pkg/usr/local/essorafm/bin/essora-picom-gui.sh
/root/essorafm-picom-pkg/usr/local/essorafm/ui/icons/essora-picom.svg
/root/essorafm-picom-pkg/usr/local/essorafm/defaults/essorafm-picom.conf
/root/essorafm-picom-pkg/usr/local/essorafm/licenses/
```

---

## Build a Debian Package

This repository includes a packaging helper script.

To build the `.deb` package:

```bash
./packaging/build-essorafm-picom-deb.sh
```

The package will be created at:

```text
/root/essorafm-picom_1.2.0_amd64.deb
```

To inspect the package contents:

```bash
dpkg-deb -c /root/essorafm-picom_1.2.0_amd64.deb
```

To inspect package metadata:

```bash
dpkg-deb -I /root/essorafm-picom_1.2.0_amd64.deb
```

To install the package:

```bash
sudo dpkg -i /root/essorafm-picom_1.2.0_amd64.deb
```

---

## Runtime Dependencies

The runtime package may require:

```text
libc6
libconfig9
libev4
libpcre2-8-0
libpixman-1-0
libx11-6
libx11-xcb1
libxcb1
libxcb-composite0
libxcb-damage0
libxcb-glx0
libxcb-image0
libxcb-present0
libxcb-randr0
libxcb-render0
libxcb-render-util0
libxcb-shape0
libxcb-sync1
libxcb-util1
libxcb-xfixes0
libepoxy0
libgl1
yad
procps
```

---

## Manual Usage

Check the installed binary:

```bash
/usr/local/essorafm/bin/essorafm-picom --version
```

Open the graphical configuration tool:

```bash
/usr/local/essorafm/bin/essora-picom-gui.sh
```

Start EssoraFM Picom manually:

```bash
/usr/local/essorafm/bin/essorafm-picom \
  --config ~/.config/essorafm/essorafm-picom.conf
```

Stop EssoraFM Picom manually:

```bash
pkill -x essorafm-picom
```

View the log:

```bash
cat ~/.cache/essorafm/essorafm-picom.log
```

---

## Project Layout

```text
essorafm-picom/
├── essora/
│   └── assets/
│       └── essora-picom.svg
├── defaults/
│   └── essorafm-picom.conf
├── packaging/
│   └── build-essorafm-picom-deb.sh
├── LICENSE
├── LICENSES/
├── README.md
└── source files inherited from picom
```

---

## License

EssoraFM Picom is a fork of `yshui/picom`.

The original picom source code remains licensed under:

```text
SPDX-License-Identifier: MPL-2.0 AND MIT
```

The preferred license for new source files inherited from the picom project is:

```text
SPDX-License-Identifier: MPL-2.0
```

EssoraFM-specific integration files, scripts, packaging files, default configuration files, GUI helpers and Essora-specific assets are licensed under:

```text
SPDX-License-Identifier: GPL-3.0-or-later
```

Full license texts are available in the `LICENSE` file and the `LICENSES` directory.

---

## Credits

EssoraFM Picom is based on:

```text
https://github.com/yshui/picom
```

picom itself is based on xcompmgr, originally written by Keith Packard, with contributions from many developers.

EssoraFM integration, packaging, GUI adaptation and Essora-specific files:

```text
josejp2424 <puppylinuxjosejp2424@gmail.com>
```

---

## Status

EssoraFM Picom 1.2.0 is intended for EssoraFM desktop integration and testing.

It is designed for X11-based Essora sessions and may not apply to Wayland sessions.
