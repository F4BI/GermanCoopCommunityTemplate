_objectToReplace = _this select 0;
_objectTypeToSpawn = _this select 1;

_objPosition = _objectToReplace call AME_Core_fnc_getPos;
_objDir = getDir _objectToReplace;
_objDamage = damage _objectToReplace;

_objLoadedItems = _objectToReplace getVariable ["AME_Load_loadedObjects", []];

player allowDamage false;

deleteVehicle _objectToReplace;

sleep 0.01;

_newObject = createVehicle [_objectTypeToSpawn, _objPosition, [], 0, "CAN_COLLIDE"];
_newObject setDir _objDir;
_newObject setDamage _objDamage;

[[_objectToReplace, _newObject], "AME_BuildFOB_fnc_addToZeus", 1, true, true] call AME_Core_fnc_execRemoteFnc;

_newObject setVariable ["AME_Load_loadedObjects", _objLoadedItems, true];

player allowDamage true;

_newObject