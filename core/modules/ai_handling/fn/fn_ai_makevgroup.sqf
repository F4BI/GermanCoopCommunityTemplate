// by Xeno
#include "ai_macros.sqf"
private ["_numvecs", "_pos", "_vname", "_grp", "_direction", "_crews", "_grpskill", "_n", "_dir", "_vec", "_npos", "_the_vecs", "_nnvnum"];

_numvecs = _this select 0;
_pos = _this select 1;
_vname = _this select 2;
_grp = _this select 3;
_direction = _this select 4;

_the_vecs = [];
_crews = [];
_npos = _pos;
_grpskill = if (_vname isKindOf "StaticWeapon") then {1.0} else {(tcb_skill_array select 0) + (random (tcb_skill_array select 1))};
_the_vecs resize _numvecs;
_nnvnum = _numvecs - 1;

for "_n" from 0 to _nnvnum do {
	_dir = if (_direction != -1.111) then {_direction} else {floor random 360};
	
	_vec_ar = [_npos, _dir, _vname, _grp] call tcb_fnc_ai_spawnVehicle;
	_vec = _vec_ar select 0;
	__addDead(_vec);
	_crews = [_crews, _vec_ar select 1] call tcb_fnc_arrayPushStack2;
	
	_the_vecs pushBack _vec;
	if (_n < _nnvnum) then {
		_npos = _vec modelToWorld [0,-12,0];
	};
	
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
};

(leader _grp) setUnitAbility _grpskill;
[_grp, 1] call tcb_fnc_ai_setState;
[_the_vecs, _crews]