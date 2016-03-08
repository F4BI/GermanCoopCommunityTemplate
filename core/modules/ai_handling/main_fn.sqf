// by psycho
#include "ai_macros.sqf"
ai_getGroup = {
	if (typeName _this == "GROUP") exitwith {_this};
	group _this
};

ai_GetAliveCrew = {({alive _x} count (crew _this))};
tcb_fnc_ai_getVehicleEmpty = {(_this call ai_GetAliveCrew) == 0};