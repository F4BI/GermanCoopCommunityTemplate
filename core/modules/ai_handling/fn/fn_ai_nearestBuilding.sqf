// by Rommel
#include "ai_macros.sqf"


private _building = nearestBuilding _this;
if (isNull _building) exitWith {[]};
private _count = {!(_x isEqualTo [0,0,0])} count (_building buildingPos -1);
if (_count == 0) exitWith {[]};
[_building, _i]
