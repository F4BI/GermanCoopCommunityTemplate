private ["_vehicle","_position","_enterer"];
if (tcb_b_check_crew == 0) exitWith {};
_vehicle = _this select 0;
_position = _this select 1;
_enterer = _this select 2;
if !(player == _enterer) exitWith {};
if (_position == "gunner" || _position == "driver") then {
	if !(typeOf _enterer in tcb_crew) then {
		[_enterer] spawn tcb_fnc_Eject;
		TitleRsc ["only_crew", "plain", 0.5];
	};
};
true