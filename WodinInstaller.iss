[Setup]
AppId={{C2B45F8A-5F53-4B89-8D92-1FEC7C6C9B11}
AppName=Wodin WorkDevice
AppVersion=1.0.0
AppPublisher=Intimesoft
DefaultDirName={localappdata}\Intimesoft\WorkDevice
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
SetupIconFile=wodin.ico

[Languages]
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"

[Tasks]
Name: "desktopicon"; Description: "Criar atalho na área de trabalho"; GroupDescription: "Opções adicionais:"; Flags: unchecked

[Files]
Source: "WorkDevice\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "instaladores\node.msi"; DestDir: "{tmp}"; Flags: deleteafterinstall

[Icons]
Name: "{group}\Wodin WorkDevice"; Filename: "{app}\Wodin.WorkDevice.Desktop.exe"
Name: "{autodesktop}\Wodin WorkDevice"; Filename: "{app}\Wodin.WorkDevice.Desktop.exe"; Tasks: desktopicon

[Run]
Filename: "msiexec.exe"; Parameters: "/i ""{tmp}\node.msi"" /quiet /norestart"; StatusMsg: "Instalando Node.js..."; Flags: waituntilterminated
Filename: "{app}\Wodin.WorkDevice.Desktop.exe"; Description: "Abrir Wodin WorkDevice"; Flags: nowait postinstall skipifsilent