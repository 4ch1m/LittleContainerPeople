#!/bin/bash

[[ -f "/${LCP_BIN}" ]] || { echo "LCP binary not found"; exit 1; }

VICE_OPTS+="-fullscreen "
VICE_OPTS+="+sound "
VICE_OPTS+="-silent "
VICE_OPTS+="${LCP_VICE_OPTS}"

echo "exec x64 ${VICE_OPTS} '/${LCP_BIN}'" > ~/.xinitrc
chmod +x ~/.xinitrc

/usr/share/novnc/utils/launch.sh \
    --listen 6081 \
    --vnc localhost:5900 &

/usr/bin/x11vnc \
    -create \
    -clip 720x550+0+0 \
    -forever
