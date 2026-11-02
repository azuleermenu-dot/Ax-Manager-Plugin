# AX CODM Garena Optimizer

Foundation release 0.1.0 for vivo Y76 5G (V2124), Android 13 / SDK 33, AxManager server 30000+, unrooted shell execution.

## Features
- Runtime device, Android, ABI and kernel identification.
- CPU core count and basic CPU identification.
- RAM totals and available memory.
- Battery level and battery temperature.
- CODM Garena package detection (com.garena.game.codm).
- Readable thermal-zone inspection.
- Network interface and route inspection.
- Android Game Mode availability inspection.

## Safety scope
This release is intentionally read-only. It does not change CPU/GPU frequencies, kill applications, clear caches, disable thermal controls, modify CODM files, manipulate game memory, or claim FPS/ping improvements. Game Mode is inspected only; applying it is deferred until current-mode detection and rollback are verified on the target firmware.

## Install
1. Download the ZIP.
2. Open AxManager > Plugins > + and select the ZIP.
3. Re-ignite if requested.
4. Open this plugin from the Plugins list.

Open the WebUI from AxManager. The ksu API is expected only in the plugin WebUI context.

## Project files
- module.prop: plugin identity and minimum server version.
- customize.sh: AxManager environment/version validation.
- engine.sh: read-only shell diagnostics.
- webroot/index.html: mobile-first WebUI.
- service.sh: no resident daemon in this release.
- action.sh: informational action.
- uninstall.sh: confirms no Android settings were changed.

## Compatibility
Designed for AxManager server 30000+ and Android shell UID 2000. Hardware values are detected at runtime. Some procfs, sysfs, dumpsys and cmd game information may be unavailable under shell permissions or particular Funtouch OS builds; unavailable data is not fabricated.

## Test status
Shell/JavaScript syntax and ZIP integrity can be checked statically. Installation, WebView API behavior, permission visibility, thermal-zone access and CODM detection still require a real-device test. This release has not been claimed as device-tested.

## Official AxManager references
- https://axmanager.app/plugin/what-is-plugin
- https://axmanager.app/plugin/plugin-installer
- https://axmanager.app/plugin/webui-api
- https://axmanager.app/plugin/environment
