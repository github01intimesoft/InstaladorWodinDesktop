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

[Code]
var
  ParamSubdomain: string;
  ParamToken: string;

function JsonEscape(const Value: string): string;
var
  S: string;
begin
  S := Value;
  StringChangeEx(S, '\', '\\', True);
  StringChangeEx(S, '"', '\"', True);
  Result := S;
end;

function InitializeSetup(): Boolean;
begin
  ParamSubdomain := ExpandConstant('{param:SUBDOMAIN|}');
  ParamToken := ExpandConstant('{param:TOKEN|}');

  Log('SUBDOMAIN recebido: ' + ParamSubdomain);
  Log('TOKEN recebido: ' + ParamToken);

  if Trim(ParamSubdomain) = '' then
  begin
    MsgBox('O parâmetro SUBDOMAIN não foi informado.', mbError, MB_OK);
    Result := False;
    exit;
  end;

  if Trim(ParamToken) = '' then
  begin
    MsgBox('O parâmetro TOKEN não foi informado.', mbError, MB_OK);
    Result := False;
    exit;
  end;

  Result := True;
end;

procedure CreateAppSettings();
var
  ConfigPath: string;
  JsonContent: string;
begin
  ConfigPath := ExpandConstant('{app}\appsettings.json');

  JsonContent :=
    '{' + #13#10 +
    '  "url": {' + #13#10 +
    '    "production": {' + #13#10 +
    '      "Protocolo": "https://",' + #13#10 +
    '      "SubDomain": "www",' + #13#10 +
    '      "Domain": "wodin.com.br"' + #13#10 +
    '    },' + #13#10 +
    '    "development": {' + #13#10 +
    '      "Protocolo": "http://",' + #13#10 +
    '      "Domain": "localhost:61201"' + #13#10 +
    '    }' + #13#10 +
    '  },' + #13#10 +
    '  "whatsApiSettings": {' + #13#10 +
    '    "portaApi": 3000,' + #13#10 +
    '    "portaNavegadorDebugging": 9222,' + #13#10 +
    '    "defaultUrlSignalR": "http://localhost:61201/WorkDeviceHub"' + #13#10 +
    '  },' + #13#10 +
    '  "auth": {' + #13#10 +
    '    "SubDomain": "' + JsonEscape(ParamSubdomain) + '",' + #13#10 +
    '    "Token": "' + JsonEscape(ParamToken) + '"' + #13#10 +
    '  }' + #13#10 +
    '}';

  if SaveStringToFile(ConfigPath, JsonContent, False) then
  begin
    Log('appsettings.json criado com sucesso em: ' + ConfigPath);
  end
  else
  begin
    MsgBox('Não foi possível criar o arquivo appsettings.json.', mbError, MB_OK);
  end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssInstall then
  begin
    CreateAppSettings();
  end;
end;