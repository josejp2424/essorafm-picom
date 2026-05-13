# EssoraFM Picom fork

This source is prepared to build the compositor binary used internally by EssoraFM.

Installed binary name:

```bash
/usr/local/essorafm/bin/essorafm-picom
```

Build example:

```bash
meson setup build-essorafm \
  --prefix=/usr/local/essorafm \
  --bindir=bin \
  --buildtype=release \
  -Dwith_docs=false \
  -Dcompton=false \
  -Ddbus=false \
  -Dopengl=true

ninja -C build-essorafm
sudo ninja -C build-essorafm install
```

EssoraFM starts this binary only when `essorafm --desktop` is used.

Keep upstream picom licenses with the package:

```bash
/usr/local/essorafm/licenses/picom/
```
