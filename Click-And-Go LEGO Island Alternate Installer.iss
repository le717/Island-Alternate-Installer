;  Click-And-Go LEGO Island Alternate Installer
;  Copyright © 2012 le717
;  http://triangle717.wordpress.com
;  Contains source code from Grim Fandango Setup
;  Copyright (c) 2007-2008 Bgbennyboy
;  Http://quick.mixnmojo.com
;  Built with Inno Setup 5.5.2 Unicode

; If any version below the specified version is used for compiling, this error will be shown.
#if VER < EncodeVer(5,5,2)
  #error You must use Inno Setup 5.5.2 or newer to compile this script
#endif

[Define]
#define MyAppInstallerName "Click-And-Go LEGO Island Alternate Installer V1.0"
#define MyAppName "LEGO Island"
#define MyAppVersion "1.1.0.0"
#define MyAppPublisher "LEGO"
#define MyAppExeName "LEGOISLE.EXE"
[Setup]
AppID={
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppCopyright=© 1997 {#MyAppPublisher}
VersionInfoVersion={#MyAppVersion}
LicenseFile=license.txt
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
AllowNoIcons=true
SetupIconFile=ISLE.ico
WizardImageFile=LI Sidebar Image.bmp
WizardSmallImageFile=ISLE.bmp
WizardImageStretch=True
WizardImageBackColor=clBlack
OutputDir=Here Lie The EXE
OutputBaseFilename={#MyAppInstallerName}
UninstallFilesDir={app}
UninstallDisplayIcon={#MyAppExeName}
CreateUninstallRegKey=true
UninstallDisplayName={#MyAppName}
SolidCompression=True
Compression=lzma/ultra64
InternalCompressLevel=ultra
PrivilegesRequired=admin
ShowLanguageDialog=no

[Languages]
Name: "English"; MessagesFile: "compiler:Default.isl"

[Messages]
English.BeveledLabel={#MyAppInstallerName}
; English.WelcomeLabel2 is overridden because I'm unsure if every LEGO Island disc says version 1.1.0.0 or just mine.
English.WelcomeLabel2=This will install [name] on your computer.%n%nIt is recommended that you close all other applications before continuing.
; English.DiskSpaceMBLabel is disabled because it would report an incorrect installation size.
English.DiskSpaceMBLabel=

; Both Types and Components sections are required to create the installation options.
               
[Types]
Name: "Normal"; Description: "Normal Installation (Requires CD)"
Name: "Full"; Description: "Full Installation (Does Not Require CD)"  

[Components]
Name: "Normal"; Description: "Normal Installation (Requires CD)"; Types: Normal
Name: "Full"; Description: "Full Installation (Does Not Require CD)"; Types: Full 

[Files]
Source: "ISLE.ico"; DestDir: "{app}"; Components: Full Normal
Source: "{code:GetSourceDrive}redist\directx\d3drm.dll"; DestDir: "{app}"; Flags: external ignoreversion; Components: Full Normal
Source: "{code:GetSourceDrive}README.HLP"; DestDir: "{app}"; Flags: external ignoreversion; Components: Full Normal
Source: "{code:GetSourceDrive}DATA\disk\*"; DestDir: "{app}"; Flags: external ignoreversion createallsubdirs recursesubdirs; Components: Normal
Source: "{code:GetSourceDrive}MSREG\MSRUN32.EXE"; DestName: "Msrun.exe"; DestDir: "{app}"; Flags: external ignoreversion; Components: Full Normal
Source: "{code:GetSourceDrive}MSREG\MSREG.INI"; DestName: "Msreg.ini"; DestDir: "{app}"; Flags: external ignoreversion; Components: Full Normal
Source: "{code:GetSourceDrive}MSREG\MSREG32.DLL"; DestName: "Msreg32.dll"; DestDir: "{app}"; Flags: external ignoreversion; Components: Full Normal
; Because of the disc layout, the Full installation files have to be declared separately to insure everything is installed in the proper place.
Source: "{code:GetSourceDrive}DATA\disk\LEGOISLE.EXE"; DestDir: "{app}"; Flags: external ignoreversion; Components: Full
Source: "{code:GetSourceDrive}DATA\disk\ISLE.EXE"; DestDir: "{app}"; Flags: external ignoreversion; Components: Full
Source: "{code:GetSourceDrive}DATA\disk\CONFIG.EXE"; DestDir: "{app}"; Flags: external ignoreversion; Components: Full
Source: "{code:GetSourceDrive}DATA\disk\LEGO1.DLL"; DestDir: "{app}"; Flags: external ignoreversion; Components: Full
Source: "{code:GetSourceDrive}DATA\disk\MFC42.DLL"; DestDir: "{app}"; Flags: external ignoreversion; Components: Full
Source: "{code:GetSourceDrive}DATA\disk\MSVCRT.DLL"; DestDir: "{app}"; Flags: external ignoreversion; Components: Full
Source: "{code:GetSourceDrive}Lego\Scripts\*"; DestDir: "{app}\LEGO\Scripts"; Flags: external ignoreversion recursesubdirs createallsubdirs; Components: Full
Source: "{code:GetSourceDrive}DATA\disk\LEGO\data\*"; DestDir: "{app}\LEGO\data"; Flags: external ignoreversion; Components: Full

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\ISLE.ICO"
Name: "{group}\To Configure {#MyAppName}"; Filename: "{app}\CONFIG.EXE"; IconFilename: "{app}\ISLE.ico"
Name: "{group}\Print Free Map of LEGO Island"; Filename: "{app}\Msrun.exe"; IconFilename: "{app}\ISLE.ico"; Parameters: "LaunchRegistration"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Registry]
; Registry strings are always hard-coded (No Define functions) to ensure everything works properly.
Root: "HKLM"; Subkey: "SOFTWARE\Mindscape"; ValueType: none; Flags: uninsdeletekey
Root: "HKLM"; Subkey: "SOFTWARE\Mindscape\LEGO Island"; ValueType: none; Flags: uninsdeletekey
Root: "HKLM"; Subkey: "SOFTWARE\Mindscape\LEGO Island"; ValueType: string; ValueName: "3D Device Name"; Flags: uninsdeletevalue
Root: "HKLM"; Subkey: "SOFTWARE\Mindscape\LEGO Island"; ValueType: string; ValueName: "3DSound"; ValueData: "YES"; Flags: uninsdeletevalue
Root: "HKLM"; Subkey: "SOFTWARE\Mindscape\LEGO Island"; ValueType: string; ValueName: "Back Buffers in Video RAM"; ValueData: "YES"; Flags: uninsdeletevalue
Root: "HKLM"; Subkey: "SOFTWARE\Mindscape\LEGO Island"; ValueType: string; ValueName: "diskpath"; ValueData: "{app}"; Flags: uninsdeletevalue
Root: "HKLM"; Subkey: "SOFTWARE\Mindscape\LEGO Island"; ValueType: string; ValueName: "Display Bit Depth"; ValueData: "16"; Flags: uninsdeletevalue
Root: "HKLM"; Subkey: "SOFTWARE\Mindscape\LEGO Island"; ValueType: string; ValueName: "moviespath"; ValueData: "{app}"; Flags: uninsdeletevalue
Root: "HKLM"; Subkey: "SOFTWARE\Mindscape\LEGO Island"; ValueType: string; ValueName: "Draw Cursor"; ValueData: "NO"; Flags: uninsdeletevalue
Root: "HKLM"; Subkey: "SOFTWARE\Mindscape\LEGO Island"; ValueType: string; ValueName: "Flip Surfaces"; ValueData: "YES"; Flags: uninsdeletevalue
Root: "HKLM"; Subkey: "SOFTWARE\Mindscape\LEGO Island"; ValueType: string; ValueName: "Full Screen"; ValueData: "YES"; Flags: uninsdeletevalue
Root: "HKLM"; Subkey: "SOFTWARE\Mindscape\LEGO Island"; ValueType: string; ValueName: "Island Quality"; ValueData: "2"; Flags: uninsdeletevalue
Root: "HKLM"; Subkey: "SOFTWARE\Mindscape\LEGO Island"; ValueType: string; ValueName: "Island Texture"; ValueData: "1"; Flags: uninsdeletevalue
Root: "HKLM"; Subkey: "SOFTWARE\Mindscape\LEGO Island"; ValueType: string; ValueName: "JoystickIndex"; ValueData: "-1"; Flags: uninsdeletevalue
Root: "HKLM"; Subkey: "SOFTWARE\Mindscape\LEGO Island"; ValueType: string; ValueName: "Music"; ValueData: "YES"; Flags: uninsdeletevalue
Root: "HKLM"; Subkey: "SOFTWARE\Mindscape\LEGO Island"; ValueType: string; ValueName: "savepath"; ValueData: "{app}"; Flags: uninsdeletevalue
Root: "HKLM"; Subkey: "SOFTWARE\Mindscape\LEGO Island"; ValueType: string; ValueName: "UseJoystick"; ValueData: "NO"; Flags: uninsdeletevalue
Root: "HKLM"; Subkey: "SOFTWARE\Mindscape\LEGO Island"; ValueType: string; ValueName: "Wide View Angle"; ValueData: "YES"; Flags: uninsdeletevalue
Root: "HKLM"; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\LEGOISLE.exe"; ValueType: string; ValueName: "(Default)"; ValueData: "{app}\LEGOISLE.EXE"; Flags: uninsdeletekey
Root: "HKCU"; Subkey: "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"; ValueType: string; ValueName: "{app}\LEGOISLE.EXE"; ValueData: "RUNASADMIN"; Flags: uninsdeletevalue; Tasks: Admin
Root: "HKCU"; Subkey: "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"; ValueType: string; ValueName: "{app}\ISLE.EXE"; ValueData: "RUNASADMIN"; Flags: uninsdeletevalue; Tasks: Admin
Root: "HKCU"; Subkey: "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"; ValueType: string; ValueName: "{app}\CONFIG.EXE"; ValueData: "RUNASADMIN"; Flags: uninsdeletevalue; Tasks: Admin
Root: "HKCU"; Subkey: "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"; ValueType: string; ValueName: "{app}\Msrun.exe"; ValueData: "RUNASADMIN"; Flags: uninsdeletevalue; Tasks: Admin

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "Admin"; Description: "Run {#MyAppName} with Administrator Rights"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Code]
var
	SourceDrive: string;

#include "FindDisc.iss"

function GetSourceDrive(Param: String): String;
begin
	Result:=SourceDrive;
end;

procedure InitializeWizard();
begin
	SourceDrive:=GetSourceCdDrive();
end;
