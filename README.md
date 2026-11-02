# AX CODM Garena Optimizer

Version 0.6.0 · AxManager server 30000+ · Android shell/plugin environment.

## New in v0.6.0: Potato Graphics Mode
Adds a guided in-game checklist targeting the closest supported low-detail configuration: Graphics Quality LOW, highest stable frame-rate option, optional visual effects disabled, and avoiding optional HD/high-resolution resource downloads. Optional packs should only be removed through CODM's own Download Manager if the game exposes that option.

**Important limitation:** CODM does not expose a supported Android-shell control to force texture resolution below its own Low setting. This guide cannot reproduce arbitrary texture pixelation or low-poly rendering. The plugin does not modify, replace, or delete protected CODM assets.

## Existing features
- Android Game Mode requests: PERFORMANCE, STANDARD and BATTERY.
- CODM Garena launch action and supported-mode check.
- Device / Android / SoC / GPU identification.
- CPU utilization and per-core frequency when readable.
- RAM, battery, storage and CODM process state.
- Thermal-zone and network diagnostics.

## Install
1. Download the ZIP release artifact from GitHub Actions.
2. Open AxManager > Plugins > + and select the ZIP.
3. Re-ignite if requested by AxManager.
4. Open this plugin from the Plugins list.

## Scope and limitations
No CPU/GPU overclocking, undervolting, thermal-limit disabling, game-memory editing, game-file modification or process killing is performed. Android shell permissions and Funtouch OS may reject commands or hide telemetry nodes. Performance mode may increase battery consumption and does not guarantee an FPS increase.

## Test status
Source changes are committed to GitHub. Installation and actual behavior still require testing on the target vivo Y76 5G.

## Official references
- AxManager WebUI API: https://axmanager.app/plugin/webui-api
- AxManager plugin environment: https://axmanager.app/plugin/environment
- Android Game Mode API: https://developer.android.com/games/optimize/adpf/gamemode/gamemode-api
