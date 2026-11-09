# How to Install

## Option 1: Download Pre-built Release (Recommended)

No installation required — cool-retro-term is fully portable.

1. Go to the [Releases](https://github.com/pushingpandas/cool-retro-term-windows/releases) page
2. Download the latest `cool-retro-term-windows-*.zip`
3. Extract the zip to any folder (e.g., `C:\Programs\cool-retro-term\`)
4. Run `cool-retro-term.exe`

That's it. All Qt6 DLLs and plugins are included in the zip.

### System Requirements
- Windows 10 version 1809 or later (for ConPTY API)
- Windows 11 (recommended)
- No additional software or runtime needed

---

## Option 2: Build from Source

Install Git, CMake, Ninja, and a Qt 6.8+ x64 kit with Qt Shader Tools. Use the compiler that matches your Qt kit. For MSVC, open the x64 Native Tools Command Prompt. For MinGW, put the matching MinGW `bin` directory on PATH.

Clone the fork with its submodule if you need a checkout:

```batch
git clone --recurse-submodules https://github.com/andresdelcampo/cool-retro-term-windows.git
cd cool-retro-term-windows
```

From the repository root, add the Qt kit's `bin` directory to PATH and pass the kit directory to the build script. This example uses Qt 6.8.3 and MinGW 13.1:

```batch
set "PATH=C:\Qt\6.8.3\mingw_64\bin;C:\Qt\Tools\mingw1310_64\bin;%PATH%"
build_win.bat "C:\Qt\6.8.3\mingw_64"
```

The script builds with CMake and Ninja, compiles the shader variants, and deploys the runtime and terminal plugin into `build\app`. Run `build\app\cool-retro-term.exe` and choose a Classic preset in **Profiles**. Keep the files in that directory together.

---

## Troubleshooting

### "Qt6Core.dll not found" or similar DLL errors
All Qt6 DLLs must be in the same folder as `cool-retro-term.exe`. If you built from source, run `build_win.bat` to build and deploy the runtime.

### Black screen / no CRT effects
The app requires OpenGL. Make sure your GPU drivers are up to date. The app forces OpenGL rendering to avoid D3D11 shader compatibility issues.

### Terminal doesn't accept input
Rebuild with `build_win.bat` and launch `build\app\cool-retro-term.exe`.

### PowerShell doesn't start
cool-retro-term looks for shells in this order: `pwsh` (PowerShell Core) → `powershell` (Windows PowerShell) → `cmd.exe`. Make sure at least one is available on your system PATH.

---

## Uninstall

cool-retro-term is portable — just delete the folder. No registry entries or system files are modified.

Settings are stored in `%APPDATA%\cool-retro-term\` — delete that folder to remove all saved preferences.
