@rem Build script for cool-retro-term Windows port
@rem Copyright (C) 2024 pushingpandas
@rem Licensed under GPL v3 - see LICENSE file
@echo off
setlocal

rem Use the matching compiler and Qt bin directories on PATH.
if not "%~1"=="" (
    set "CMAKE_PREFIX_PATH=%~1"
    set "PATH=%~1\bin;%PATH%"
)
for %%F in (qtpaths.exe) do set "qtpaths=%%~$PATH:F"
if not defined qtpaths (
    echo Qt bin directory is missing from PATH.
    exit /b 1
)
set "source=%~dp0."
set "build=%~dp0build"

cmake -S "%source%" -B "%build%" -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_POLICY_VERSION_MINIMUM=3.5
if errorlevel 1 exit /b 1

cmake --build "%build%" --parallel 8
if errorlevel 1 exit /b 1

set "app=%build%\app"
set "plugin=%build%\qmltermwidget\qmltermwidget.dll"
if not exist "%plugin%" set "plugin=%build%\qmltermwidget\libqmltermwidget.dll"

windeployqt --qtpaths "%qtpaths%" --release --qmldir "%source%\app\qml" --sql "%app%\cool-retro-term.exe"
if errorlevel 1 exit /b 1
cmake -E copy_directory "%build%\QMLTermWidget" "%app%\qml\QMLTermWidget"
if errorlevel 1 exit /b 1
cmake -E copy_if_different "%plugin%" "%app%\qml\QMLTermWidget\qmltermwidget.dll"
if errorlevel 1 exit /b 1
for %%F in ("%build%\bin\*kdsingleapplication*.dll") do (
    cmake -E copy_if_different "%%~fF" "%app%"
    if errorlevel 1 exit /b 1
)

echo Launch "%app%\cool-retro-term.exe"
