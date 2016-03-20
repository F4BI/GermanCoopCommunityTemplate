//by psycho
private ["_player_obj"];
_player_obj = _this select 0;

if (!isNil "tcb_gamemaster") then {
	if (!isNull tcb_gamemaster) then {
		["addToCurator", _player_obj] call tcb_fnc_netCallEventCTS;
		
		_old_objects = tcb_gamemaster getVariable "tcb_zeus";
		if (getplayerUID _player_obj == _old_objects select 1) then {
			[_player_obj, _old_objects select 0] call BIS_fnc_curatorRespawn;
		};
	};
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