[Setup]
AppName=Scorekeeper BioBuzz
AppVersion=1.0.0
DefaultDirName={autopf}\Scorekeeper BioBuzz
DefaultGroupName=Scorekeeper BioBuzz
UninstallDisplayIcon={app}\scorekeeper_biobuzz.exe
Compression=lzma2/ultra64
SolidCompression=yes
OutputDir=build\windows\installer
OutputBaseFilename=Scorekeeper_BioBuzz_Setup_v1.0.0

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
; Include executabilul scorekeeper_biobuzz.exe și toate DLL-urile aferente
Source: "build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{autoprograms}\Scorekeeper BioBuzz"; Filename: "{app}\scorekeeper_biobuzz.exe"
Name: "{autodesktop}\Scorekeeper BioBuzz"; Filename: "{app}\scorekeeper_biobuzz.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\scorekeeper_biobuzz.exe"; Description: "{cm:LaunchProgram,Scorekeeper BioBuzz}"; Flags: nowait postinstall skipifsilent