// by Xeno
#include "ai_macros.sqf"

private "_uc";
(_this select 0) call (_this select 1);
_uc = (_this select 0) getVariable "ai_unitcode";
if (isNil "_uc") then {
	_uc = [_this select 1];
} else {
	_uc pushBack (_this select 1);
};
(_this select 0) setVariable ["ai_unitcode", _uc];