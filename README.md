# AX CODM Garena Optimizer

Version 0.2.0 · AxManager server 30000+ · Android shell/plugin environment.

A read-only diagnostics foundation intended for testing on the vivo Y76 5G (V2124, Android 13). Hardware is identified at runtime; this release does not assume root access or hardcode a GPU/SoC result.

## Features
- Runtime device, Android, ABI, kernel and platform identification.
- CPU core count, one-second aggregate CPU utilization sample and per-core frequencies when exposed.
- GPU renderer hint from Android properties / SurfaceFlinger, plus GPU frequency only when a matching sysfs node is readable.
- RAM availability, battery percentage/temperature and /data free space.
- CODM Garena package installation and process/PID detection.
- Readable thermal-zone data, network interface/routes and Android Game Mode listing.
- Mobile-first AxManager WebUI with manual refresh and diagnostic actions.

## Safety scope
This release is intentionally read-only. It does not set CPU/GPU frequencies, kill processes, clear caches, disable thermal controls, modify CODM files, manipulate game memory or change network settings. It does not promise FPS or ping improvements. Game Mode is inspected only; applying it is deferred until current-mode detection and rollback are verified on the target firmware.

## Install
1. Download the ZIP.
2. Open AxManager > Plugins > + and select the ZIP.
3. Re-ignite if requested by AxManager.
4. Open this plugin from the Plugins list.

Open the WebUI from AxManager. The ksu API is expected only in the plugin WebUI context.

## Project files
- module.prop: plugin identity and minimum server version.
- customize.sh: AxManager environment/version validation.
- engine.sh: read-only shell diagnostics.
- webroot/index.html: mobile-first AxManager WebUI.
- service.sh: no resident daemon.
- action.sh: informational action.
- uninstall.sh: confirms no Android settings were changed.

## Compatibility and limitations
The target is AxManager server 30000+ and Android shell UID 2000. Access to procfs, sysfs, dumpsys, pidof, ip and cmd game varies by Android build and shell permissions. GPU identity, CPU frequency and thermal values are shown only when exposed by the device. An unavailable value is not guessed or fabricated. A one-second CPU sample is a brief snapshot, not a sustained benchmark.

## Test status
Shell syntax and ZIP integrity are statically checked. This version has not been installed or device-tested on the vivo Y76 5G. WebView callback behavior, hardware visibility and CODM process detection still require confirmation on the target device.

## Official AxManager references
- https://axmanager.app/plugin/what-is-plugin
- https://axmanager.app/plugin/plugin-installer
- https://axmanager.app/plugin/webui-api
- https://axmanager.app/plugin/environment
