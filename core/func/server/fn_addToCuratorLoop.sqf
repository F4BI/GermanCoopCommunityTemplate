_lastAllCurators = allCurators;

{
	_x addCuratorEditableObjects [(allMissionObjects "Thing"), false];
	_x addCuratorEditableObjects [vehicles, true];
	_x addCuratorEditableObjects [(allMissionObjects "Building"), false];
	_x addCuratorEditableObjects [(entities "CAManBase"), false];
	_x removeCuratorEditableObjects [(allMissionObjects "Static"), false];
} count _lastAllCurators;

{
    if (local _x) then {
        _x setGroupOwner (owner (allCurators select count allCurators));
    };
} count allGroups;


waitUntil {!(_lastAllCurators isEqualTo allCurators)};
true spawn tcb_fnc_addToCuratorLoop;