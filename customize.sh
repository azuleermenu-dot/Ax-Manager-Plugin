#!/system/bin/sh
if [ "$AXERON" != "true" ]; then abort "AxManager environment required."; fi
case "$AXERONVER" in ''|*[!0-9]*) abort "Could not determine AxManager server version." ;; esac
if [ "$AXERONVER" -lt 30000 ]; then abort "AxManager server 30000 or newer required."; fi
ui_print "AX CODM Garena Optimizer 0.4.0"
ui_print "Read-only hardware and CODM diagnostics."
