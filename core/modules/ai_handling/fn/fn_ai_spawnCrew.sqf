#include "ai_macros.sqf"
/*
	File: spawnCrew.sqf
	Author: Joris-Jan van 't Land

	Description:
	Function to fill all crew positions in a vehicle, including turrets.
	In dummy mode no objects are created and the returned array contains only ones.
	In this mode the function can be used to count the actual crew of an existing vehicle or vehicle type.

	Parameter(s):
	_this select 0: the vehicle (Object)
	_this select 1: the crew's group (Group)
	_this select 2: (optional) dummy mode toggle (Boolean)
	_this select 3: (optional) dummy mode type (String)
	_this select 4: (optional) crew type (String)

	Returns:
	Array of Objects or Scalars - newly created crew or crew count
*/
private ["_vehicle", "_grp","_crewType", "_unit", "_hasDriver", "_type", "_entry", "_crew"];
_vehicle = _this select 0;
_grp = _this select 1;


/*	keine Gruppenzuweisung möglich(Umweg: joinSilent, leere Gruppe löschen)
_sim = toUpper getText (configFile/"CfgVehicles"/_typev1/"simulation");
if (_sim in ["AIRPLANEX", "HELICOPTERX"]) exitWith {
	createVehicleCrew _vehicle;
	[_grp, 1] call ai_setState;
	_crew = crew _vehicle;
	if (isNil "_crew") then {__TRACE_1("no crew for %1 created", _vehicle)};
	_crew
};
*/

_type = typeOf _vehicle;
_entry = configFile/"CfgVehicles"/_type;
_crew = [];
_hasDriver = getNumber (_entry/"hasDriver");
_crewType = [side _grp, _entry, _type] call tcb_fnc_ai_selectCrew;

if (_hasDriver == 1 && {isNull (driver _vehicle)}) then {
	_unit = _grp createUnit [_crewType select 0, position _vehicle, [], 0, "NONE"];
	if (!isNil "_unit" && {!isNull _unit}) then {
		if (tcb_remove_nv) then {_unit call tcb_fnc_removeNVG};
		if (tcb_remove_fak) then {_unit removeItem "FirstAidKit"};
		_unit setVariable ["BIS_noCoreConversations", true];
		_crew pushBack _unit;
		_unit moveInDriver _vehicle;
	};
};

_turrets = [_entry/"turrets"] call tcb_fnc_ai_returnVehicleTurrets;

_funcSpawnTurrets = {
	private ["_turrets", "_path"];
	_turrets = _this select 0;
	_path = _this select 1;

	private "_i";
	_i = 0;
	while {_i < (count _turrets)} do {
		private ["_turretIndex", "_thisTurret"];
		_turretIndex = _turrets select _i;
		_thisTurret = _path + [_turretIndex];

		// Workaround for YAAB (Yet Another ArmA Bug)
		// don't spawn a commander in ZSUs, otherwise they don't fire at targets
		// introduced in one of the betas before 1.59
		if ((_vehicle isKindOf "O_APC_Tracked_02_AA_F" || {_vehicle isKindOf "B_APC_Tracked_01_AA_F"}) && {count _thisTurret > 1}) exitWith {};
		
		if (isNull (_vehicle turretUnit _thisTurret)) then {
			_unit = _grp createUnit [_crewType select 0, position _vehicle, [], 0, "NONE"];
			if (!isNull _unit) then {
				if (tcb_remove_nv) then {_unit call tcb_fnc_ai_removeNVG};
				if (tcb_remove_fak) then {_unit removeItem "FirstAidKit"};
				_unit setVariable ["BIS_noCoreConversations", true];
				_crew pushBack _unit;
				_unit moveInTurret [_vehicle, _thisTurret];
			};
		};
		[_turrets select (_i + 1), _thisTurret] call _funcSpawnTurrets;
		_i = _i + 2;
	};
};

[_turrets, []] call _funcSpawnTurrets;

if !(isNull (driver _vehicle)) then {(driver _vehicle) setRank "LIEUTENANT"};
if !(isNull (gunner _vehicle)) then {(gunner _vehicle) setRank "SERGEANT"};
if !(isNull (effectiveCommander _vehicle)) then {(effectiveCommander _vehicle) setRank "CORPORAL"};

[_grp, 1] call tcb_fnc_ai_setState;
_crew call tcb_fnc_ai_setSkill;

_crew