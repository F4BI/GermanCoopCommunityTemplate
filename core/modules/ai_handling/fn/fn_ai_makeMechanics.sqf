#include "ai_macros.sqf"
private ["_pos", "_vname", "_grp", "_crews", "_dir", "_vec", "_the_vecs"];

_pos = _this select 0;
_vname = _this select 1;
_grp = _this select 2;

_the_vecs = [];
_crews = [];

_vec_ar = [_pos, (random 360), _vname, _grp] call tcb_fnc_ai_spawnVehicle;
_vec = _vec_ar select 0;
_crews = [_crews, _vec_ar select 1] call tcb_fnc_arrayPushStack2;

_the_vecs pushBack _vec;
	
switch (true) do {
	case (_vec isKindOf "Tank"): {
		if (tcb_LockArmored) then {_vec lock true};
	};
	case (_vec isKindOf "Wheeled_APC"): {
		if (tcb_LockArmored) then {_vec lock true};
	};
	case (_vec isKindOf "Car"): {
		if (tcb_LockCars) then {_vec lock true};
	};
	default {
		if (_vec isKindOf "Air") then {if (tcb_LockAir) then {_vec lock true}};
	};
};

[_grp, 1] call tcb_fnc_ai_setState;
[_the_vecs, _crews]