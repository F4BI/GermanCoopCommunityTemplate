//by psycho
private ["_player_obj", "_corpse"];
_player_obj = _this select 0;
_corpse = _this select 1;

// search config for curator, if yes -> server set curator respawn
if (player call BIS_fnc_isCurator) then {
	["resetCurator", _player_obj, _corpse] call tcb_fnc_netCallEventCTS;
};

// search for existing curator logics and add player to them
if (count allCurators > 0) then {
	["addToCuratorLogics", _player_obj] call tcb_fnc_netCallEventCTS;
};

[] spawn {
	titleCut ["","BLACK IN", 3.5];
	"dynamicblur" ppeffectenable true;
	"dynamicblur" ppeffectadjust [5];
	"dynamicblur" ppeffectcommit 0;
	"dynamicblur" ppeffectadjust [0];
	"dynamicblur" ppeffectcommit 5;
};

// loadout
if (!isNil "geco_w_saver") then {
	[player, [missionNamespace, "tcb_inv"]] call BIS_fnc_loadInventory;
};

// vehicle flip
if (tcb_vecFlip) then {
	player addAction ["unflip Vehicle" call XTuerkiesText, "call tcb_fnc_unFlip", [], 0, false, true, "", "[_this] call tcb_fnc_flipCheck"];
};

// spectating
if (tcb_isSpectator) then {
	player addAction ["Spactator Mode" call XTuerkiesText, "call tcb_fnc_spectating", [], 0, false, true, "", ""];
};