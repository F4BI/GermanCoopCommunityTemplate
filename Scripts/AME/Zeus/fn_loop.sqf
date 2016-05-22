_lastAllCurators = allCurators;
{
    _x addCuratorEditableObjects [allUnits, true];
    _x addCuratorEditableObjects [vehicles, true];
    _x addCuratorEditableObjects [playableUnits, true];
} count _lastAllCurators;

{
    if (local _x) then {
        _x setGroupOwner (owner (allCurators select count allCurators));
    };
} count allGroups;

waitUntil {!(_lastAllCurators isEqualTo allCurators)};
true spawn AME_Zeus_fnc_loop;