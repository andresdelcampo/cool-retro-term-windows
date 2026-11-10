# cool-retro-term for Windows

| Default Amber | IBM DOS | Default Green |
| :---: | :---: | :---: |
| ![Default Amber animation](docs/screenshots/default-amber.gif) | ![IBM DOS animation](docs/screenshots/ibm-dos.gif) | ![Default Green animation](docs/screenshots/default-green.gif) |

## Description

cool-retro-term is a customizable terminal emulator that recreates the glow, curvature and texture of old CRT displays. This fork brings the classic **cool-retro-term 1.1.1** looks to Windows.

## Screenshots

The animations and screenshots come from the [original cool-retro-term project](https://github.com/Swordfish90/cool-retro-term). The three stills below have their title bars removed.

![Amber CRT showing a directory listing](docs/screenshots/original-amber.png)

![Green CRT showing the GCC manual](docs/screenshots/original-green.png)

![Blue CRT running Midnight Commander](docs/screenshots/original-blue.png)

## Profiles

Nine presets follow the original 1.1.1 looks: Default Amber, Monochrome Green, Green Scanlines, Pixelated, Apple ][ Dark, Vintage, IBM DOS, IBM 3278 and Futuristic. The other presets build on existing designs, with tweaks for a more realistic look or to suit the fork author's taste. Pick any of the 21 presets from **Profiles**, then adjust colors, fonts and effects in Settings.

## What this fork adds

- **Classic CRT rendering:** scanline and pixel masks are applied before bloom, with curvature, bezel and glow based on the 1.1.1 renderer. Futuristic retains its translucent window.
- **Restored and refreshed profiles:** nine 1.1.1-inspired looks alongside adjusted existing presets, including bundled classic fonts and a C64 Pro Mono option. Older Classic profile names are recognized for compatibility.
- **Windows window controls:** options for a borderless window and menu bar visibility, accessible through the application settings and menus.
- **Windows build:** a CMake/Ninja build and deployment script that compiles the shaders and prepares a runnable `build/app` directory.

The classic presets were compared with the original 1.1.1 application in WSL at 1024×768 and 1× scaling. Measured row pitch matched for all nine; IBM 3278 and Futuristic rendered slightly heavier glyphs on Windows.

## Run on Windows

Windows 10 version 1809 or later, or Windows 11, is required for the ConPTY backend. To build this fork, install Git, CMake, Ninja and a Qt 6.8+ x64 kit with Qt Shader Tools and a matching compiler. Follow the [Windows build instructions](HOW_TO_INSTALL.md#option-2-build-from-source), then run `build/app/cool-retro-term.exe` and keep the deployed files together.

The [earlier Windows port's releases](https://github.com/pushingpandas/cool-retro-term-windows/releases) are available separately; those binaries may not include this fork's changes.

## Earlier work and credits

This fork builds on [pushingpandas' Windows port](https://github.com/pushingpandas/cool-retro-term-windows), which adapts the QML port of qtermwidget for Windows using a ConPTY backend, threaded pipe I/O and OpenGL rendering. It detects PowerShell Core, Windows PowerShell or Command Prompt and provides Windows menus and deployment support.

The original [cool-retro-term](https://github.com/Swordfish90/cool-retro-term) was created by Filippo Scognamiglio. Its repository also contains the Linux and macOS versions. The original project and the Windows port supplied the profiles and foundations revisited here.

## License and contact

GPL v3; see [LICENSE](LICENSE). Original copyright © 2013–2021 Filippo Scognamiglio. Windows port copyright © 2024 pushingpandas.

Earlier Windows port: A. Prior — [a.prior@pushingpandas.io](mailto:a.prior@pushingpandas.io) | [pushingpandas.io](https://pushingpandas.io)
