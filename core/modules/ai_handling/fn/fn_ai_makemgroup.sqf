// by Xeno
// changed by psycho
#include "ai_macros.sqf"
private ["_pos", "_unitliste", "_grp", "_ret", "_retv"];
_pos = _this select 0;
_unitliste = _this select 1;
_grp = _this select 2;

_ret = [];
_retv = [];
{
	if (getText(configFile >> "CfgVehicles" >> _x >> "vehicleclass") in ["Men","MenRecon","MenUrban","MenSupport","MenSniper","MenDiver","MenStory"]) then {
		_one_unit = _grp createunit [_x, _pos, [], 10,"NONE"];
		if (_forEachIndex <= 0) then {
			_grp selectLeader _one_unit;
		};
		if (tcb_remove_nv) then {_one_unit call tcb_fnc_removeNVG};
		if (tcb_remove_fak) then {_one_unit removeItem "FirstAidKit"};
		_svec = sizeOf _x;
		_isFlat = (position _one_unit) isFlatEmpty [_svec / 2, 150, 0.7, _svec, 0, false, _one_unit];
		if (count _isFlat > 1) then {
			_isFlat set [2,0];
			if (_one_unit distance _isFlat < 50) then {
				_one_unit setPos _isFlat;
			};
		};
		_one_unit setVariable ["BIS_noCoreConversations", true];
		_ret pushBack _one_unit;
	} else {
		_v_a = [_pos, _x, _grp] call tcb_fnc_ai_makeMechanics;
		_retv pushBack (_v_a select 0);
		_ret pushBack (_v_a select 1);
	};
	sleep 0.05;
} foreach _unitliste;

(leader _grp) setRank "SERGEANT";
[_grp, 1] call tcb_fnc_ai_setState;
_ret call tcb_fnc_ai_setSkill;

[_ret, _retv]