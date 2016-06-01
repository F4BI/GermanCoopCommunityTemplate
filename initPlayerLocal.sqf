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

geco_killcam_quotes = [
	[(localize "STR_QUOTE_1"),(localize "STR_AUTHOR_1")],
	[(localize "STR_QUOTE_2"),(localize "STR_AUTHOR_2")],
	[(localize "STR_QUOTE_3"),(localize "STR_AUTHOR_3")],
	[(localize "STR_QUOTE_4"),(localize "STR_AUTHOR_4")],
	[(localize "STR_QUOTE_5"),(localize "STR_AUTHOR_5")],
	[(localize "STR_QUOTE_6"),(localize "STR_AUTHOR_6")],
	[(localize "STR_QUOTE_7"),(localize "STR_AUTHOR_7")],
	[(localize "STR_QUOTE_8"),(localize "STR_AUTHOR_8")],
	[(localize "STR_QUOTE_9"),(localize "STR_AUTHOR_9")],
	[(localize "STR_QUOTE_10"),(localize "STR_AUTHOR_10")],
	[(localize "STR_QUOTE_11"),(localize "STR_AUTHOR_11")],
	[(localize "STR_QUOTE_12"),(localize "STR_AUTHOR_12")],
	[(localize "STR_QUOTE_13"),(localize "STR_AUTHOR_13")],
	[(localize "STR_QUOTE_14"),(localize "STR_AUTHOR_14")],
	[(localize "STR_QUOTE_15"),(localize "STR_AUTHOR_15")],
	[(localize "STR_QUOTE_16"),(localize "STR_AUTHOR_16")],
	[(localize "STR_QUOTE_17"),(localize "STR_AUTHOR_17")],
	[(localize "STR_QUOTE_18"),(localize "STR_AUTHOR_18")],
	[(localize "STR_QUOTE_19"),(localize "STR_AUTHOR_19")],
	[(localize "STR_QUOTE_20"),(localize "STR_AUTHOR_20")],
	[(localize "STR_QUOTE_21"),(localize "STR_AUTHOR_21")],
	[(localize "STR_QUOTE_22"),(localize "STR_AUTHOR_22")],
	[(localize "STR_QUOTE_23"),(localize "STR_AUTHOR_23")],
	[(localize "STR_QUOTE_24"),(localize "STR_AUTHOR_24")],
	[(localize "STR_QUOTE_25"),(localize "STR_AUTHOR_25")],
	[(localize "STR_QUOTE_26"),(localize "STR_AUTHOR_26")],
	[(localize "STR_QUOTE_27"),(localize "STR_AUTHOR_27")],
	[(localize "STR_QUOTE_28"),(localize "STR_AUTHOR_28")],
	[(localize "STR_QUOTE_29"),(localize "STR_AUTHOR_29")],
	[(localize "STR_QUOTE_30"),(localize "STR_AUTHOR_30")],
	[(localize "STR_QUOTE_31"),(localize "STR_AUTHOR_31")],
	[(localize "STR_QUOTE_32"),(localize "STR_AUTHOR_32")],
	[(localize "STR_QUOTE_33"),(localize "STR_AUTHOR_33")],
	[(localize "STR_QUOTE_34"),(localize "STR_AUTHOR_34")],
	[(localize "STR_QUOTE_35"),(localize "STR_AUTHOR_35")],
	[(localize "STR_QUOTE_36"),(localize "STR_AUTHOR_36")],
	[(localize "STR_QUOTE_37"),(localize "STR_AUTHOR_37")],
	[(localize "STR_QUOTE_38"),(localize "STR_AUTHOR_38")],
	[(localize "STR_QUOTE_39"),(localize "STR_AUTHOR_39")],
	[(localize "STR_QUOTE_40"),(localize "STR_AUTHOR_40")],
	[(localize "STR_QUOTE_41"),(localize "STR_AUTHOR_41")],
	[(localize "STR_QUOTE_42"),(localize "STR_AUTHOR_42")],
	[(localize "STR_QUOTE_LAST"),(localize "STR_AUTHOR_LAST")]
];
	
diag_log format ["%1 --- TcB i_client.sqf processed",diag_ticktime];