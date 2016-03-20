diag_log format ["%1 --- TcB player_jip.sqf startet",diag_ticktime];
if (!X_Client || {!isNil "jip_started"}) exitWith {};
jip_started = true;

if (ai_IS_HC_CLIENT) exitWith {
	diag_log "Headless client found";
	call compile preprocessFileLineNumbers (AI_H_PATH+"setupHC.sqf");
};

_curators = [];
_curators = call BIS_fnc_listCuratorPlayers;
if (!isNil "TCB_CURATOR") then {
	if (!isNull TCB_CURATOR) then {
		if (player in _curators && {str(player) == "TCB_CURATOR"}) then {
			_logic = getAssignedCuratorLogic player;
			_logic addCuratorPoints 1;
			_logic setVariable ["tcb_zeus", [player, getplayerUID player], true];
			0 spawn {
				waitUntil {!isNil "intro_done"};
				openCuratorInterface;
			};
		};
	};
};

//["addToCurator", player] call tcb_fnc_netCallEventCTS;

private ["_strp", "_i"];
_strp = str(player);
tcb_respawns = 0;

if (!isNil "geco_w_saver") then {
	player addEventhandler ["killed", {[_this select 0, [missionNamespace, "tcb_inv"]] call BIS_fnc_saveInventory}];
};

player AddEventHandler ["Respawn",{_this call tcb_fnc_playerRespawn}];
player AddEventHandler ["killed",{
	_this spawn {
		sleep (120 + random 60);
		deleteVehicle (_this select 0);
	};
}];

// 3D EH's
removeAllMissionEventHandlers "Draw3D";
tcb_draw3D_reset_done = true;

//Nametags
if !((isClass (configFile >> "CfgPatches" >> "cba_ee")) && ((isClass (configFile >> "CfgPatches" >> "A3C_NameTag")) || (isClass (configFile >> "CfgPatches" >> "STNametags")))) then {
	AME_Nametag_EVH = addMissionEventHandler ["Draw3D", {_this call tcb_fnc_NameTags}];
};

if (difficultyEnabled "3rdPersonView") then {
	addMissionEventHandler ["Draw3D", {
		if ((cameraView == "EXTERNAL") && {vehicle player == player}) then {
			vehicle player switchCamera "INTERNAL";
		};
	}];
};

if (tcb_b_check_pilot == 1) then {
	if (!(typeOf player in tcb_pilots)) then {
		addMissionEventHandler ["Draw3D", {
			if ((vehicle player) isKindOf "Air" && player == assignedDriver (vehicle player) || {player == (vehicle player) turretUnit [0] && (vehicle player) isKindOf "Air"}) then {
				if (!(typeOf (vehicle player) in ["Steerable_Parachute_F", "NonSteerable_Parachute_F"])) then {
					player action ["GetOut",vehicle player];
					TitleRsc ["only_pilots", "plain", 0.5];
				};
			};
		}];
	};
};

if (isNil "geco_not_only_crew") then {
	if (tcb_b_check_crew == 1) then {
		if (!(typeOf player in tcb_crew)) then {
			addMissionEventHandler ["Draw3D", {
				if (player == driver (vehicle player)) then {
					if ((vehicle player) isKindOf "Tank") then {
						player action ["GetOut",vehicle player];
						TitleRsc ["only_crew", "plain", 0.5];
					};
				};
			}];
		};
	};
};

if (!isNil "geco_intro") then {
	execVM "core\script\geco_intro.sqf";
};

waitUntil {!isNull (findDisplay 46)};
(findDisplay 46) displayAddEventHandler ["KeyDown", {_this call tcb_fnc_earPlugs}];

if (!isNil "HC_AI_UNIT") then {
	if (!isNull HC_AI_UNIT) then {
		hideObject HC_AI_UNIT;
	};
};

// vehicle flip
tcb_vecFlip = false;
if (!isNil "geco_v_flip") then {
	player addAction ["unflip Vehicle" call XTuerkiesText, "call tcb_fnc_unFlip", [], 0, false, true, "", "[_this] call tcb_fnc_flipCheck"];
	tcb_vecFlip = true;
};

deleteVehicle client_jip_init_trigger;
client_jip_init_trigger = nil;
diag_log format ["%1 --- TcB player_jip.sqf processed",diag_ticktime];