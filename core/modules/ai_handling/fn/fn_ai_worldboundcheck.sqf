private ["_pos","_size"];
_pos = _this;
if (count _pos == 0) exitWith {_pos};
_size = getNumber (configFile >> "CfgWorlds" >> worldName >> "MapSize");

if (_pos select 0 < 0) then {_pos set [0, 200]};
if (_pos select 1 < 0) then {_pos set [1, 200]};
if (_pos select 0 > (_size - 2)) then {_pos set [0, _size - 200]};
if (_pos select 1 > (_size - 2)) then {_pos set [1, _size - 200]};

_pos