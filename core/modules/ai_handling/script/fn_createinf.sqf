// by Xeno
// strongly changed by psycho
#include "ai_macros.sqf"
private ["_patrol_radius","_side","_radius","_pos","_task","_newgroup","_units","_pos_center","_do_patrol","_ret_grps","_special_task","_toCall","_respawns","_respawn_pos","_unit_array","_cnt","_cnt_again","_attack_pos"];

_grp_type = _this select 0;
_task = _this select 1;
_radius = _this select 2;
_pos_center = _this select 3;
_side = _this select 4;
_do_patrol = if (_radius < 50) then {false} else {true};
_special_task = if (typeName _task == "ARRAY") then {true} else {false};

_ret_grps = [];
_pos = [];
_patrol_radius = _radius + (_radius / 4);	// + 25%

_newgroup = [_side] call tcb_fnc_ai_creategroup;
_unit_array = [_grp_type, _side] call tcb_fnc_ai_getUnitList;


// strange Bug --> workaround cause checked classes arent counted as unit or do anything - ghost unit - wtf!
#ifdef __DEBUG__
diag_log format ["------------- suggested unit array: %1", _unit_array select 0];
#endif
_unit_array_0 = [];
_cnt = count (_unit_array select 0);
_unit_array_0 = (_unit_array select 0) - ["O_soldier_AAA_F","O_soldier_AAT_F","O_soldier_AAR_F"];
_unit_array set [0, _unit_array_0];
_cnt_again = count (_unit_array select 0);
if (_cnt_again < _cnt) then {
	_diff = _cnt - _cnt_again;
	for "_j" from 1 to _diff do {(_unit_array select 0) pushback "O_soldier_F"};
};
#ifdef __DEBUG__
diag_log format ["-------------createInf filtered Unit Array: %1", _unit_array];
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
if (_radius > 50) then {
	if (count _pos == 0) then {
		for "_ee" from 0 to 99 do {
			_pos = [_pos_center, _radius] call _toCall;
			if (count _pos > 0) exitWith {};
		};
	};
} else {
	_pos = _pos_center;
};

_units = [_pos, _unit_array select 0, _newgroup] call tcb_fnc_ai_makemgroup;	//Attention! can return staged array: [unit1,unit2,[vehicle1,crewArray]]
_newgroup allowFleeing tcb_cowardice;
ai_zeus_logic addCuratorEditableObjects [units _newgroup,false];

if (_special_task) then {
	if (toUpper(_task select 0) == "RESPAWN") then {
		_respawns = _task select 1;
		if (count _task > 2) then {
			_respawn_pos = _pos;
		} else {
			_respawn_pos = [];
		};
		[_newgroup, _pos_center] spawn tcb_fnc_ai_taskDefend;
		[_grp_type, _respawns, _pos_center, _radius, _newgroup, _respawn_pos] execFSM (AI_H_PATH + "fsm\SpawnNewGroup.fsm");
	} else {	//ATTACK
		if (count _task > 1) then {
			_attack_pos = switch (typeName (_task select 1)) do {
				case "STRING" : {getMarkerPos (_task select 1)};
				case "ARRAY" : {(_task select 1)};
				case "OBJECT" : {getPos (_task select 1)};
			};
		} else {
			_attack_pos = _pos_center;
		};
		{_x setVariable ["ai_attackStore", [_patrol_radius, "this call tcb_fnc_ai_grmakesearch"]]} forEach (units _newgroup);
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
			[_newgroup, _pos, [_pos_center, _patrol_radius], [5, 15, 30], "this call tcb_fnc_ai_grmakesearch"] spawn tcb_fnc_ai_makepatrolwpx;
			
			if (ai_IS_HC_CLIENT) then {
				_uid = getplayerUID player;
				_ar = [_newgroup, _pos, _pos_center, _patrol_radius, "INF"];
				_store = ai_Storage getVariable _uid;
				_store pushBack _ar;
				//ai_Storage setVariable [_uid, _store, true];
				["WPStorage", [_uid, _store]] call tcb_fnc_NetCallEventCTS;
			};
		};
	};
};
_ret_grps pushBack _newgroup;

if (tcb_doRespawnGroups) then {
	ai_reduce_groups pushBack _newgroup;
};

_ret_grps