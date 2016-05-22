{
    if ((_this select 0) in curatorEditableObjects _x) then {
        _x addCuratorEditableObjects [[_this select 1], false];
    };
} count allCurators;