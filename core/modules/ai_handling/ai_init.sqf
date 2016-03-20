// by psycho
if (!isServer && {!ai_IS_HC_CLIENT}) exitWith {};
#include "ai_macros.sqf"
AI_H_PATH = "core\modules\ai_handling\";

__aiccppfln(main_fn.sqf);

__aicppfln(tcb_fnc_ai_createArmor,script\fn_createArmor.sqf);
__aicppfln(tcb_fnc_ai_createInf,script\fn_createInf.sqf);
__aicppfln(ai_handler,script\ai_handler.sqf);

ai_all_simulation_stoped = false;
ai_allunits_add = [];

if (isServer) then {
	if (isNil "ai_Storage") then {
		ai_Storage = "Land_HelipadEmpty_F" createVehicle [0,0,0];
	};
	["ai_h1", "onPlayerConnected", "tcb_fnc_ai_opc"] call bis_fnc_addStackedEventHandler;
	["ai_h2", "onPlayerDisconnected", "tcb_fnc_ai_opd"] call bis_fnc_addStackedEventHandler;
};

tcb_doRespawnGroups =
#ifdef __AI_RESPAWN_GROUPS__
	true;
#else
	false;
#endif

execFSM (AI_H_PATH+"fsm\NotAliveRemover.fsm");
if (isServer) then {
	execFSM (AI_H_PATH+"fsm\NotAliveRemoverUnits.fsm");
};
execFSM (AI_H_PATH+"fsm\GroupClean.fsm"); // TODO: Check if this can also run server only

if (tcb_doRespawnGroups) then {
	ai_reduce_groups = [];
	execFSM (AI_H_PATH+"fsm\ReduceGroups.fsm");
};

//ai_mapcenter = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");	// far away from real world center!
_size = getNumber (configFile >> "CfgWorlds" >> worldName >> "MapSize");
#ifdef __DEBUG__
_m = createMarkerLocal [str(_size),[_size / 2,_size / 2, 0]];
_m setMarkerTypeLocal "waypoint";
_m setMarkerColorLocal "ColorRed";
_m setMarkerTextLocal "MapCenter";
#endif

ai_zeus_logic = objNull;
if (!isNil "tcb_gamemaster") then {
	if (!isNull tcb_gamemaster) then {
		ai_zeus_logic = tcb_gamemaster;
	};
};

// blufor, opfor, indfor
ai_vec_spawn_default_Crew = ["B_crew_F", "O_crew_F", "I_crew_F"];

