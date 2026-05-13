#!/bin/bash
set -euo pipefail

# Build EssoraFM Picom without installing it into the live system.
# Output package: /root/essorafm-picom_1.2.0_amd64.deb

PKG_NAME="essorafm-picom"
PKG_VERSION="1.2.0"
ARCH="amd64"
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
BUILD_DIR="$ROOT_DIR/build-essorafm"
PKG_DIR="/root/${PKG_NAME}-${PKG_VERSION}-pkg"
DEB_FILE="/root/${PKG_NAME}_${PKG_VERSION}_${ARCH}.deb"

rm -rf "$BUILD_DIR" "$PKG_DIR" "$DEB_FILE"

meson setup "$BUILD_DIR" \
  --prefix=/usr/local/essorafm \
  --bindir=bin \
  --buildtype=release \
  -Dwith_docs=false \
  -Dcompton=false \
  -Ddbus=false \
  -Dopengl=true \
  -Dregex=true

ninja -C "$BUILD_DIR"

DESTDIR="$PKG_DIR" ninja -C "$BUILD_DIR" install

mkdir -p "$PKG_DIR/DEBIAN"
cat > "$PKG_DIR/DEBIAN/control" <<CONTROL
Package: ${PKG_NAME}
Version: ${PKG_VERSION}
Section: x11
Priority: optional
Architecture: ${ARCH}
Maintainer: josejp2424 <puppylinuxjosejp2424@gmail.com>
Depends: libc6, libconfig9, libev4, libpcre2-8-0, libpixman-1-0, libx11-6, libx11-xcb1, libxcb1, libxcb-composite0, libxcb-damage0, libxcb-glx0, libxcb-image0, libxcb-present0, libxcb-randr0, libxcb-render0, libxcb-render-util0, libxcb-shape0, libxcb-sync1, libxcb-util1, libxcb-xfixes0, libepoxy0, libgl1, yad, procps
Description: EssoraFM internal Picom compositor
 EssoraFM Picom is a custom Picom build used by EssoraFM desktop mode.
 It provides rounded corners, shadows and optional compositor effects for
 the Essora desktop environment.
 .
 This package also installs the Essora Picom GUI, the default EssoraFM
 compositor configuration, the Essora Picom icon and the license files.
CONTROL

chmod 0755 "$PKG_DIR/DEBIAN"

# Ensure no upstream standalone launcher/autostart files are packaged.
# No standalone launcher/autostart files are installed by this fork.

# Ensure GUI script is executable.
chmod 0755 "$PKG_DIR/usr/local/essorafm/bin/essora-picom-gui.sh"

dpkg-deb --build "$PKG_DIR" "$DEB_FILE"

echo "Created: $DEB_FILE"
echo "Package tree: $PKG_DIR"
echo "Review with: dpkg-deb -c $DEB_FILE"
