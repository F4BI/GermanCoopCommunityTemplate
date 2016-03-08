// by Rommel
#include "ai_macros.sqf"

private ["_building", "_i", "_r"];
_building = nearestBuilding _this;
if (isNull _building) exitWith {[]};
_i = 0;
_r = -1;
while {str(_building buildingPos _i) != "[0,0,0]"} do {
	_i = _i + 1;
	_r = _r + 1;
};
if (_r == -1) exitWith {[]};
[_building, _i]