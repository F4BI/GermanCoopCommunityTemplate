// by psycho
#include "ai_macros.sqf"
private ["_xxgrp","_ua","_pos","_task","_store","_patrol_radius"];
_xxgrp = _this call ai_getGroup;
_ua = units _xxgrp;

if (({alive _x} count _ua) > 1) then {
	_store = (_ua select 0) getVariable "ai_attackStore";
	_pos = position (leader _xxgrp);
	_patrol_radius = _store select 0;
	_task = if (count _store > 1) then {_store select 1} else {"true"};
	_pos = position (leader _xxgrp);
	[_xxgrp, _pos, [_pos, _patrol_radius], [5, 15, 30], _task] spawn tcb_fnc_ai_makepatrolwpx;
};