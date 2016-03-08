// by Xeno
// strongly changed by psycho
#include "ai_macros.sqf"
private ["_side","_radius","_pos","_task","_newgroup","_units","_pos_center","_do_patrol","_ret_grps","_special_task","_toCall","_respawns","_numvehicles"];

_grp_type = _this select 0;
_task = _this select 1;
_radius = _this select 2;
_pos_center = _this select 3;
_numvehicles = _this select 4;
_side = _this select 5;
_do_patrol = if (_radius < 50) then {false} else {true};
_special_task = if (typeName _task == "ARRAY") then {true} else {false};

_ret_grps = [];
_pos = [];
_patrol_radius = _radius + (_radius/2);	// + 50%

_newgroup = [_side] call tcb_fnc_ai_creategroup;
_unit_array = [_grp_type, _side] call tcb_fnc_ai_getunitlist;

#ifdef __DEBUG__
diag_log format ["-------------createArmor Group: %1 -- Unit Array: %2", _newgroup, _unit_array];
#endif

_toCall = tcb_fnc_ai_GetRanPointCircle;
if (_special_task) then {
	if (count _task > 2) then {
		_pos = switch (typeName (_task select 2)) do {
			case "STRING" : {getMarkerPos (_task select 2)};
			case "ARRAY" : {(_task select 2)};
			case "OBJECT" : {getPos (_task select 2)};
		};
	} else {
		_toCall = tcb_fnc_ai_GetRanPointCircleOuter;
	};
} else {
	_toCall = tcb_fnc_ai_GetRanPointCircle;
};
if (_radius > 0) then {
	if (count _pos == 0) then {
		for "_ee" from 0 to 99 do {
			_pos = [_pos_center, _radius] call _toCall;
			if (count _pos > 0) exitWith {};
		};
	};
} else {
	_pos = _pos_center;
};
_units = [_numvehicles, _pos, _unit_array select 1, _newgroup, -1.111] call tcb_fnc_ai_makevgroup;
_newgroup allowFleeing tcb_cowardice;
ai_zeus_logic addCuratorEditableObjects [units _newgroup,true];

if (_special_task) then {
	if (toUpper(_task select 0) == "RESPAWN") then {
		_respawns = _this select 1;
		if (count _task > 2) then {
			_respawn_pos = _pos;
		} else {
			_respawn_pos = [];
		};
		[_newgroup, _pos_center] spawn tcb_fnc_ai_taskDefend;
		[_grp_type, _respawns, _pos_center, _radius, _newgroup, _respawn_pos] execFSM (AI_H_PATH + "fsm\SpawnNewGroup.fsm");
	} else {	//ATTACK
		_attack_pos = switch (typeName (_task select 1)) do {
			case "STRING" : {getMarkerPos (_task select 1)};
			case "ARRAY" : {(_task select 1)};
			case "OBJECT" : {getPos (_task select 1)};
		};
		{_x setVariable ["ai_attackStore", [_patrol_radius]]} forEach (units _newgroup);
		[_newgroup, _attack_pos, "this call tcb_fnc_ai_followingTask"] call tcb_fnc_ai_attackWP;
	};
} else {
	if (toUpper(_task) == "DEFEND") then {
		_newgroup setVariable ["ai_defend", true];
		[_newgroup, _pos_center] spawn tcb_fnc_ai_taskDefend;
	} else {
		if (!_do_patrol) then {
			_newgroup setCombatMode "YELLOW";
			_newgroup setFormation (["COLUMN","STAG COLUMN","WEDGE","ECH LEFT","ECH RIGHT","VEE","LINE","DIAMOND"] call tcb_fnc_RandomArrayVal);
			_newgroup setFormDir (floor random 360);
			_newgroup setSpeedMode "NORMAL";
		} else {
			[_newgroup, _pos, [_pos_center, _patrol_radius], [5, 15, 30]] spawn tcb_fnc_ai_makepatrolwpx;
			
			if (ai_IS_HC_CLIENT) then {
				_uid = getplayerUID player;
				_ar = [_newgroup, _pos, _pos_center, _patrol_radius, "VEC"];
				_store = ai_Storage getVariable _uid;
				_store pushBack _ar;
				//ai_Storage setVariable [_uid, _store, true];
				["WPStorage", [_uid, _store]] call tcb_fnc_NetCallEventCTS;
			};
		};
	};
};
_ret_grps pushBack _newgroup;
_ret_grps