// by joko (?)
// changed by psycho

#define TEXTURES_RANKS [ \
    "", \
    "\A3\Ui_f\data\GUI\Cfg\Ranks\private_gs.paa", \
    "\A3\Ui_f\data\GUI\Cfg\Ranks\corporal_gs.paa", \
    "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa", \
    "\A3\Ui_f\data\GUI\Cfg\Ranks\lieutenant_gs.paa", \
    "\A3\Ui_f\data\GUI\Cfg\Ranks\captain_gs.paa", \
    "\A3\Ui_f\data\GUI\Cfg\Ranks\major_gs.paa", \
    "\A3\Ui_f\data\GUI\Cfg\Ranks\colonel_gs.paa" \
    ]

_playerPos = positionCameraToWorld [0, 0, 0];
//_targets = player nearEntities ["CAManBase", 12];			// <--- psycho: changed to nearEntities (more performance and exclude dead units), also use CAManBase cause animals also "Man"

_targets = [];	// psychO: only cursorTarget...

// add also cursorTarget to show the name of a long range aiming spot
_cursorTarget = cursorTarget;
if (_cursorTarget isKindOf "CAManBase") then {
	if (!(_cursorTarget in _targets)) then {
		_targets pushBack _cursorTarget;
	};
};

if (!surfaceIsWater _playerPos) then {
    _playerPos = ATLtoASL _playerPos;
};

if ((count _targets) > 0) then {			// only if someone is in array
	{
		_target = effectiveCommander _x;

		if (
				_target != player &&
				{isPlayer _target} &&
				{!(_x in allUnitsUAV)} &&
				{alive player} /*&&*/
				//{str(playerside) == (_target getVariable ["jk_var_side","CIV"])}
			) then {
			_targetPos = visiblePositionASL _target;
			_distance = _targetPos distance _playerPos;
			_headPosition = _target modelToWorldVisual (_target selectionPosition "pilot");
			_alpha = ((1 - 0.2 * (_distance - 8) min 1) * 0.8);

			if (lineIntersects [_playerPos, _targetPos vectorAdd [0,0,1], vehicle player, _target]) exitWith {};
		
			_color = if (group _target == group player) then {
				_tempColor = [
					[1,1,1,_alpha],//Main
					[1,0,0.1,_alpha],//Red
					[0.1,1,0,_alpha],//Green
					[0.1,0,1,_alpha],//Blue
					[1,1,0.1,_alpha]//Yellow
				] select (["MAIN","RED","GREEN","BLUE","YELLOW"] find assignedTeam _target);
				_tempColor
			} else {
				[0.77, 0.51, 0.08, _alpha]	// orange
			};
			
			_text = name _target;
			_class = "";
			_class = getText (configFile >> "CfgVehicles" >> typeOf(_target) >> "DisplayName");
			_icon = "";
			
			if (_target in (missionNamespace getVariable ["BIS_revive_units", []]) || {_target getVariable ["FAR_isUnconscious",0] == 1}) then {
				_icon = "\A3\Ui_f\data\IGUI\Cfg\Cursors\unitbleeding_ca.paa";
				_text = _text + " (Unconscious)";
			} else {
			   _text = _text + call {
					if (str(_target) in ["opz_1","opz_2"]) exitWith {" (OPZ)"};
					if (str(_target) in ["pilot_1"]) exitwith {" (Pilot)"};
					if (str(_target) in tcb_p_entities) exitWith {format [" (%1)", (tcb_p_entities select 1)]};
					(" (" + _class + ")");
				};
				_icon = TEXTURES_RANKS select ((["PRIVATE", "CORPORAL", "SERGEANT", "LIEUTENANT", "CAPTAIN", "MAJOR", "COLONEL"] find (rank _target)) + 1);
			};
			drawIcon3D [_icon, _color, _headPosition vectorAdd [0, 0, 0.4], 0.8, 0.8, 0, _text, 2, 0.033, "PuristaMedium"];
		};
		true

	} count _targets;
};


true