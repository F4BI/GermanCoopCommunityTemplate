// Net Events

//number give's location where the code are executed:  0-every  --  1-server   --   2-client	-- 3-dedicated
[0, "FAR_rotate", {_this setDir 90}] call tcb_fnc_NetAddEvent;
[0, "setCaptive", {(_this select 0) setCaptive (_this select 1)}] call tcb_fnc_NetAddEvent;
[2, "FAR_mapMarker", {[_this] call tcb_fnc_rev_createMarker}] call tcb_fnc_NetAddEvent;
[2, "FAR_removeMapMarker", {[_this] call tcb_fnc_rev_removeMarker}] call tcb_fnc_NetAddEvent;

if (isServer) then {
	["nHCObj", {ai_HC_CLIENT_OBJ = _this}] call tcb_fnc_NetAddEventCTS;
	["setgrps", {_this setVariable ["ai_fromHC", true]}] call tcb_fnc_NetAddEventCTS;
	["WPStorage", {ai_Storage setVariable _this}] call tcb_fnc_NetAddEventCTS;
	["addToCuratorLogics", {[_this] call tcb_fnc_addToCuratorLogics}] call tcb_fnc_NetAddEventCTS;
	["resetCurator", {[(_this select 0),(_this select 1)] spawn BIS_fnc_curatorRespawn}] call tcb_fnc_NetAddEventCTS;
	["addScore", {(_this select 0) addScore (_this select 1)}] call tcb_fnc_NetAddEventCTS;
};
if (!isDedicated) then {
	["hidehc", {hideObject HC_D_UNIT}] call tcb_fnc_NetAddEventToClients;
	["playActionNow", {(_this select 0) playActionNow (_this select 1)}] call tcb_fnc_NetAddEventToClients;
};