#include "ai_macros.sqf"
private ["_name", "_uid", "_pa", "_oldwtime", "_connecttime", "_newwtime"];
if (count _this <= 0) exitWith {"Error in AI Handing OPD - empty array" call BIS_fnc_logFormat};
_name = _this select 3;
_uid = _this select 2;
if (_name == "__SERVER__") exitWith {};
if (_name == "__SERVER__") exitWith {};
if (isNil "ai_HC_CLIENT_OBJ_NAME") exitWith {};
if (_name != ai_HC_CLIENT_OBJ_NAME) exitWith {};

if (!isNil "ai_HC_CLIENT_OBJ" && {!isNil "ai_HC_CLIENT_OBJ_NAME"} && {ai_HC_CLIENT_OBJ_NAME != ""} && {_name == ai_HC_CLIENT_OBJ_NAME}) then {
	ai_HC_CLIENT_OBJ = nil;
	ai_HC_CLIENT_OBJ_NAME = nil;
};

_storage = ai_Storage getVariable _uid;
#ifdef __DEBUG__
["%1 --- HC disconnected. HC WP-Storage: %2",diag_ticktime,_storage] call BIS_fnc_logFormat;
#endif

[] spawn {
	if (count _storage > 0) then {	// reboot the waypoints of patroling groups on the server after HC lost connection
		{
			_grp = (_this select _forEachIndex) select 0;
			if ((count units _grp > 0) && {({alive _x} count units _grp) > 0}) then {
				_index = _this select _forEachIndex;
				if (toUpper(_index select 4) == "VEC") then {
					[_grp, _index select 1, [_index select 2, _index select 3], [5, 15, 30]] spawn tcb_fnc_ai_makepatrolwpx;
				} else {
					[_grp, _index select 1, [_index select 2, _index select 3], [5, 15, 30], "this call tcb_fnc_ai_grmakesearch"] spawn tcb_fnc_ai_makepatrolwpx;
				};
			} else {
				{deleteVehicle _x} forEach units _grp;
				deleteGroup _grp;
			};
			sleep 1.312; // can be load intensive!
		} forEach _storage;
		#ifdef __DEBUG__
		["%1 --- Server has reboot waypoints of patrol groups after HC lost connection",diag_ticktime] call BIS_fnc_logFormat;
		#endif
	};
};