// _E = Opfor
// _W = Blufor
// _G = Independent
// this is what gets spawned
ai_allmen_E = [
	["East","OPF_F","Infantry","OIA_InfSquad"] call tcb_fnc_ai_getConfigGroup,
	["East","OPF_F","Infantry","OIA_InfSquad_Weapons"] call tcb_fnc_ai_getConfigGroup,
	["East","OPF_F","Infantry","OIA_InfTeam"] call tcb_fnc_ai_getConfigGroup,
	["East","OPF_F","Infantry","OIA_InfTeam_AT"] call tcb_fnc_ai_getConfigGroup,
	["East","OPF_F","Infantry","OIA_InfTeam_AA"] call tcb_fnc_ai_getConfigGroup
];
ai_allmen_W = [
	["West","BLU_F","Infantry","BUS_InfSquad"] call tcb_fnc_ai_getConfigGroup,
	["West","BLU_F","Infantry","BUS_InfSquad_Weapons"] call tcb_fnc_ai_getConfigGroup,
	["West","BLU_F","Infantry","BUS_InfTeam"] call tcb_fnc_ai_getConfigGroup,
	["West","BLU_F","Infantry","BUS_InfTeam_AT"] call tcb_fnc_ai_getConfigGroup,
	["West","BLU_F","Infantry","BUS_InfTeam_AA"] call tcb_fnc_ai_getConfigGroup
];
ai_allmen_G = [
	["Indep","IND_F","Infantry","HAF_InfSquad"] call tcb_fnc_ai_getConfigGroup,
	["Indep","IND_F","Infantry","HAF_InfSquad_Weapons"] call tcb_fnc_ai_getConfigGroup,
	["Indep","IND_F","Infantry","HAF_InfTeam_AT"] call tcb_fnc_ai_getConfigGroup,
	["Indep","IND_F","Infantry","HAF_InfTeam_AA"] call tcb_fnc_ai_getConfigGroup
];
//----------------------spec ops
ai_specops_E = [
	["East","OPF_F","Infantry","OI_reconTeam"] call tcb_fnc_ai_getConfigGroup,
	["East","OPF_F","Infantry","OI_SniperTeam"] call tcb_fnc_ai_getConfigGroup,
	["East","OPF_F","Infantry","OI_reconPatrol"] call tcb_fnc_ai_getConfigGroup
];
ai_specops_W = [
	["West","BLU_F","Infantry","BUS_ReconTeam"] call tcb_fnc_ai_getConfigGroup,
	["West","BLU_F","Infantry","BUS_ReconPatrol"] call tcb_fnc_ai_getConfigGroup,
	["West","BLU_F","Infantry","BUS_SniperTeam"] call tcb_fnc_ai_getConfigGroup
];
ai_specops_G = [
	["Indep","IND_F","Infantry","HAF_SniperTeam"] call tcb_fnc_ai_getConfigGroup,
	["Indep","IND_F","Infantry","HAF_InfSentry"] call tcb_fnc_ai_getConfigGroup
];
// ---------------------motorized inf
ai_mot_E = [
	["East","OPF_F","Motorized_MTP","OIA_MotInf_Team"] call tcb_fnc_ai_getConfigGroup,
	["East","OPF_F","Motorized_MTP","OIA_MotInf_AT"] call tcb_fnc_ai_getConfigGroup,
	["East","OPF_F","Motorized_MTP","OIA_MotInf_AA"] call tcb_fnc_ai_getConfigGroup
];
ai_mot_W = [
	["West","BLU_F","Motorized","BUS_MotInf_Team"] call tcb_fnc_ai_getConfigGroup,
	["West","BLU_F","Motorized","BUS_MotInf_AT"] call tcb_fnc_ai_getConfigGroup,
	["West","BLU_F","Motorized","BUS_MotInf_AA"] call tcb_fnc_ai_getConfigGroup
];
ai_mot_G = [
	["Indep","IND_F","Motorized","HAF_MotInf_Team"] call tcb_fnc_ai_getConfigGroup,
	["Indep","IND_F","Motorized","HAF_MotInf_AT"] call tcb_fnc_ai_getConfigGroup,
	["Indep","IND_F","Motorized","HAF_MotInf_AA"] call tcb_fnc_ai_getConfigGroup
];
//--------------------mechanized inf
ai_mech_E = [
	["East","OPF_F","Mechanized","OIA_MechInfSquad"] call tcb_fnc_ai_getConfigGroup,
	["East","OPF_F","Mechanized","OIA_MechInf_AT"] call tcb_fnc_ai_getConfigGroup,
	["East","OPF_F","Mechanized","OIA_MechInf_AA"] call tcb_fnc_ai_getConfigGroup,
	["East","OPF_F","Mechanized","OIA_MechInf_Support"] call tcb_fnc_ai_getConfigGroup
];
ai_mech_W = [
	["West","BLU_F","Mechanized","BUS_MechInfSquad"] call tcb_fnc_ai_getConfigGroup,
	["West","BLU_F","Mechanized","BUS_MechInf_AT"] call tcb_fnc_ai_getConfigGroup,
	["West","BLU_F","Mechanized","BUS_MechInf_AA"] call tcb_fnc_ai_getConfigGroup,
	["West","BLU_F","Mechanized","BUS_MechInf_Support"] call tcb_fnc_ai_getConfigGroup
];
ai_mech_G = [
	["Indep","IND_F","Mechanized","HAF_MechInfSquad"] call tcb_fnc_ai_getConfigGroup,
	["Indep","IND_F","Mechanized","HAF_MechInf_AT"] call tcb_fnc_ai_getConfigGroup,
	["Indep","IND_F","Mechanized","HAF_MechInf_AA"] call tcb_fnc_ai_getConfigGroup,
	["Indep","IND_F","Mechanized","HAF_MechInf_Support"] call tcb_fnc_ai_getConfigGroup
];
//--------------------tank sections and platoons
ai_section_E = [
	["East","OPF_F","Armored","OIA_TankSection"] call tcb_fnc_ai_getConfigGroup,
	["East","OPF_F","Armored","OIA_SPGSection_Scorcher"] call tcb_fnc_ai_getConfigGroup,
	["East","OPF_F","Armored","OIA_TankPlatoon_AA"] call tcb_fnc_ai_getConfigGroup
];
ai_section_W = [
	["West","BLU_F","Armored","BUS_TankSection"] call tcb_fnc_ai_getConfigGroup,
	["West","BLU_F","Armored","BUS_SPGSection_Scorcher"] call tcb_fnc_ai_getConfigGroup,
	["West","BLU_F","Armored","BUS_TankPlatoon_AA"] call tcb_fnc_ai_getConfigGroup
];
ai_section_G = [
	["dummy"]
];

