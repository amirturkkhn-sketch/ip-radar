; Inno Setup script, built by the GitHub workflow.
; /DAppVer=1.0.N  /DOutName=...  /DArch=x64|x86|arm64|universal
#ifndef AppVer
  #define AppVer "1.0.0"
#endif
#ifndef Arch
  #define Arch "x64"
#endif
#ifndef OutName
  #define OutName "IP-Radar-Setup"
#endif

#ifexist "dist\arm64\IP Radar\IP Radar.exe"
  #define ArmBuilt "True"
#else
  #define ArmBuilt "False"
#endif

[Setup]
AppId={{6B0E5C7A-3C1D-4D52-9B58-1D7A4E2C9A10}
AppName=IP Radar
AppVersion={#AppVer}
AppPublisher=IP Radar
DefaultDirName={autopf}\IP Radar
DefaultGroupName=IP Radar
UninstallDisplayIcon={app}\IP Radar.exe
SetupIconFile=icon.ico
OutputDir=out
OutputBaseFilename={#OutName}
Compression=lzma2/max
SolidCompression=yes
PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=dialog
DisableProgramGroupPage=yes
WizardStyle=modern
#if Arch == "x64"
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
#elif Arch == "arm64"
ArchitecturesAllowed=arm64
ArchitecturesInstallIn64BitMode=arm64
#endif

[Tasks]
Name: "desktopicon"; Description: "Create a desktop shortcut"; Flags: unchecked

[Files]
#if Arch == "universal"
#ifexist "dist\arm64\IP Radar\IP Radar.exe"
Source: "dist\arm64\IP Radar\*"; DestDir: "{app}"; Flags: recursesubdirs ignoreversion; Check: IsArm64Cpu
#endif
#ifexist "dist\x64\IP Radar\IP Radar.exe"
Source: "dist\x64\IP Radar\*"; DestDir: "{app}"; Flags: recursesubdirs ignoreversion; Check: IsX64Cpu
#endif
#ifexist "dist\x86\IP Radar\IP Radar.exe"
Source: "dist\x86\IP Radar\*"; DestDir: "{app}"; Flags: recursesubdirs ignoreversion; Check: UseX86
#endif
#else
Source: "dist\{#Arch}\IP Radar\*"; DestDir: "{app}"; Flags: recursesubdirs ignoreversion
#endif

[Icons]
Name: "{group}\IP Radar"; Filename: "{app}\IP Radar.exe"
Name: "{autodesktop}\IP Radar"; Filename: "{app}\IP Radar.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\IP Radar.exe"; Description: "Launch IP Radar"; Flags: nowait postinstall skipifsilent

[Code]
function IsArm64Cpu: Boolean;
begin
  Result := (ProcessorArchitecture = paARM64);
end;
function IsX64Cpu: Boolean;
begin
  { ARM64 PCs fall back to the x64 build (Windows emulates it) when no native ARM64 build exists. }
  Result := (ProcessorArchitecture = paX64) or ((ProcessorArchitecture = paARM64) and not {#ArmBuilt});
end;
{ 32-bit Windows only; 64-bit PCs use the x64 or ARM64 build. }
function UseX86: Boolean;
begin
  Result := (ProcessorArchitecture = paX86);
end;
