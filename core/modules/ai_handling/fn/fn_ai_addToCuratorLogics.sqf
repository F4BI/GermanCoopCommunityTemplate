// by psycho
params [["_obj",objNull,[]]];

_incLogic = objectCurators _obj;

if (!(_obj in _incLogic)) then {
	{_x addCuratorEditableObjects [[_obj], true]} forEach allCurators;
};

true