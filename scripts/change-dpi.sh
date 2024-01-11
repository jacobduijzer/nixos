#!/usr/bin/env bash

dpi=$1

# For GTK 3 applications
if [ "${dpi}" == "192" ]; then
  export GDK_SCALE=4
  export GDK_DPI_SCALE=0.5
else
  export GDK_SCALE=1
  export GDK_DPI_SCALE=1
fi

# For GTK 3 applications
cat >~/.xsettingsd <<EOF
Xft/DPI $(($dpi * 1024))
Gdk/WindowScalingFactor $(($dpi / 96))
Gdk/UnscaledDPI $(($dpi * 1024 / ($dpi / 96)))
EOF
pkill -HUP xsettingsd || xsettingsd &

# For Qt applications
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_SCALE_FACTOR_ROUNDING_POLICY=PassThrough

# For miscellaneous applications
xrdb -merge <<EOF
Xft.dpi: ${dpi}

! These might also be useful depending on your monitor and personal preference:
Xft.autohint: 0
Xft.lcdfilter: lcddefault
Xft.hintstyle: hintfull
Xft.hinting: 1
Xft.antialias: 1
Xft.rgba: rgb
EOF
