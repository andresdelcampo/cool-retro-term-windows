[CmdletBinding()]
param(
    [string] $AppDirectory,
    [string] $OutputPath
)

$ErrorActionPreference = 'Stop'
$repo = Split-Path -Parent $PSScriptRoot
if (-not $AppDirectory) {
    $AppDirectory = Join-Path $repo 'build/app'
}
if (-not $OutputPath) {
    $OutputPath = Join-Path $repo 'build/cool-retro-term-windows-enhanced-x64.zip'
}
$app = (Resolve-Path -LiteralPath $AppDirectory).Path
$output = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($OutputPath)
if (Test-Path -LiteralPath $output) {
    throw "Output already exists: $output. Choose a new output path."
}

$required = @(
    'cool-retro-term.exe'
    'Qt6Core.dll'
    'platforms/qwindows.dll'
    'sqldrivers/qsqlite.dll'
    'qml/QMLTermWidget/qmldir'
    'qml/QMLTermWidget/qmltermwidget.dll'
)
foreach ($relativePath in $required) {
    if (-not (Test-Path -LiteralPath (Join-Path $app $relativePath) -PathType Leaf)) {
        throw "Missing deployed runtime file: $relativePath. Run the Windows build and deployment first."
    }
}

$runtimeFolders = @(
    'generic', 'iconengines', 'imageformats', 'networkinformation',
    'platforms', 'qml', 'sqldrivers', 'styles', 'tls', 'translations'
)
$excludedParts = @('CMakeFiles', 'qmltermwidget_autogen', 'cmake_install.cmake', 'libqmltermwidget.dll')
$excludedExtensions = @('.a', '.lib', '.obj', '.pdb', '.log')
$files = @(Get-Item -LiteralPath (Join-Path $app 'cool-retro-term.exe'))
$files += Get-ChildItem -LiteralPath $app -File -Filter '*.dll'
foreach ($folder in $runtimeFolders) {
    $path = Join-Path $app $folder
    if (Test-Path -LiteralPath $path -PathType Container) {
        $files += Get-ChildItem -LiteralPath $path -File -Recurse
    }
}

Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem
[void][System.IO.Directory]::CreateDirectory((Split-Path -Parent $output))
$temporaryZip = "$output.$([Guid]::NewGuid().ToString('N')).tmp"
try {
    $archive = [System.IO.Compression.ZipFile]::Open($temporaryZip, 'Create')
    try {
        foreach ($file in $files | Sort-Object FullName) {
            $relativePath = $file.FullName.Substring($app.Length + 1).Replace('\', '/')
            $parts = $relativePath.Split('/')
            if ($file.Extension -in $excludedExtensions -or
                ($parts | Where-Object { $_ -in $excludedParts })) {
                continue
            }
            [void][System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile(
                $archive, $file.FullName, $relativePath, 'Optimal')
        }
        foreach ($license in @('LICENSE', 'gpl-2.0.txt', 'gpl-3.0.txt')) {
            [void][System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile(
                $archive, (Join-Path $repo $license), $license, 'Optimal')
        }
    } finally {
        $archive.Dispose()
    }
    [System.IO.File]::Move($temporaryZip, $output)
} finally {
    if (Test-Path -LiteralPath $temporaryZip) {
        Remove-Item -LiteralPath $temporaryZip
    }
}
Get-Item -LiteralPath $output
