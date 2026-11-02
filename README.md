# AX CODM Garena Optimizer

Version 0.5.0 · AxManager server 30000+ · Android shell/plugin environment.

Device-targeted release for vivo Y76 5G (V2124, Android 13). Hardware is detected at runtime; the known target platform is MediaTek Dimensity 700 (MT6833) with Mali-G57 MC2 graphics and a 60 Hz display. Runtime GPU/CPU readings are reported separately from specification-based hints.

## New in v0.5.0: FPS-focused graphics guide
The WebUI now includes an in-game low-graphics setup guide: Graphics Quality Low, highest stable frame-rate option, and optional visual effects disabled where available. The guide does not modify or delete CODM assets. CODM controls its own rendering and resource files; lower graphics settings may reduce rendering load but do not guarantee higher FPS or change downloaded texture files.

## CODM controls
- Request Android Game Mode PERFORMANCE for CODM Garena.
- Restore STANDARD mode.
- Request BATTERY mode.
- Read available game-mode support.
- Launch CODM Garena directly.

These use Android's per-game Game Mode shell command. Whether a requested mode is supported depends on the Android build and the game package. Command acceptance does not promise a frame-rate increase.

## Device monitoring
- Device / Android / SoC / GPU identification.
- CPU utilization sample and per-core frequency when readable.
- RAM, battery, storage and CODM process state.
- Thermal-zone, network and Game Mode diagnostics.

## Install
1. Download the ZIP.
2. Open AxManager > Plugins > + and select the ZIP.
3. Re-ignite if requested by AxManager.
4. Open this plugin from the Plugins list.

The WebUI resolves the plugin directory from moduleInfo and invokes the engine by absolute path. It calls ksu.exec with the documented command, options JSON and callback arguments.

## Scope and limitations
No CPU/GPU overclocking, undervolting, thermal-limit disabling, memory editing, game-file modification or process killing is performed. Android shell permissions and Funtouch OS may reject some commands or hide telemetry nodes. Unsupported readings are displayed as unavailable. Game Mode PERFORMANCE may increase battery consumption and can be rejected by the firmware or game.

## Test status
Source changes are committed to GitHub. Static syntax checks, packaging and actual installation must still be confirmed before claiming the plugin works on the target vivo device.

## Official references
- AxManager WebUI API: https://axmanager.app/plugin/webui-api
- AxManager plugin environment: https://axmanager.app/plugin/environment
- Android Game Mode API: https://developer.android.com/games/optimize/adpf/gamemode/gamemode-api
- vivo Y76 5G official specifications: https://www.vivo.com/ph/products/param/y76
