// get a random point inside a square
// parameters:
// center position, a and b (like in triggers), angle
// example: _random_point  = [position trigger2, 200, 300, 30] call tcb_fnc_ai_GetRanPointSquare;

private ["_pos", "_a", "_b", "_angle", "_centerx", "_centery", "_leftx", "_lefty", "_width", "_height", "_co", "_px1", "_py1", "_radius", "_atan"];
_pos = _this select 0;
_a = _this select 1;
_b = _this select 2;
_angle = _this select 3;
	
_centerx = _pos select 0;_centery = _pos select 1;_leftx = _centerx - _a;_lefty = _centery - _b;
_width = 2 * _a;_height = 2 * _b;_ret_val = [];
for "_co" from 0 to 99 do {
	_px1 = _leftx + random _width; _py1 = _lefty + random _height;
	_radius = _pos distance [_px1,_py1];
	_atan = (_centerx - _px1) atan2 (_centery - _py1);
	_posee = [_centerx - (_radius * sin (_atan + _angle)), _centery - (_radius * cos (_atan + _angle)), 0];
	_isFlat = _posee isFlatEmpty [
		2,				//--- Minimal distance from another object
		0,				//--- If 0, just check position. If >0, select new one
		0.7,			//--- Max gradient
		4,				//--- Gradient area
		0,				//--- 0 for restricted water, 2 for required water,
		false,			//--- True if some water can be in 25m radius
		objNull			//--- Ignored object
	];
	if (count _isFlat > 0) exitWith {
		//"mmm" setMarkerPos _isFlat;
		_ret_val = ASLToATL _isFlat;
	};
};
_ret_val