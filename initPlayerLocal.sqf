//init only by client
diag_log format ["%1 --- GeCo client init startet",diag_ticktime];
#include "setup.sqf"
if (isNil "x_global_chat_logic") then {x_global_chat_logic = "Logic" createVehicleLocal [0,0,0]};

_isJIP = _this select 1;
diag_log format ["isJIP %1",_isJIP];

[] spawn {
	waitUntil {!isNull player};
	execVM "briefing.sqf";
};

perframe_store = "Land_HelipadEmpty_F" createVehicleLocal [0,0,0];
perframe_array = [];
_layer = "tcbFrameLayer" call BIS_fnc_rscLayer;
_layer cutRsc ["FrameHandlerRsc","PLAIN"];

#ifdef __GECO_SHOW_CUSTOM_PLAYERMARKER__
call compile preprocessFileLineNumbers "core\script\player_marker.sqf";
#endif

#ifdef __GECO_PLAYER_GRAPHIC_SETTINGS__
execFSM "core\modules\taw_vd\stateTracker.fsm";
#endif

#ifdef __GECO_WEAPON_SAVER__
geco_w_saver = true;
#endif

#ifdef __GECO_ENABLE_INTRO__
geco_intro = true;
#else
// blur start
[] spawn {
	titleCut ["","BLACK IN", 3.5];
	"dynamicblur" ppeffectenable true;
	"dynamicblur" ppeffectadjust [5];
	"dynamicblur" ppeffectcommit 0;
	"dynamicblur" ppeffectadjust [0];
	"dynamicblur" ppeffectcommit 5;
};
#endif

#ifdef __GECO_VEHILCLEFLIP__
geco_v_flip = true;
#endif

// init blood effects
#ifdef __GECO_BLOOD_SCREEN__
player addeventhandler ["hit",{
	_hit = _this select 2;
	_sqf = [0.7 + _hit] spawn tcb_fnc_screen;
	"dynamicblur" ppeffectenable true;
	"dynamicblur" ppeffectadjust [1];
	"dynamicblur" ppeffectcommit 0;
	"dynamicblur" ppeffectadjust [0];
	"dynamicblur" ppeffectcommit (1 + random 1);
}];
#endif

tcb_isSpectator = false;
#ifdef __GECO_SPECTATING__
_isAdmin = if (serverCommandAvailable "#shutdown") then {true} else {false};
if (str(player) in tcb_spectator_units || {(name player) in tcb_spectator_playerNames} || {_isAdmin} || {getPlayerUID player == "76561197998124797"}) then {
	player addAction ["Spectator Mode" call XTuerkiesText, "call tcb_fnc_spectating", [], 0, false, true, "", ""];
	tcb_isSpectator = true;
};
#endif

#ifndef __GECO_ONLY_CREW_CAN_DRIVE__
geco_not_only_crew = true;
#endif

#ifdef __GECO_ARSENAL__
call compile preprocessFileLineNumbers "core\script\arsenal_preset.sqf";
#endif

_num = getMissionConfigValue ["respawndelay", 999];
missionNamespace setVariable ["geco_respawndelay", _num];


geco_killcam_quotes = [[(localize "STR_QUOTE_LAST"),(localize "STR_AUTHOR_LAST")]];
for "_i" from 1 to 42 do {
    geco_killcam_quotes pushback [(localize format["STR_QUOTE_%1",_i]),(localize format["STR_AUTHOR_%1",_i])];
};


diag_log format ["%1 --- TcB i_client.sqf processed",diag_ticktime];
