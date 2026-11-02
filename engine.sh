#!/system/bin/sh
# Read-only diagnostics; no system settings are modified.
ACTION="${1:-snapshot}"
prop() { getprop "$1" 2>/dev/null | head -n 1; }
case "$ACTION" in
snapshot)
 echo "model=$(prop ro.product.model)"
 echo "manufacturer=$(prop ro.product.manufacturer)"
 echo "device=$(prop ro.product.device)"
 echo "android=$(prop ro.build.version.release)"
 echo "sdk=$(prop ro.build.version.sdk)"
 echo "abi=$(prop ro.product.cpu.abi)"
 echo "kernel=$(uname -r 2>/dev/null)"
 echo "cores=$(grep -c '^processor' /proc/cpuinfo 2>/dev/null)"
 echo "cpu=$(grep -m 1 'Hardware\|Processor' /proc/cpuinfo 2>/dev/null | cut -d: -f2- | sed 's/^ *//')"
 awk '/MemTotal:/ {print "ram_total_kb=" $2} /MemAvailable:/ {print "ram_available_kb=" $2}' /proc/meminfo 2>/dev/null
 echo "battery=$(dumpsys battery 2>/dev/null | awk -F': ' '/level:/{print $2; exit}')"
 echo "battery_temp_tenths=$(dumpsys battery 2>/dev/null | awk -F': ' '/temperature:/{print $2; exit}')"
 echo "uid=$(id -u 2>/dev/null)"
 echo "selinux=$(id -Z 2>/dev/null)"
 echo "axeron_version=${AXERONVER:-unknown}"
 echo "gpu_hint=$(getprop ro.hardware.egl 2>/dev/null)"
 df -k /data 2>/dev/null | tail -n 1 | awk '{print "data_total_kb=" $2; print "data_used_kb=" $3; print "data_free_kb=" $4}'
 ;;
codm)
 if pm path com.garena.game.codm >/dev/null 2>&1; then echo "installed=true"; else echo "installed=false"; fi
 ;;
thermal)
 found=0
 for f in /sys/class/thermal/thermal_zone*/temp; do
  [ -r "$f" ] || continue
  z=${f%/temp}; t=$(cat "$z/type" 2>/dev/null); v=$(cat "$f" 2>/dev/null)
  [ -n "$v" ] || continue
  echo "zone_${z##*/}=${t:-unknown},$v"; found=1
 done
 [ "$found" -eq 1 ] || echo "thermal=unavailable"
 ;;
network)
 echo "interfaces:"; ip -brief addr 2>/dev/null || ip addr 2>/dev/null
 echo "routes:"; ip route 2>/dev/null | head -n 5
 ;;
game-modes)
 pm path com.garena.game.codm >/dev/null 2>&1 || { echo "CODM Garena is not installed."; exit 2; }
 cmd game list-modes com.garena.game.codm 2>&1
 ;;
*) echo "Usage: engine.sh {snapshot|codm|thermal|network|game-modes}"; exit 2 ;;
esac
