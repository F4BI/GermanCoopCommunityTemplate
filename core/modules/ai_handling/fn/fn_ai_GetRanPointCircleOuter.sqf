// get a random point at the borders of a circle
// parameters:
// center position, radius of the circle
// example: _random_point = [position trigger1, 200] call tcb_fnc_ai_GetRanPointCircleOuter;

private ["_center", "_radius", "_co", "_angle", "_center_x", "_center_y"];
_center = _this select 0;
_radius = _this select 1;
_center_x = _center select 0;
_center_y = _center select 1;
_ret_val = [];
for "_co" from 0 to 100 do {
	_angle = floor (random 360);
	_posee = [_center_x - (_radius * sin _angle), _center_y - (_radius * cos _angle), 0];
	_isFlat = _posee isFlatEmpty [
		2,	//--- Minimal distance from another object
		0,	//--- If 0, just check position. If >0, select new one
		0.7,//--- Max gradient
		4,	//--- Gradient area
		0,	//--- 0 for restricted water, 2 for required water,
		false,		//--- True if some water can be in 25m radius
		objNull		//--- Ignored object
	];
	if (count _isFlat > 0) exitWith {
		//"mmm" setMarkerPos _isFlat;
		_ret_val = ASLToATL _isFlat;
	};
};
_ret_val