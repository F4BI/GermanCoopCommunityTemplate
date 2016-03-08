// by Rommel
#include "ai_macros.sqf"

private ["_group", "_leader", "_behaviour", "_array", "_building", "_indices", "_count", "_units", "_timeout", "_unit", "_gstate"];
_group = (_this select 0) call ai_getgroup;
_gstate = _group getVariable "ai_gstate";
if (isNil "_gstate" || {_gstate == 2}) exitWith {};
_group lockWp true;
private ["_leader","_behaviour"];
_leader = leader _group;
_behaviour = behaviour _leader;
_group setBehaviour "combat";

private ["_array", "_building", "_indices"];
_array = _leader call tcb_fnc_ai_nearestBuilding;
if (count _array < 2) exitWith {_group lockwp false};
_building = _array select 0;
if (_leader distance _building > 200) exitWith {_group lockWp false};
_indices = _array select 1;
_group setFormdir ([_leader, _building] call tcb_fnc_ai_DirToObj);

private ["_count","_units"];
_units = units _group;
_count = (count _units) - 1;

_timeout = time + 600;

while {_indices > 0 && {_count > 0} && {_timeout > time}} do {
	sleep 10;
	while {_indices > 0 && {_count > 0} && {_timeout > time}} do {
		private "_unit";
		_unit = _units select _count;
		if (unitReady _unit) then {
			_unit commandMove (_building buildingPos _indices);
			_indices = _indices - 1;
		};
		_count = _count - 1;
	};
	_units = units _group;
	_count = (count _units) - 1;
};
waituntil {sleep 3;	{unitReady _x} count _units >= count (units _group) - 1 || {({alive _x} count _units) == 0} || {time > _timeout}};
if (({alive _x} count _units) > 0) then {
	{_x doFollow _leader} forEach _units;
	_group setBehaviour _behaviour;
	_group lockWp false;
};