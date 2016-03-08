// by Xeno
#include "ai_macros.sqf"
private ["_grp", "_gstate"];
_grp = _this select 0;
_gstate = _this select 1;

_grp setVariable ["ai_gstate", _gstate];
if (ai_IS_HC_CLIENT) then {
	["setgrps", _grp] call tcb_fnc_NetCallEventCTS;
};