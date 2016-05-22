if (isDedicated || !hasInterface) exitWith {};

[
    "Load container on HEMTT",
    ["Land_Cargo20_military_green_F", "Land_Cargo20_white_F"],
    3,
    "isNull (attachedTo _target) && count ((_target call AME_Core_fnc_getPos) nearEntities [""B_Truck_01_mover_F"", 10]) > 0",
    {
        _container = _this select 0;
        _truck = ((_container call AME_Core_fnc_getPos) nearEntities ["B_Truck_01_mover_F", 10]) select 0;
                
        [
            "Loading", 
            22,
            {
                _container = _this select 0;
                _truck = _this select 1;
                
                _container attachTo [_truck, [0, -2.75, 1]];
                _container setDir 270;
                _container attachTo [_truck, [0, -2.75, 1]]; // doesn't work
                _container setDir 270;
                [_container, "{ _this setDir 270; }", 1, false, false] call AME_Core_fnc_execRemoteFnc;
                
                _truck setVariable ["AME_BuildFOB_Container", _container, true];
            },
            [_container, _truck]
        ] call AME_Core_fnc_Progress_showBar;
    }
] call AME_Core_fnc_Interaction_addAction;

[
    "Unload container for FOB",
    ["B_Truck_01_mover_F"],
    3,
    "speed _target == 0 && !isNull (_target getVariable [""AME_BuildFOB_Container"", objNull])",
    {
        _truck = _this select 0;
        
        _position = (_truck modelToWorld [0, -4, 0]) findEmptyPosition [0.25, 7.5, "Land_Cargo20_military_green_F"];
        if (count _position == 0) exitWith {hintSilent "Not enough space to unload"};
        
        [
            "Unloading",
            9,
            {
                _truck = _this select 0;
                _position = _this select 1;
                _container = _truck getVariable ["AME_BuildFOB_Container", objNull];
                
                player allowDamage false;
                
                detach _container;
                _container setPos _position;
                
                player allowDamage true;
                
                _truck setVariable ["AME_BuildFOB_Container", objNull, true];
            },
            [_truck, _position]
        ] call AME_Core_fnc_Progress_showBar;
    }
] call AME_Core_fnc_Interaction_addAction;

[
    "Build FOB",
    ["Land_Cargo20_military_green_F", "Land_Cargo20_white_F"],
    3,
    "isNull (attachedTo _target)",
    {
        _container = _this select 0;
        
        _position = (_container call AME_Core_fnc_getPos) findEmptyPosition [0.25, 8.5, "Land_Cargo_House_V3_F"];
        if (count _position == 0) exitWith {hintSilent "Not enough space for FOB"};
        
        [
            "Building",
            22,
            {
                _container = _this select 0;
                
                if (_container isKindOf "Land_Cargo20_white_F") then {
                    _house = [_container, "Land_Medevac_house_V1_F"] call AME_BuildFOB_fnc_replaceObject;
                    _additionalItems = [];
                    {
                        _sheet = createVehicle ["Land_Ground_sheet_khaki_F", _house modelToWorld (_x select 0), [], 0, "CAN_COLLIDE"];
                        _sheet setDir (_x select 1);
                        _additionalItems pushBack _sheet;
                        true
                    } count [
                        [[1.6 , 1, 0], 0],
                        [[-1 , 1, 0], 110],
                        [[-1 , 3, 0.1], 90]
                    ];
                    _house setVariable ["AME_BuildFOB_additionalItems", _additionalItems, true];
                } else {
                    [_container, "Land_Cargo_House_V3_F"] call AME_BuildFOB_fnc_replaceObject;
                };
                
            },
            [_container]
        ] call AME_Core_fnc_Progress_showBar;
    }
] call AME_Core_fnc_Interaction_addAction;

[
    "Take down FOB",
    ["Land_Cargo_House_V3_F", "Land_Medevac_house_V1_F"],
    3,
    "true",
    {
        _container = _this select 0;
                
        [
            "Taking down", 
            22,
            {
                _container = _this select 0;
                
                _additionalItems = _container getVariable ["AME_BuildFOB_additionalItems", []];
                {
                    deleteVehicle _x;
                    true
                } count _additionalItems;
                
                if (_container isKindOf "Land_Medevac_house_V1_F") then {
                    [_container, "Land_Cargo20_white_F"] call AME_BuildFOB_fnc_replaceObject;
                } else {
                    [_container, "Land_Cargo20_military_green_F"] call AME_BuildFOB_fnc_replaceObject;
                };
            },
            [_container]
        ] call AME_Core_fnc_Progress_showBar;
    }
] call AME_Core_fnc_Interaction_addAction;