ai_veh_a_E = [
	["O_MBT_02_cannon_F"],	// mbt
	["O_APC_Tracked_02_cannon_F"],	// apc_tracked
	["O_APC_Wheeled_02_rcws_F"],	// apc_wheeled
	["O_APC_Tracked_02_AA_F"],	// aa
	["O_MRAP_02_hmg_F","O_MRAP_02_gmg_F"],	// car_armed
	["O_MRAP_02_F"],	// car
	["O_GMG_01_F","O_GMG_01_high_F","O_GMG_01_A_F","O_HMG_01_F","O_HMG_01_high_F","O_HMG_01_A_F"],	// static_light
	["O_static_AA_F","O_static_AT_F"],	// static_heavy
	["O_Mortar_01_F","O_MBT_01_arty_F"],	// static_mortar
	["O_Truck_02_fuel_F"],	// supply_fuel
	["O_Truck_02_box_F"],	// supply_rep
	["O_Truck_02_Ammo_F"]	// supply_ammo
];
ai_veh_a_W = [
	["B_MBT_01_cannon_F"],
	["B_APC_Tracked_01_rcws_F"],
	["B_APC_Wheeled_01_cannon_F"],
	["B_APC_Tracked_01_AA_F"],
	["B_MRAP_01_hmg_F","B_MRAP_01_gmg_F"],
	["B_MRAP_01_F"],
	["B_GMG_01_F","B_GMG_01_high_F","B_GMG_01_A_F","B_HMG_01_F","B_HMG_01_high_F","B_HMG_01_A_F"],
	["B_static_AA_F","B_static_AT_F"],
	["B_Mortar_01_F","B_MBT_01_arty_F","B_MBT_01_mlrs_F"],
	["B_Truck_01_fuel_F"],
	["B_Truck_01_Repair_F"],
	["B_Truck_01_ammo_F"]
];
ai_veh_a_G = [
	[""],
	[""],
	["I_APC_Wheeled_03_cannon_F"],
	[""],
	["I_MRAP_03_hmg_F","I_MRAP_03_gmg_F"],
	["I_MRAP_03_F"],
	["I_GMG_01_F","I_GMG_01_high_F","I_GMG_01_A_F","I_HMG_01_F","I_HMG_01_high_F","I_HMG_01_A_F"],
	["B_static_AA_F","I_static_AT_F"],
	["I_Mortar_01_F"],
	["I_Truck_02_fuel_F"],
	["I_Truck_02_box_F"],
	["I_Truck_02_Ammo_F"]
];