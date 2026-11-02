#!/usr/bin/env bash
# Install the Zedless portable Linux build into the current user's XDG dirs.
set -euo pipefail
here=$(cd "$(dirname "$0")" && pwd)

prefix=${PREFIX:-$HOME/.local}
libdir=$prefix/lib/zedless
bindir=$prefix/bin
appdir=$prefix/share/applications
icondir=$prefix/share/icons/hicolor/512x512/apps

[[ -x $here/zedless ]] || { echo "zedless binary not found next to this script" >&2; exit 1; }

install -d "$libdir" "$bindir" "$appdir" "$icondir"
install -m755 "$here/zedless" "$libdir/zedless"
install -m644 "$here/zedless.png" "$icondir/zedless.png"

cat > "$bindir/zedless" <<EOF
#!/usr/bin/env bash
exec "$libdir/zedless" "\$@"
EOF
chmod 755 "$bindir/zedless"

cat > "$appdir/dev.zedless.Zedless.desktop" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Zedless
GenericName=Text Editor
Comment=A lightweight, local-first fork of Zed
TryExec=$bindir/zedless
Exec=$bindir/zedless %F
Icon=zedless
Terminal=false
StartupNotify=true
StartupWMClass=dev.zedless.Zedless
Categories=Development;TextEditor;IDE;
MimeType=text/plain;application/x-zerosize;
EOF

command -v update-desktop-database >/dev/null && update-desktop-database "$appdir" >/dev/null 2>&1 || true
command -v gtk-update-icon-cache >/dev/null && gtk-update-icon-cache -q -t "$prefix/share/icons/hicolor" >/dev/null 2>&1 || true

echo "Installed Zedless:"
echo "  binary   $libdir/zedless"
echo "  launcher $bindir/zedless"
echo "  desktop  $appdir/dev.zedless.Zedless.desktop"
echo "Run 'zedless /path/to/project' or open Zedless from the application menu."
