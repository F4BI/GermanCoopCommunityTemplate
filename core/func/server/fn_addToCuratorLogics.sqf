// by psycho
params ["_obj"];

_incLogic = objectCurators _obj;

if (!(_cLogic in _incLogic)) then {
	{_x addCuratorEditableObjects [[_obj], true]} forEach allCurators;
};

true