# EssoraFM Picom packaging notes

This source tree builds the EssoraFM-specific Picom fork as `essorafm-picom`.

Version: `1.2.0`

The build installs the compositor and EssoraFM integration files under `/usr/local/essorafm`:

- `/usr/local/essorafm/bin/essorafm-picom`
- `/usr/local/essorafm/bin/essorafm-picom-inspect`
- `/usr/local/essorafm/bin/essora-picom-gui.sh`
- `/usr/local/essorafm/ui/icons/essora-picom.svg`
- `/usr/local/essorafm/defaults/essorafm-picom.conf`
- `/usr/local/essorafm/licenses/essorafm-picom/`

This fork does not install upstream standalone application or autostart launchers.
EssoraFM controls compositor startup from desktop mode.

## Build a Debian package without installing

```bash
./packaging/build-essorafm-picom-deb.sh
```

The package is created at:

```text
/root/essorafm-picom_1.2.0_amd64.deb
```

Review it with:

```bash
dpkg-deb -c /root/essorafm-picom_1.2.0_amd64.deb
```
