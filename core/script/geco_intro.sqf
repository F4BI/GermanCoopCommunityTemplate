private ["_camera"];
if (ai_IS_HC_CLIENT) exitWith {};
enableRadio false;
_viewDistance = viewDistance;
setViewDistance 1500;
["LeadTrack05_F_EPC", 30] spawn tcb_fnc_JukeBox;

waitUntil {!isNil "BIS_fnc_init"};
waitUntil {!isNull (findDisplay 46)};
[0,0,false] spawn BIS_fnc_cinemaBorder;
if (sunOrMoon == 0) then {camUseNVG true};

_pos = [getPosASL player, 50, getDir player] call BIS_fnc_relPos;
_camera = "camera" camCreate [_pos select 0, _pos select 1, 10];
waitUntil {preloadCamera _pos};
sleep 1;
titleCut ["","BLACK IN", 4];

"dynamicblur" ppeffectenable true;
"dynamicblur" ppeffectadjust [4];
"dynamicblur" ppeffectcommit 0;
"dynamicblur" ppeffectadjust [0];
"dynamicblur" ppeffectcommit 6;


_camera camSetTarget [getPosASL player select 0, getPosASL player select 1 , (getPosATL player select 2) + 1.5];
_camera camSetFov 0.7;
_camera cameraEffect ["INTERNAL", "Back"];
_camera camCommit 1;
waitUntil {camCommitted _camera};
waitUntil {!isNull (findDisplay 46)};
_layer = "tcbIntroLayer" call BIS_fnc_rscLayer;
_layer cutRsc ["geco_Label", "PLAIN"];
titleRsc ["have_fun", "PLAIN"];

_camera camSetTarget player;
_camera camSetPos [getPosASL player select 0, getPosASL player select 1, (getPosATL player select 2) + 1.8];
_camera camCommit 5;
waitUntil {camCommitted _camera};
player cameraEffect ["terminate","back"];
camDestroy _camera;
closeDialog 0;
enableRadio true;

[1, nil, false] spawn BIS_fnc_cinemaBorder;
sleep 1;


_mName = "";
_mName = getText (missionConfigFile >> "MissionSQM" >> "Mission">> "Intel" >> "briefingName");
if (_mName == "") then {
	_mName = getMissionConfigValue ["onLoadName", "M-Name not Defined!"];
};
_mAuthor = getMissionConfigValue ["author", "M-Author not Defined!"];
[parseText format [ "<t align='right' size='1.2'><t font='PuristaBold' size='1.6'>""%1""</t><br/>%2</t>", _mName, "made by: " + _mAuthor], true, nil, 7, 0.7, 0] spawn BIS_fnc_textTiles;

setViewDistance _viewDistance;

sleep 3;
intro_done = true;
enableSaving [false, false];