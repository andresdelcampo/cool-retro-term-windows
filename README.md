# cool-retro-term (Windows Port)

|> Default Amber|C:\ IBM DOS|$ Default Green|
|---|---|---|
|![Default Amber Cool Retro Term](https://user-images.githubusercontent.com/121322/32070717-16708784-ba42-11e7-8572-a8fcc10d7f7d.gif)|![IBM DOS](https://user-images.githubusercontent.com/121322/32070716-16567e5c-ba42-11e7-9e64-ba96dfe9b64d.gif)|![Default Green Cool Retro Term](https://user-images.githubusercontent.com/121322/32070715-163a1c94-ba42-11e7-80bb-41fbf10fc634.gif)|

## Description
cool-retro-term is a terminal emulator which mimics the look and feel of the old cathode tube screens.
It has been designed to be eye-candy, customizable, and reasonably lightweight.

This is the **Windows 11 port** by [pushingpandas](https://github.com/pushingpandas), based on the original [cool-retro-term](https://github.com/Swordfish90/cool-retro-term) by Filippo Scognamiglio.

It uses the QML port of qtermwidget (Konsole) with a custom Windows ConPTY backend replacing the POSIX PTY layer.

Settings such as colors, fonts, and effects can be accessed via the **menu bar** at the top and the **right-click context menu**. Both are available on Windows.

## Download & Run

1. Download the latest `.zip` from the [Releases](https://github.com/pushingpandas/cool-retro-term-windows/releases) page
2. Extract the zip to any folder
3. Run `cool-retro-term.exe` from the extracted folder

The exe and all required Qt6 DLLs are in the same folder — no installation needed.

> **Building from source?** The Windows build script produces a runnable copy in `build/app`. See [Building on Windows](#building-on-windows).

## Screenshots
![Image](<https://i.imgur.com/TNumkDn.png>)
![Image](<https://i.imgur.com/hfjWOM4.png>)
![Image](<https://i.imgur.com/GYRDPzJ.jpg>)

## Windows Port Details

### What was changed
- **ConPTY backend**: New `conpty.cpp`, `conptydevice.cpp`, `conptyprocess.cpp` replace POSIX PTY for terminal I/O on Windows using the Windows Pseudo Console API (ConPTY)
- **Threaded pipe I/O**: Reader/Writer threads with `ReadFile`/`WriteFile` (Windows anonymous pipes don't work with `QSocketNotifier`)
- **mmap emulation**: `win32_compat.h` provides `mmap`/`munmap`/`getpagesize` via `VirtualAlloc` for terminal history
- **OpenGL rendering**: Forces OpenGL backend since D3D11's FXC shader compiler can't handle the CRT effect shaders
- **Shell detection**: Finds PowerShell Core (`pwsh`) > Windows PowerShell (`powershell`) > `cmd.exe`
- **Consolas fallback font**: Uses Consolas as the monospace fallback on Windows
- **Menu bar**: Always visible on Windows (File, Edit, View, Profiles, Help)
- **Shader compilation**: All 63 shader variants recompiled with HLSL 5.1 support

### Requirements
- Windows 10 version 1809+ (for ConPTY API) or Windows 11
- Qt 6.8+ with Shader Tools and a matching x64 C++ toolchain
- CMake and Ninja for source builds

## Building on Windows

Follow the [Windows build instructions](HOW_TO_INSTALL.md#option-2-build-from-source) to build and deploy into the ignored `build/app` directory. Select **Profiles → Classic Amber (1.1.1)** to try the classic renderer.

### Classic 1.1.1 rendering

The nine Classic profiles select the 1.1.1 rendering path. It applies scanline and pixel masks before bloom and uses the original curvature, bezel and glow effects. Futuristic retains its translucent window. The source build bakes the Qt shaders, and the corresponding `.qsb` assets are tracked.

The presets were compared with the original 1.1.1 app in WSL at 1024×768 and 1× scaling. Measured row pitch matched for all nine. IBM 3278 and Futuristic render slightly heavier glyphs on Windows.

## Original Project

Based on [cool-retro-term](https://github.com/Swordfish90/cool-retro-term) by Filippo Scognamiglio.
For Linux and macOS builds, see the [original repository](https://github.com/Swordfish90/cool-retro-term).

## License
GPL v3 - see [LICENSE](LICENSE) file.

Windows port Copyright (C) 2024 pushingpandas.
Original Copyright (C) 2013-2021 Filippo Scognamiglio.

## Contact

Windows port: A. Prior — [a.prior@pushingpandas.io](mailto:a.prior@pushingpandas.io) | [pushingpandas.io](https://pushingpandas.io)
