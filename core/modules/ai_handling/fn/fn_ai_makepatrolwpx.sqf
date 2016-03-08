// by Xeno
#include "ai_macros.sqf"

// supports also patrols in square areas, including angle
private ["_grp", "_start_pos", "_wp_array", "_i", "_wp_pos", "_counter", "_wp", "_wppos", "_pos", "_cur_pos","_no_pos_found", "_wpstatements", "_timeout", "_wp1"];
_grp = _this select 0;
_start_pos = _this select 1;
_wp_array = _this select 2;

if (typeName _wp_array == "OBJECT") then {_wp_array = position _wp_array};
if (typeName _wp_array != "ARRAY") exitWith {};
if (typeName _start_pos == "OBJECT") then {_start_pos = position _start_pos};
if (typeName _start_pos != "ARRAY" || {count _start_pos == 0} || {isNull _grp}) exitWith {};

_timeout = if (count _this > 3) then {_this select 3} else {[]};
_wpstatements = if (count _this > 4) then {_this select 4} else {""};
_grp setBehaviour "SAFE";
_cur_pos = _start_pos;
_no_pos_found = false;

#ifdef __DEBUG__
_marker = createMarkerLocal [str(_grp)+str(_start_pos),_start_pos];
_marker setMarkerTextLocal str(_grp)+"start";
_marker setMarkerTypeLocal "waypoint";
_marker setMarkerColorLocal "ColorOpfor";
["%1 --- Waypoint Array",_wp_array] call BIS_fnc_logFormat;
#endif

for "_i" from 0 to (2 + (floor (random 3))) do {
	_wp_pos = switch (count _wp_array) do {
		case 2: {[_wp_array select 0, _wp_array select 1] call tcb_fnc_ai_GetRanPointCircle};
		case 4: {[_wp_array select 0, _wp_array select 1, _wp_array select 2, _wp_array select 3] call tcb_fnc_ai_GetRanPointSquare};
	};
	if (count _wp_pos == 0) exitWith {_no_pos_found = true};
	_counter = 0;
	while {_wp_pos distance _cur_pos < ((_wp_array select 1)/6) && {_counter < 100}} do {
		_wp_pos = switch (count _wp_array) do {
			case 2: {[_wp_array select 0, _wp_array select 1] call tcb_fnc_ai_GetRanPointCircle};
			case 4: {[_wp_array select 0, _wp_array select 1, _wp_array select 2, _wp_array select 3] call tcb_fnc_ai_GetRanPointSquare};
		};
		if (count _wp_pos == 0) exitWith {};
		_counter = _counter + 1;
	};
	if (count _wp_pos == 0) exitWith {_no_pos_found = true};
	_wp_pos = _wp_pos call tcb_fnc_ai_worldboundcheck;
	_cur_pos = _wp_pos;
	_wp = _grp addWaypoint [_wp_pos, 0];
	#ifdef __DEBUG__
	_marker = createMarkerLocal [str(_grp)+str(_wp),_wp_pos];
	_marker setMarkerTextLocal str(_grp)+str(_wp);
	_marker setMarkerTypeLocal "waypoint";
	#endif
	_wp setWaypointType "MOVE";
	_wp setWaypointCompletionRadius (0 + random 10);
	if (count _timeout > 0) then {
		_wp setWaypointTimeout _timeout;
	};
	
	if (_i == 0) then {
		_wp setWaypointSpeed "LIMITED";
		_wp setWaypointFormation "STAG COLUMN";
	};
	if (_wpstatements != "") then {
		_wp setWaypointStatements ["TRUE", _wpstatements];
	};
};

if (_no_pos_found) exitWith {
	_wp1 = _grp addWaypoint [_start_pos, 0];
	_wp1 setWaypointType "SAD";
	#ifdef __DEBUG__
	_marker = createMarkerLocal [str(_grp)+str(_wp1),_wp_pos];
	_marker setMarkerTextLocal str(_grp)+str(_wp1);
	_marker setMarkerTypeLocal "waypoint";
	#endif
};

_wp1 = _grp addWaypoint [_start_pos, 0];
#ifdef __DEBUG__
_marker = createMarkerLocal [str(_grp)+str(_wp1),_wp_pos];
_marker setMarkerTextLocal str(_grp)+str(_wp1);
_marker setMarkerTypeLocal "waypoint";
#endif
_wp1 setWaypointType "MOVE";
_wp1 setWaypointCompletionRadius (10 + random 10);

if (count _timeout > 0) then {
	_wp1 setWaypointTimeout _timeout;
};
if (_wpstatements != "") then {
	_wp1 setWaypointStatements ["TRUE", _wpstatements];
};

_wp = _grp addWaypoint [_start_pos, 0];
#ifdef __DEBUG__
_marker = createMarkerLocal [str(_grp)+str(_wp),_wp_pos];
_marker setMarkerTextLocal str(_grp)+"ende";
_marker setMarkerTypeLocal "waypoint";
_marker setMarkerColorLocal "ColorOpfor";
#endif
_wp setWaypointType "CYCLE";
_wp setWaypointCompletionRadius (10 + random 10);