private["_unit"];
_units = _this;
if (typeName _units != typeName []) then {_units = [_units]};

{
	_x = if (toUpper(typeName _x) == "ARRAY") then {_x select 0} else {_x};
	_x setUnitAbility ((tcb_skill_array select 0) + (random (tcb_skill_array select 1)));
	_x setSkill ["spotDistance", tcb_spotDistance];
	_x setSkill ["spotTime", tcb_spotTime];
	_x setSkill ["aimingSpeed", tcb_aimingSpeed];
	_x setSkill ["aimingShake", tcb_aimingShake];
	_x setSkill ["aimingAccuracy", tcb_aimingAccuracy];
} forEach _units;

true