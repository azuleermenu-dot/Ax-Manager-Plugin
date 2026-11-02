#!/system/bin/sh
# AX CODM diagnostics engine. Read-only; no system settings or game files are changed.
ACTION=$1
[ -n "$ACTION" ] || ACTION=snapshot
prop() { getprop "$1" 2>/dev/null | head -n 1; }
first_prop() {
  for key in "$@"; do value=$(prop "$key"); if [ -n "$value" ]; then echo "$value"; return; fi; done
}
soc_value() { first_prop ro.soc.model ro.vendor.soc.model ro.board.platform ro.mediatek.platform ro.hardware; }
gpu_value() {
  value=$(first_prop ro.hardware.egl ro.opengles.version)
  renderer=$(dumpsys SurfaceFlinger 2>/dev/null | grep -i -m 1 'GLES:' | sed 's/^[[:space:]]*//')
  [ -n "$renderer" ] && value=$renderer
  [ -n "$value" ] && echo "$value" || echo unavailable
}
codm_state() {
  if pm path com.garena.game.codm >/dev/null 2>&1; then echo "codm_installed=true"; else echo "codm_installed=false"; fi
  pid=$(pidof com.garena.game.codm 2>/dev/null | awk '{print $1}')
  if [ -n "$pid" ]; then echo "codm_running=true"; echo "codm_pid=$pid"; else echo "codm_running=false"; echo "codm_pid=unavailable"; fi
}
cpu_freqs() {
  for f in /sys/devices/system/cpu/cpu[0-9]*/cpufreq/scaling_cur_freq; do
    [ -r "$f" ] || continue
    core=$(echo "$f" | sed 's#/cpufreq/scaling_cur_freq##;s#.*/##')
    echo "$core"_khz="$(cat "$f" 2>/dev/null)"
  done
}
cpu_ticks() { awk '/^cpu / {total=$2+$3+$4+$5+$6+$7+$8; idle=$5+$6; print total, idle; exit}' /proc/stat 2>/dev/null; }
case "$ACTION" in
snapshot)
  echo "model=$(prop ro.product.model)"
  echo "manufacturer=$(prop ro.product.manufacturer)"
  echo "device=$(prop ro.product.device)"
  echo "android=$(prop ro.build.version.release)"
  echo "sdk=$(prop ro.build.version.sdk)"
  echo "abi=$(prop ro.product.cpu.abi)"
  echo "soc=$(soc_value)"
  echo "kernel=$(uname -r 2>/dev/null)"
  echo "cores=$(grep -c '^processor' /proc/cpuinfo 2>/dev/null)"
  echo "cpu=$(grep -m 1 'Hardware\|Processor' /proc/cpuinfo 2>/dev/null | cut -d: -f2- | sed 's/^ *//')"
  echo "gpu=$(gpu_value)"
  awk '/MemTotal:/ {print "ram_total_kb=" $2} /MemAvailable:/ {print "ram_available_kb=" $2}' /proc/meminfo 2>/dev/null
  echo "battery=$(dumpsys battery 2>/dev/null | awk -F': ' '/level:/{print $2; exit}')"
  echo "battery_temp_tenths=$(dumpsys battery 2>/dev/null | awk -F': ' '/temperature:/{print $2; exit}')"
  echo "uid=$(id -u 2>/dev/null)"
  echo "selinux=$(id -Z 2>/dev/null)"
  echo "axeron_version=$AXERONVER"
  df -k /data 2>/dev/null | tail -n 1 | awk '{print "data_total_kb=" $2; print "data_used_kb=" $3; print "data_free_kb=" $4}'
  codm_state
  ;;
hardware)
  echo "soc=$(soc_value)"
  echo "cpu=$(grep -m 1 'Hardware\|Processor' /proc/cpuinfo 2>/dev/null | cut -d: -f2- | sed 's/^ *//')"
  echo "gpu=$(gpu_value)"
  echo "cores=$(grep -c '^processor' /proc/cpuinfo 2>/dev/null)"
  cpu_freqs
  ;;
monitor)
  set -- $(cpu_ticks); before_total=$1; before_idle=$2
  sleep 1
  set -- $(cpu_ticks); after_total=$1; after_idle=$2
  delta_total=$((after_total-before_total)); delta_idle=$((after_idle-before_idle))
  if [ "$delta_total" -gt 0 ]; then echo "cpu_load_percent=$(( (delta_total-delta_idle)*100/delta_total ))"; else echo "cpu_load_percent=unavailable"; fi
  cpu_freqs
  for f in /sys/class/devfreq/*gpu*/cur_freq /sys/class/devfreq/*mali*/cur_freq /sys/class/misc/mali0/device/devfreq/*/cur_freq; do
    [ -r "$f" ] || continue
    echo "gpu_freq_hz=$(cat "$f" 2>/dev/null)"
    break
  done
  codm_state
  ;;
codm)
  codm_state
  ;;
thermal)
  found=0
  for f in /sys/class/thermal/thermal_zone*/temp; do
    [ -r "$f" ] || continue
    z=$(echo "$f" | sed 's#/temp##')
    t=$(cat "$z/type" 2>/dev/null); v=$(cat "$f" 2>/dev/null)
    [ -n "$v" ] || continue
    name=$(echo "$z" | sed 's#.*/##')
    echo "zone_"$name"=$t,$v"; found=1
  done
  [ "$found" -eq 1 ] || echo "thermal=unavailable"
  ;;
network)
  echo "interfaces:"
  ip -brief addr 2>/dev/null || ip addr 2>/dev/null
  echo "routes:"
  ip route 2>/dev/null | head -n 5
  ;;
game-modes)
  pm path com.garena.game.codm >/dev/null 2>&1 || { echo "CODM Garena is not installed."; exit 2; }
  cmd game list-modes com.garena.game.codm 2>&1
  ;;
*)
  echo "Usage: engine.sh {snapshot|hardware|monitor|codm|thermal|network|game-modes}"
  exit 2
  ;;
esac
