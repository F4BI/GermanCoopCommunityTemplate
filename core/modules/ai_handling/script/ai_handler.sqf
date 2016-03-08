// by psycho
#include "ai_macros.sqf"
if (!isServer && {!ai_IS_HC_CLIENT}) exitWith {};
waitUntil {time > 5};	// delay for 5seconds after mission start for init the hc
if (call tcb_fnc_ai_HCorServer) exitWith {["%1 --- Server had left the spawn script cause HC is present",diag_ticktime] call BIS_fnc_logFormat;};
private ["_trigger","_cnt","_handle","_grp_type","_a_radius","_center","_i", "_num"];

_trigger = _this select 0;
_center = position (_this select 0);
_cnt = count _this;

for "_i" from 1 to (_cnt - 1) do {
	_handle = _this select _i;
	_grp_type = _handle select 0;
	
	if (_grp_type in ["basic","specops","motor_basic","motor_at","motor_aa","mech_basic","mech_at","mech_aa","mech_support","tank_section","apc_section","tank_apc_platoon"]) then {
		_a_radius = _handle select 1;
		_task = if (count _handle > 2) then {_handle select 2} else {"PATROL"};
		_side = if (count _handle > 3) then {_handle select 3} else {tcb_enemy};
		#ifdef __DEBUG__
		diag_log format ["-------------ai_handler center: %1 -- count: %2 --- task: %3", _center, _cnt, _task];
		#endif
		[_grp_type, _task, _a_radius, _center, _side] spawn tcb_fnc_ai_createInf;
	} else {
		_a_radius = if (count _handle > 1) then {_handle select 1} else {200};	// action radius
		_num = if (count _handle > 2) then {_handle select 2} else {1};			// number of vehicles from given type
		if (typeName _num == "ARRAY") exitWith {hintC "Wrong Data format in a vehicle spawn trigger. Please check your setup.";};
		if (_num > 10) then {
			hintC "You had set a epic number of vehicles in one of your ai-spawn triggers! The number was reduced to a moderate value to protect the system against overload. Please check your setup.";
			_num = 6;
		};
		_task = if (count _handle > 3) then {_handle select 3} else {"PATROL"};	// task
		_side = if (count _handle > 4) then {_handle select 4} else {tcb_enemy};
		[_grp_type, _task, _a_radius, _center, _num, _side] spawn tcb_fnc_ai_createArmor;
	};
	sleep 2.13;
};