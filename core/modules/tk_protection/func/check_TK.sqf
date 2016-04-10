// check for Teamkill and count them
#include "tk_macros.sqf"
params ["_killer","_killed"];

if (isNil "_killer") exitWith {};
if (isNull _killer) exitWith {};

if (tcb_max_num_tk < 999999) then {
	if (!isNull _killer && isPlayer _killer && vehicle _killer != vehicle _killed) then {
		if (tcb_auto_kick) then {[_killer] call TKfTKKickCheck};
		[_killer, "Teamkiller"] call get_Penalty;
	};
};