function GetOldVersion: string;
var
	reg_path: string;
	version: String;
begin
	Result := '';
	
	reg_path := ExpandConstant('Software\Microsoft\Windows\CurrentVersion\Uninstall\{#SetupSetting("AppId")}_is1');
	if not RegQueryStringValue(HKLM, reg_path, 'DisplayVersion', version) then begin
		if not RegQueryStringValue(HKCU, reg_path, 'DisplayVersion', version) then begin
			Result := '';
		end;
	end;
	Result := version;
end;

var myNeedRestart: Boolean;

function NeedRestart: Boolean;
begin
	Result:= myNeedRestart;
end;

function InitializeSetup: Boolean;
var
	version: String;
	str: String;

begin
	Result := True;
	version := GetOldVersion();
	myNeedRestart := False;
	if version <> '' then
	begin
		if version = '{#SetupSetting("AppVersion")}' then
			str := 'WinDRBD version '+version+' is already installed. It is not neccessary to install it again, unless you manually destroyed the WinDRBD installation. Do you wish to continue?'
		else	
			str := ExpandConstant('Found WinDRBD version '+version+' installed. The version you are about to install is {#SetupSetting("AppVersion")}. You can safely install one over the other, however to restart the driver a reboot is required. Continue?');

		if MsgBox(str, mbInformation, MB_YESNO) = IDNO then
		begin
			MsgBox('Installation aborted.', mbInformation, MB_OK);
			Result := False;
		end;
		myNeedRestart := True;
	end;
end;
