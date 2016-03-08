/*
	Author: Eightysix
	changed by psycho

	Description:


	Syntax:

*/
private["_unit"];
_units = _this;
if (typeName _units != typeName []) then {_units = [_units]};

{
	//_x removeAllEventHandlers "HandleDamage";
	_x addEventHandler ["HandleDamage",{
		_damage = (_this select 2)*2;
		BIS_hitArray = _this; BIS_wasHit = true; // For BIS stuff to work
		_damage
	}];
} forEach _units;