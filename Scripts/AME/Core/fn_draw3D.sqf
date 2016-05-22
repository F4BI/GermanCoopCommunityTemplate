_playerPos = positionCameraToWorld [0, 0, 0];
_targets = _playerPos nearObjects ["Man", 10];
if (!surfaceIsWater _playerPos) then {
    _playerPos = ATLtoASL _playerPos;
};

{
    _target = effectiveCommander _x;

    if (!(_x in allUnitsUAV) && (side _target) getFriend playerSide >= 0.6 && isPlayer _target && _target != player) then {
        _targetPos = visiblePositionASL _target;
        _distance = _targetPos distance _playerPos;
        _height = [2, 1.5, 1, 1.5, 1] select (["STAND", "CROUCH", "PRONE", "UNDEFINED", ""] find stance _target);
    
        _alpha = ((1 - 0.2 * (_distance - 5)) min 1) * 0.8;
    
        if (_alpha > 0) then {
            if (lineIntersects [_playerPos, _targetPos vectorAdd [0,0,1], vehicle player, _target]) then {
                _alpha = 0;
            };
        };
    
        _color = if (group _target == group player) then {[0.77, 0.51, 0.08, _alpha]} else {[1, 1, 1, _alpha]};
        _targetPos set [2, ((_target modelToWorld [0,0,0]) select 2) + _height + _distance * 0.026];
    
        _text = "";
        {
            _text = _text + " " + _x;
        } count (_target getVariable ["AME_Core_displayText", []]);
    
        drawIcon3D ["", _color, _targetPos, 0, 0, 0, _text, 2, 0.033, "PuristaMedium"];
    };
} count _targets;