// Net Events

//number give's location where the code are executed:  0-every  --  1-server   --   2-client	-- 3-dedicated
[0, "lock_it", {(_this select 0) lock (_this select 1)}] call tcb_fnc_NetAddEvent;
[0, "vehicle_init_global", {call _this}] call tcb_fnc_NetAddEvent;
[0, "tcb_auto_end_looser", {
	_endNum = _this select 0;
	[_endNum] spawn {[_this select 0] call tcb_fnc_endScreen; sleep 10; endMission "LOSER"; titleCut ["To many good men died.","black faded", 0];};
}] call tcb_fnc_NetAddEvent;
[0, "far_rotate", {_this setDir 180}] call tcb_fnc_NetAddEvent;
[2, "FAR_inj_message", {systemChat format ["%1 was injured by %2", name (_this select 0), name (_this select 1)]}] call tcb_fnc_NetAddEvent;
[2, "FAR_inj_message2", {if (local player) then {systemChat format ["%1 was injured", name _this]}}] call tcb_fnc_NetAddEvent;
[2, "tfar_mapMarker", {[_this] call tcb_far_fnc_createMarker}] call tcb_fnc_NetAddEvent;
[2, "tfar_removeMapMarker", {[_this] call tcb_far_fnc_removeMarker}] call tcb_fnc_NetAddEvent;

if (isServer) then {
	["tcb_adddeadnum", {tcb_num_players_dead = tcb_num_players_dead + 1;}] call tcb_fnc_NetAddEventCTS;
	["nHCObj", {ai_HC_CLIENT_OBJ = _this}] call tcb_fnc_NetAddEventCTS;
	["setgrps", {_this setVariable ["ai_fromHC", true]}] call tcb_fnc_NetAddEventCTS;
	["WPStorage", {ai_Storage setVariable _this}] call tcb_fnc_NetAddEventCTS;
	["addToCurator", {tcb_gamemaster addCuratorEditableObjects [[_this],false]}] call tcb_fnc_NetAddEventCTS;
	["addScore", {(_this select 0) addScore (_this select 1)}] call tcb_fnc_NetAddEventCTS;
};
if (!isDedicated) then {
	["hidehc", {hideObject HC_D_UNIT}] call tcb_fnc_NetAddEventToClients;
	["playActionNow", {(_this select 0) playActionNow (_this select 1)}] call tcb_fnc_NetAddEventToClients;
};
["tcb_custom_hint", {[_this select 1,_this select 2,_this select 3,_this select 4] call tcb_fnc_customHint}] call tcb_fnc_NetAddEventSTO;
[2, "say3D_sound", {(_this select 0) say3D (_this select 1)}] call tcb_fnc_NetAddEvent;