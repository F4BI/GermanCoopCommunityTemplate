// by Xeno
// changed by psycho
#include "ai_macros.sqf"
["%1 --- running HC Setup",diag_ticktime] call BIS_fnc_logFormat;

player removeAllEventHandlers "handleDamage";
player removeAllEventHandlers "respawn";
player addEventHandler ["handleDamage", {0}];
player setPos [-10000,10000,0.3];
player enableSimulation false;
player addEventHandler ["respawn", {
	player setPos [-10000,10000,0.3];
	player removeAllEventHandlers "handleDamage";
	player addEventHandler ["handleDamage", {0}];
	player allowDamage false;
	//if (!isNil "x_netinit_compiled") then {["hidehc"] call XNetCallEventToClients};	// psycho: ask for presence at jip init direct and save the message
	player enableSimulation false;
	["nHCObj", player] call tcb_fnc_NetAddEventCTS;
}];

deleteVehicle client_jip_init_trigger;
client_jip_init_trigger = nil;

execVM "ai_handler\ai_init.sqf";		// switch server operations to the HC