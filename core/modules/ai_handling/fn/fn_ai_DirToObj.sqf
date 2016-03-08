// direction from one object to another
// example: _dir = [tank1, apc1] call tcb_fnc_ai_DirToObj;

private ["_o1","_o2","_deg"];
_o1 = _this select 0;_o2 = _this select 1;
_deg = ((position _o2 select 0) - (position _o1 select 0)) atan2 ((position _o2 select 1) - (position _o1 select 1));
if (_deg < 0) then {_deg = _deg + 360};
_deg