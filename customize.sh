#!/system/bin/sh
if [ "${AXERON:-false}" != "true" ]; then abort "AxManager environment required."; fi
if [ "${AXERONVER:-0}" -lt 30000 ]; then abort "AxManager server 30000 or newer required."; fi
ui_print "AX CODM Garena Optimizer 0.1.0"
ui_print "Read-only foundation; no Android settings will be changed."
