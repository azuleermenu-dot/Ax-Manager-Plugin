#!/system/bin/sh
if [ "$AXERON" != "true" ]; then abort "AxManager environment required."; fi
if [ "$AXERONVER" -lt 30000 ]; then abort "AxManager server 30000 or newer required."; fi
ui_print "AX CODM Garena Optimizer 0.2.0"
ui_print "Read-only hardware and CODM diagnostics."
