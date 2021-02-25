//  LEGO Island Alternate Installer
//  Created 2012-2021 Triangle717
//  <http://triangle717.wordpress.com/>
//  Contains source code from Grim Fandango Setup
//  Copyright (c) 2007-2008 Bgbennyboy
//  <http://quick.mixnmojo.com/>

[Code]

var
	DrvLetters: array of AnsiString;

	function GetDriveType( lpDisk: AnsiString ): Integer;
	external 'GetDriveTypeA@kernel32.dll stdcall';

	function GetLogicalDriveStrings( nLenDrives: LongInt; lpDrives: AnsiString ): Integer;
	external 'GetLogicalDriveStringsA@kernel32.dll stdcall';

const
	UniqueFile = 'DATA\disk\LEGOISLE.exe';

	DRIVE_UNKNOWN = 0; // The drive type cannot be determined.
	DRIVE_NO_ROOT_DIR = 1; // The root path is invalid. For example, no volume is mounted at the path.
	DRIVE_REMOVABLE = 2; // The disk can be removed from the drive.
	DRIVE_FIXED = 3; // The disk cannot be removed from the drive.
	DRIVE_REMOTE = 4; // The drive is a remote (network) drive.
	DRIVE_CDROM = 5; // The drive is a CD-ROM drive.
	DRIVE_RAMDISK = 6; // The drive is a RAM disk.

//Convert disk type to string
function DriveTypeString( dtype: Integer ): AnsiString ;
begin
	case dtype of
		DRIVE_NO_ROOT_DIR : Result := 'Root path invalid';
		DRIVE_REMOVABLE : Result := 'Removable';
		DRIVE_FIXED : Result := 'Fixed';
		DRIVE_REMOTE : Result := 'Network';
		DRIVE_CDROM : Result := 'CD-ROM';
		DRIVE_RAMDISK : Result := 'Ram disk';
		else
			Result := 'Unknown';
	end;
end;

procedure FindAllCdDrives();
var
	n: Integer;
	drivesletters: AnsiString; lenletters: Integer;
	drive: AnsiString;
	disktype, posnull: Integer;
	sd: AnsiString;
begin
	//get the system drive
	sd := UpperCase(ExpandConstant('{sd}'));

	//get all drives letters of system
	drivesletters := StringOfChar( ' ', 64 );
	lenletters := GetLogicalDriveStrings( 63, drivesletters );
	SetLength( drivesletters , lenletters );

	drive := '';
	n := 0;
	while ( (Length(drivesletters) > 0) ) do
	begin
		posnull := Pos( #0, drivesletters );
		if posnull > 0 then
		begin
			drive:= UpperCase( Copy( drivesletters, 1, posnull - 1 ) );

			// get number type of disk
			disktype := GetDriveType( drive );

			//Make sure its a cd drive
			if disktype = DRIVE_CDROM then
			begin
				SetArrayLength(DrvLetters, N+1);
				DrvLetters[n] := drive;
				n := n + 1;
			end;

			drivesletters := Copy( drivesletters, posnull+1, Length(drivesletters));
		end;
	end;
end;

function FindUniqueFile(): Ansistring;
var
	i: integer;
begin
	for i:=0 to GetArrayLength(DrvLetters) -1 do
	begin
		if FileExists( DrvLetters[i] + UniqueFile) then
		begin
			result:=DrvLetters[i];
			exit;
		end
		else

	end;

	result:='';
end;

function GetSourceCdDrive(): Ansistring;
begin
	FindAllCdDrives();
	if GetArrayLength(DrvLetters) < 1 then
	begin
    // Play on the most famous non-glitch LEGO Island quote. :P
		MsgBox('Whoops! I cannot find any disc drives attached to your computer.', mbError, MB_OK);
		Abort;
	end;


	if FindUniqueFile() <> '' then
	begin
// 		MsgBox('', mbError, MB_OK);
	end
	else
	begin
		while FindUniqueFile() = '' do
		begin
      // Oh so true!
			if MsgBox('Whoops! You have to put the CD in your computer.', mbConfirmation, MB_OKCANCEL or MB_DEFBUTTON1) = IDOK then

			else
				Abort;
		end;
	end;

	Result:=FindUniqueFile();
end;
