private ["_unit","_vec"];
_unit = _this select 0;
_vec = vehicle _unit;
_unit action ["ENGINEOFF", _vec];
_unit action ["Eject",_vec];
_vec setVelocity [0,0,0];
sleep 1.1;
if (isEngineOn _vec) then {
	_vec engineOn false;
	_unit action ["engineOff", _vec];
};

//diag_log format ["kick %1 from %2",_unit,_vec];

_unit action ["GetOut",_vec];		// "Eject" no longer work on every vehicle (only jets)
_vec setVelocity [0, 0, 0];
disableUserInput false;