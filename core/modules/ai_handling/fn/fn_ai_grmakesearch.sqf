//#define __DEBUG__
// by Xeno
#include "ai_macros.sqf"

private ["_xxgrp"];
_xxgrp = _this call ai_getGroup;
if (({alive _x} count (units _xxgrp)) > 1 && {(random 100) > 60}) then {
	[_this] spawn tcb_fnc_ai_searchNearby;
};