//#define __DEBUG__
#include "ai_macros.sqf"
private ["_grp","_side"];
_side = _this select 0;

_grp = createGroup _side;
// GVAR(gstate)
// 0 = created
// 1 = filled with units
// 2 = reduced
[_grp, 0] call tcb_fnc_ai_setState;
#ifdef __DEBUG__
["createGroup: %1 --- Side: %2",_grp,_side] call BIS_fnc_logFormat;
#endif

_grp