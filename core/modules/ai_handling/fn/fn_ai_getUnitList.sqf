// by Xeno
#include "ai_macros.sqf"
private ["_grptype","_how_many","_list","_one_man","_side","_side_char","_unitliste","_vehiclename","_varray"];
_grptype = _this select 0;
_side = _this select 1;

_unitliste = [];
_vehiclename = "";
_list = [];
_varray = [];

_side_char = if (typeName _side == "STRING") then {
	switch (_side) do {case "OPFOR": {"E"};case "BLUFOR": {"W"};case "INDEPENDENT": {"G"};;case "RESISTANCE": {"G"};case "CIV": {"W"};case "EAST": {"E"};case "WEST": {"W"};}
} else {
	switch (_side) do {case opfor: {"E"};case blufor: {"W"};case independent: {"G"};case resistance: {"G"};case civilian: {"W"};}
};
["%1 --- SideChar",_side_char] call BIS_fnc_logFormat;

switch (_grptype) do {
	case "basic": {_list = missionNamespace getVariable format ["ai_allmen_%1",_side_char];_unitliste = _list call tcb_fnc_RandomArrayVal};
	case "specops": {_list = missionNamespace getVariable format ["ai_allmen_%1",_side_char];_unitliste = _list call tcb_fnc_RandomArrayVal};
	
	case "motor_basic": {_list = (missionNamespace getVariable format ["ai_mot_%1", _side_char]) select 0;_unitliste = _list;};
	case "motor_at": {_list = (missionNamespace getVariable format ["ai_mot_%1", _side_char]) select 1;_unitliste = _list;};
	case "motor_aa": {_list = (missionNamespace getVariable format ["ai_mot_%1", _side_char]) select 2;_unitliste = _list;};

	case "mech_basic": {_list = (missionNamespace getVariable format ["ai_mech_%1", _side_char]) select 0;_unitliste = _list;};
	case "mech_at": {_list = (missionNamespace getVariable format ["ai_mech_%1", _side_char]) select 1;_unitliste = _list;};
	case "mech_aa": {_list = (missionNamespace getVariable format ["ai_mech_%1", _side_char]) select 2;_unitliste = _list;};
	case "mech_support": {_list = (missionNamespace getVariable format ["ai_mech_%1", _side_char]) select 3;_unitliste = _list;};

	case "tank_section": {_list = (missionNamespace getVariable format ["ai_section_%1", _side_char]) select 0;_unitliste = _list;};
	case "apc_section": {_list = (missionNamespace getVariable format ["ai_section_%1", _side_char]) select 1;_unitliste = _list;};
	case "tank_apc_platoon": {_list = (missionNamespace getVariable format ["ai_section_%1", _side_char]) select 2;_unitliste = _list;};
	

	//case "heli": {_list = missionNamespace getVariable format ["ai_allmen_%1",_side_char];_unitliste = _list call tcb_fnc_RandomArrayVal};
	case "mbt": {_varray = (missionNamespace getVariable format ["ai_veh_a_%1", _side_char]) select 0;_vehiclename = _varray call tcb_fnc_RandomArrayVal};
	case "apc_tracked": {_varray = (missionNamespace getVariable format ["ai_veh_a_%1", _side_char]) select 1;_vehiclename = _varray call tcb_fnc_RandomArrayVal};
	case "apc_wheeled": {_varray = (missionNamespace getVariable format ["ai_veh_a_%1", _side_char]) select 2;_vehiclename = _varray call tcb_fnc_RandomArrayVal};
	case "aa": {_varray = (missionNamespace getVariable format ["ai_veh_a_%1", _side_char]) select 3;_vehiclename = _varray call tcb_fnc_RandomArrayVal};
	case "car_armed": {_varray = (missionNamespace getVariable format ["ai_veh_a_%1", _side_char]) select 4;_vehiclename = _varray call tcb_fnc_RandomArrayVal};
	case "car": {_varray = (missionNamespace getVariable format ["ai_veh_a_%1", _side_char]) select 5;_vehiclename = _varray call tcb_fnc_RandomArrayVal};
	case "static_light": {_varray = (missionNamespace getVariable format ["ai_veh_a_%1", _side_char]) select 6;_vehiclename = _varray call tcb_fnc_RandomArrayVal};
	case "static_heavy": {_varray = (missionNamespace getVariable format ["ai_veh_a_%1", _side_char]) select 7;_vehiclename = _varray call tcb_fnc_RandomArrayVal};
	case "static_mortar": {_varray = (missionNamespace getVariable format ["ai_veh_a_%1", _side_char]) select 8;_vehiclename = _varray call tcb_fnc_RandomArrayVal};
	case "supply_fuel": {_varray = (missionNamespace getVariable format ["ai_veh_a_%1", _side_char]) select 9;_vehiclename = _varray call tcb_fnc_RandomArrayVal};
	case "supply_rep": {_varray = (missionNamespace getVariable format ["ai_veh_a_%1", _side_char]) select 10;_vehiclename = _varray call tcb_fnc_RandomArrayVal};
	case "supply_ammo": {_varray = (missionNamespace getVariable format ["ai_veh_a_%1", _side_char]) select 11;_vehiclename = _varray call tcb_fnc_RandomArrayVal};
};

#ifdef __DEBUG__
["------------ Units: %1  ------ Vehicle: %2",_unitliste,_vehiclename] call BIS_fnc_logFormat;
#endif
if ("dummy" in _unitliste) exitWith {
	hintC "Guerrila hasn't heavy sections! review your selections.";
};
[_unitliste, _vehiclename]

