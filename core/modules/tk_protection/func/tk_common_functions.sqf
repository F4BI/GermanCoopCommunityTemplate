﻿#include "tk_macros.sqf"
TKfSystemChat = {systemChat _this};

TKfTKKickCheck = {
	private ["_tk", "_storage", "_numtk", "_uid"];
	_tk = _this select 0;
	_uid = getPlayerUID _tk;
	_storage = TcB_Ref_Point getVariable _uid;
	if (!isNil "_storage") then {
		_numtk = (_storage select 2) + 1;
		TcB_Ref_Point setVariable [_uid, [(_storage select 0), _uid, _numtk, (_storage select 3), (_storage select 4), (_storage select 5), (_storage select 6), (_storage select 7)], true];
		if (_numtk >= tcb_max_num_tk) then {
			["tk_kick", (_storage select 0)] call TKNetCallEvent;
			["tk_global_message",[format ["%1 was kicked automatically from the Server.", name _tk]]] call TKNetCallEvent;
			["tk_end_mission", [_tk]] call TKNetCallEvent;
			diag_log format ["Mission Protection System: %1 was kicked automatically from the Server.", name _tk];
		};
	};
};

TK_p_c = {
	private ["_name","_uid","_cp","_p_name_old"];
	_name = _this select 0;
	_uid = _this select 1;
	if (_name == "__SERVER__") exitWith {};
	
	_cp = TcB_Ref_Point getVariable _uid;
	
		// 0	- 	Players Name
		// 1	-	UID
		// 2	-	Number Teamkills
		// 3	-	Number Satchels
		// 4	-	Bool, Vehicle Protection Time for JIP passed
		// 5	-	Captcha Q/A
		// 6	-	Number Captcha Fails
		// 7	-	Bool Captcha passed

	if (isNil "_cp") then {
		TcB_Ref_Point setVariable [_uid, [_name, _uid, 0, 0, false, "", 0, false], true];
		[_name, _uid, 0, 0, false, "", 0, false] call set_new_player_events;
		tcb_known_player = nil;
	} else {
		_p_name_old = _cp select 0;
		if (_name != _p_name_old) then {
			_txt = format ["Mission Protection System: %2 has changed his name to %1",_name,_p_name_old];
			diag_log _txt;
			["tk_global_message",[_txt]] call TKNetCallEvent;
		};
		tcb_known_player = true;
		[_name, _uid, (_cp select 2), (_cp select 3), (_cp select 4), (_cp select 5), (_cp select 6), (_cp select 7)] call set_knowing_player_events;
	};
	[player] execVM tk_path + "jip_vehicle_saver.sqf";
};

// return true if given Object in defined range of TK_base_Point -tk's
TKfgetBaseRange = {
	private ["_bool"];
	_bool = if ((_this distance TcB_Ref_Point) < (tcb_tk_handler select 1)) then {true} else {false};
	_bool
};

// return true if given Object in defined range of TK_base_Point - satchels
TKfgetBaseRange2 = {
	private ["_bool"];
	_bool = if ((_this distance TcB_Ref_Point) < (tcb_satchel_handler select 2)) then {true} else {false};
	_bool
};

// return true if given Object in defined range of TK_base_Point - grenades
TKfgetBaseRange3 = {
	private ["_bool"];
	_bool = if ((_this distance TcB_Ref_Point) < (tcb_grenade_handler select 1)) then {true} else {false};
	_bool
};

// count and storabe base shoots
TKfcount_Shoots = {
	private ["_shooter","_storage","_num","_uid"];
	_shooter = _this select 0;
	_uid = getPlayerUID _shooter;
	_storage = TcB_Ref_Point getVariable _uid;
	if (!isNil "_storage") then {
		_num = (_storage select 3);
		_num = _num + 1;
		TcB_Ref_Point setVariable [_uid, [(_storage select 0), _uid, (_storage select 2), _num, (_storage select 4), (_storage select 5), (_storage select 6), (_storage select 7)], true];
	};
	_num
};

TK_fcreateLog = {
	private ["_noob","_reason","_uid","_name","_txt"];
	_noob = _this select 0;
	_reason = _this select 1;
	_uid = getPlayerUID _noob;
	_name = name _noob;
	_txt = format ["Name: %1 , Reason: %3 , ArmA3 UID: %2",_name,_uid,_reason];
	player createDiaryRecord ["tk_log", [_name, _txt]];
	diag_log ("Mission Protection System: " + _txt);
};