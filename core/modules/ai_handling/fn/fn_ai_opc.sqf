#include "ai_macros.sqf"
private ["_name","_uid"];
if (count _this <= 0) exitWith {"Error in AI Handing OPC - empty array" call BIS_fnc_logFormat};
_name = _this select 3;
_uid = _this select 2;
if (_name == "__SERVER__") exitWith {};

_isHC = false;
if (isNil "ai_HC_CLIENT_OBJ") then {
	{
		if (str _x == "HC_AI_UNIT") exitWith {
			ai_HC_CLIENT_OBJ = _x;
			ai_HC_CLIENT_OBJ_NAME = _name;
			_isHC = true;
		};
	} forEach playableUnits;
};
if (!_isHC) exitWith {};
#ifdef __DEBUG__
["%1 --- HC has connected - start init the wp-storage",diag_ticktime] call BIS_fnc_logFormat;
#endif
ai_Storage setVariable [_uid, [], true];