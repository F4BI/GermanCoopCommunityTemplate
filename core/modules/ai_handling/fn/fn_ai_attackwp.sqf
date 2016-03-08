private ["_ggrp","_gtarget_pos","_gwp","_wpstatement"];
_ggrp = _this select 0;
_gtarget_pos = _this select 1;
_wpstatement = if (count _this > 2) then {_this select 2} else {""};
_ggrp setbehaviour "AWARE";
_gwp = _ggrp addWaypoint [_gtarget_pos,30];
_gwp setwaypointtype "SAD";
_gwp setWaypointCombatMode "YELLOW";
_gwp setWaypointSpeed "FULL";
if (_wpstatement != "") then {
	_gwp setWaypointStatements ["TRUE", _wpstatement];
};
true