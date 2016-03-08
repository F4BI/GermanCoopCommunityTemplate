// by Xeno
#include "ai_macros.sqf"
private ["_side", "_ret_list", "_list"];
_side = _this select 0;
_ret_list = [];
{
	_list = [_x,_side] call tcb_fnc_ai_getUnitList;
	_ret_list pushBack [_list select 0, _list select 1];
} forEach [switch (floor random 2) do {case 0: {"motor_aa"};case 1: {"motor_at"};}];
//forEach [switch (floor random 2) do {case 0: {"motor_aa"};case 1: {"motor_at"};}, "car_armed", "car", "car_armed"];
_ret_list