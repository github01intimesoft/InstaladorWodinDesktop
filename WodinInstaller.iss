[Setup]
AppId={{C2B45F8A-5F53-4B89-8D92-1FEC7C6C9B11}
AppName=Wodin WorkDevice
AppVersion=1.0.0
AppPublisher=Intimesoft
DefaultDirName=C:\Program Files (x86)\Intimesoft\WorkDevice
DefaultGroupName=Intimesoft WorkDevice
OutputDir=InstallerOutput
OutputBaseFilename=WodinWorkDeviceSetup
Compression=lzma
SolidCompression=yes
WizardStyle=modern
ArchitecturesInstallIn64BitMode=x64
PrivilegesRequired=admin
DisableProgramGroupPage=yes
UninstallDisplayIcon={app}\Wodin.WorkDevice.Desktop.exe

[Languages]
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"

[Tasks]
Name: "desktopicon"; Description: "Criar atalho na área de trabalho"; GroupDescription: "Opções adicionais:"; Flags: unchecked

[Files]
Source: "publish\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\Wodin WorkDevice"; Filename: "{app}\Wodin.WorkDevice.Desktop.exe"
Name: "{autodesktop}\Wodin WorkDevice"; Filename: "{app}\Wodin.WorkDevice.Desktop.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\Wodin.WorkDevice.Desktop.exe"; Description: "Abrir Wodin WorkDevice"; Flags: nowait postinstall skipifsilent
