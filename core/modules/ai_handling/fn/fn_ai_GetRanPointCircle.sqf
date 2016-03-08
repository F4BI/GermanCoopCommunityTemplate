// get a random point inside a circle
// parameters:
// center position, radius of the circle
// example: _random_point = [position trigger1, 200] call tcb_fnc_ai_GetRanPointCircle;
#include "ai_macros.sqf"

private ["_rcenter", "_rradius", "_co", "_center_x", "_center_y", "_posee","_isFlat", "_ret_val"];
_rcenter = _this select 0;
_rradius = _this select 1;

_center_x = _rcenter select 0;_center_y = _rcenter select 1;
_ret_val = [];
for "_co" from 0 to 150 do {
	_posee = [_center_x + (_rradius - (random (2 * _rradius))), _center_y + (_rradius - (random (2 * _rradius))), 0];
	_isFlat = _posee isFlatEmpty [
		2,	//--- Minimal distance from another object
		0,	//--- If 0, just check position. If >0, select new one
		0.7,//--- Max gradient
		4,	//--- Gradient area
		0,	//--- 0 for restricted water, 2 for required water,
		false,	//--- True if some water can be in 25m radius
		objNull	//--- Ignored object
	];
	if (count _isFlat > 0) exitWith {
		//"mmm" setMarkerPos _isFlat;
		_ret_val = ASLToATL _isFlat;
		#ifdef __DEBUG__
		_marker = createMarkerLocal [str(_ret_val),_ret_val];
		_marker setMarkerTypeLocal "waypoint";
		_marker setMarkerColorLocal "ColorBlufor";
		#endif
	};
};
_ret_val