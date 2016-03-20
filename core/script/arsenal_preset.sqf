// by psycho
// Hier wird das Arsenal Loadout definiert welches in die Kisten geladen wird.
// Das Script wird lokal von jedem Client ausgeführt
// standard definitions - do not edit
private ["_items", "_optics", "_arifle", "_srifle", "_mg", "_handgun", "_launcher"];
tcb_all_items = [];
tcb_all_weaps = [];

// Rucksäcke, Westen,, Magazine und Brillen werden automatisch hinzugefügt. (braucht man sich nicht drum kümmern)
// nur Waffen und besondere Gegenstände definieren (z.B. Scopes und andere Attachments usw)
// beachte: Arsenal fügt automatisch die bereits bestehende Spielerausrüstung der Auswahl hinzu!


//			HIER KÖNNEN DIE GEGENSTÄNDE EDITITIERT WERDEN
// vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

// Gegenstände und Waffen die hier definiert werden sind immer im Arsenal enthalten, egal welche Fraktion und Klasse...
tcb_all_items = ["H_Booniehat_khk","H_Booniehat_tan","H_Booniehat_dirty","H_Booniehat_khk_hs","H_Cap_oli","H_Cap_headphones","H_Cap_oli_hs","H_MilCap_gry","H_MilCap_blue","H_BandMask_blk","H_Bandanna_khk","H_Bandanna_khk_hs","H_Bandanna_cbr","H_Bandanna_sgg","H_Bandanna_gry","H_Bandanna_camo","H_Bandanna_mcamo","H_Shemag_khk","H_Shemag_tan","H_Shemag_olive","H_Shemag_olive_hs","H_ShemagOpen_khk","H_ShemagOpen_tan","acc_pointer_IR","acc_flashlight","muzzle_snds_H_MG","muzzle_snds_B","muzzle_snds_M","muzzle_snds_H","Laserdesignator","ToolKit","Medikit","FirstAidKit","NVGoggles_INDEP","NVGoggles_OPFOR","NVGoggles","Rangefinder","Binocular","MineDetector","ItemMap","ItemRadio","ItemGPS","ItemCompass","ItemWatch","muzzle_snds_acp","muzzle_snds_L"];
tcb_all_weaps = ["hgun_Pistol_Signal_F","arifle_SDAR_F","arifle_TRG21_F"];


// hier werden die Seiten spezifischen Waffen/gegenstände definiert. Das Template unterscheided (noch) nicht nach Spielerklassen (z.B. Sniper usw...)
switch (playerSide) do {
	case (blufor) : {
		// BLUFOR equipment
		_items = ["U_B_PilotCoveralls","U_B_Wetsuit","U_B_HeliPilotCoveralls","U_B_GhillieSuit","U_B_CombatUniform_mcam_vest","U_B_CombatUniform_mcam","H_HelmetB","H_HelmetB_camo","H_HelmetB_paint","H_HelmetB_light","H_Booniehat_mcamo","H_HelmetB_plain_mcamo","H_HelmetB_plain_blk","H_HelmetSpecB","H_HelmetSpecB_paint1","H_HelmetSpecB_paint2","H_HelmetSpecB_blk","H_HelmetB_grass","H_HelmetB_snakeskin","H_HelmetB_desert","H_HelmetB_black","H_HelmetB_sand","H_Cap_blu","H_Cap_brn_SPECOPS","H_Cap_tan_specops_US","H_Cap_khaki_specops_UK","H_HelmetCrew_B","H_PilotHelmetFighter_B","H_PilotHelmetHeli_B","H_CrewHelmetHeli_B","H_MilCap_mcamo","H_HelmetB_light_grass","H_HelmetB_light_snakeskin","H_HelmetB_light_desert","H_HelmetB_light_black","H_HelmetB_light_sand","H_BandMask_khk","H_BandMask_reaper","H_BandMask_demon","H_Beret_blk","H_Beret_grn_SF","H_Beret_02","H_Beret_Colonel","B_UavTerminal"];
		_optics = ["optic_tws_mg","optic_tws","optic_NVS","optic_Holosight_smg","optic_Holosight","optic_Aco_smg","optic_Aco","optic_Hamr","optic_Arco","optic_SOS","optic_MRD"];

		_arifle = ["SMG_01_F","arifle_MXC_F","arifle_MX_F","arifle_MXM_Black_F","arifle_MX_Black_F","arifle_MXC_Black_F","arifle_MX_GL_F","arifle_MX_GL_Black_F"];
		_srifle = ["srifle_EBR_F","srifle_LRR_F"];
		_mg = ["LMG_Mk200_F","arifle_MX_SW_F","arifle_MX_SW_Black_F"];
		_handgun = ["hgun_Pistol_heavy_01_F","hgun_P07_F","hgun_ACPC2_F"];
		_launcher = ["launch_B_Titan_F","launch_B_Titan_short_F","launch_NLAW_F"];
	};

	case (opfor) : {
		// OPFOR equipment
		_items = ["H_MilCap_oucamo","U_O_OfficerUniform_ocamo","U_O_SpecopsUniform_blk","U_O_SpecopsUniform_ocamo","U_O_CombatUniform_oucamo","U_O_Wetsuit","U_O_PilotCoveralls","U_O_GhillieSuit","U_O_CombatUniform_ocamo","H_Cap_red","H_HelmetCrew_O","H_PilotHelmetFighter_O","H_PilotHelmetHeli_O","H_CrewHelmetHeli_O","H_HelmetO_ocamo","H_HelmetLeaderO_ocamo","H_MilCap_ocamo","H_MilCap_rucamo","H_HelmetO_oucamo","H_HelmetLeaderO_oucamo","H_HelmetSpecO_ocamo","H_HelmetSpecO_blk","H_Beret_red","H_Beret_brn_SF","H_Beret_ocamo","O_UavTerminal"];
		_optics = ["optic_tws_mg","optic_tws","optic_DMS","optic_ACO_grn_smg","optic_ACO_grn","optic_Yorris","optic_LRPS","optic_Nightstalker"];

		_arifle = ["SMG_02_F","arifle_Katiba_F","arifle_Katiba_C_F","arifle_Katiba_GL_F"];
		_srifle = ["srifle_GM6_F","srifle_DMR_01_F"];
		_mg = ["LMG_Zafir_F"];
		_handgun = ["hgun_Rook40_F","hgun_ACPC2_F","hgun_Pistol_heavy_02_F"];
		_launcher = ["launch_O_Titan_F","launch_O_Titan_short_F","launch_RPG32_F"];
	};

	case (independent) : {
		// INDFOR equipment
		_items = ["U_I_Wetsuit","U_I_OfficerUniform","U_I_GhillieSuit","U_I_HeliPilotCoveralls","U_I_pilotCoveralls","U_I_CombatUniform_shortsleeve","U_I_CombatUniform","H_Booniehat_indp","H_Booniehat_dgtl","H_HelmetIA","H_HelmetIA_net","H_HelmetIA_camo","H_Cap_grn","H_HelmetCrew_I","H_PilotHelmetFighter_I","H_PilotHelmetHeli_I","H_CrewHelmetHeli_I","H_MilCap_dgtl","H_Beret_grn","I_UavTerminal"];
		_optics = ["optic_ACO_grn_smg","optic_ACO_grn","optic_NVS","optic_SOS"];

		_arifle = ["hgun_PDW2000_F","arifle_TRG20_F","arifle_TRG21_GL_F","arifle_Mk20_F","arifle_Mk20C_F","arifle_Mk20_GL_"];
		_srifle = ["","srifle_GM6_F"];
		_mg = ["LMG_Mk200_F"];
		_handgun = ["hgun_ACPC2_F"];
		_launcher = ["launch_I_Titan_F","launch_I_Titan_short_F","launch_NLAW_F"];
	};

	case (independent) : {
		// Civilian specific equipment (clothes)
		_items = ["U_NikosAgedBody","U_C_Scientist","U_C_Journalist","U_C_HunterBody_grn","U_C_Fisherman","U_C_Farmer","U_C_FishermanOveralls","U_BG_leader","U_OG_Guerilla3_2","U_OG_Guerilla3_1","U_BG_Guerilla2_2","U_BG_Guerilla2_1","U_BG_Guerilla1_1","U_IG_leader","U_IG_Guerilla3_1","U_IG_Guerilla2_3","U_IG_Guerilla2_2","U_IG_Guerilla2_1","U_IG_Guerilla1_1","U_Rangemaster","U_C_Commoner1_1","U_C_Poloshirt_salmon","U_C_Poloshirt_tricolour","U_C_Poloshirt_stripped","U_C_Poloshirt_blue","H_RacingHelmet_1_blue_F","U_C_Driver_1_yellow","U_C_Driver_1_orange","U_Marshal","H_RacingHelmet_1_F","H_RacingHelmet_2_F","H_RacingHelmet_3_F","H_RacingHelmet_4_F","H_RacingHelmet_1_black_F","H_RacingHelmet_1_green_F","H_RacingHelmet_1_red_F","H_Cap_marshal","H_RacingHelmet_1_orange_F","H_RacingHelmet_1_yellow_F","H_RacingHelmet_1_white_F","H_TurbanO_blk","H_StrawHat","H_StrawHat_dark","H_Hat_blue","H_Booniehat_grn","H_Cap_tan","H_Cap_blk","H_Cap_blk_CMMG","H_Cap_grn_BI","H_Cap_blk_Raven","H_Cap_blk_ION","H_Cap_press","H_Bandanna_surfer","H_Beret_blk_POLICE"];
		_optics = [];

		_arifle = [];
		_srifle = [];
		_mg = [];
		_handgun = [];
		_launcher = [];
	};
	default {
	// need for virtual entities
		_items = [];
		_optics = [];

		_arifle = [];
		_srifle = [];
		_mg = [];
		_handgun = [];
		_launcher = [];	
	};
};











//			Do not edit below this line!!!!!!
// ----------------------------------------------------------------------------------------------------------------------------------------------


{tcb_all_items append _x} forEach [_items, _optics];
{tcb_all_weaps append _x} forEach [_arifle, _srifle, _mg, _handgun, _launcher];

// all magazines without any faction relations, ARSENAL search automaticaly for the matched ammo
/*	<---- psycho: not needed i guess. Maybe add manually some standard mags for mg's / sniper / at - so ammo bearer can get strange ammo types for their comrades
_cfgMags = configFile >> "CfgMagazines";
tcb_mag_a = [];
for "_i" from 0 to (count _cfgMags)-1 do {
	_cur_mag = _cfgMags select _i;
	if (isClass _cur_mag) then {
		_classname = configName _cur_mag;
		if (getNumber (_cur_mag >> "scope") >= 1 && !(_classname in tcb_mag_a)) then {
			tcb_mag_a pushBack _classname;
		};
	};
};
*/

// all glassses without any faction relations
_cfgglasses = configFile >> "CfgGlasses";
_glasses_a = [];
for "_i" from 0 to (count _cfgglasses)-1 do {
	_cur_glass = _cfgglasses select _i;
	if (isClass _cur_glass) then {
		_classname = configName _cur_glass;
		if ((getText (_cur_glass >> "displayName") != "None") && (getText (_cur_glass >> "picture") != "") && !(_classname in _glasses_a)) then {
			_glasses_a pushBack _classname;
		};
	};
};
tcb_all_items append _glasses_a;

fnc_remove_Vest_ = {
	if (_this select [0,5] == "Vest_") exitwith {_this select [5]};
	_this
};

// all backpacks without any faction relations
_cfgweapons = configFile >> "CfgVehicles";
tcb_bp_a = [];
tcb_v_a = [];
for "_i" from 0 to (count _cfgWeapons)-1 do {
	_cur_wep = _cfgweapons select _i;
	if (isClass _cur_wep) then {
		_classname = configName _cur_wep;
		_wep_type = getText (_cur_wep >> "vehicleClass");
		if (getNumber (_cur_wep >> "scope") >= 2 && _wep_type == "Backpacks") then {
			tcb_bp_a pushBack _classname;
		};
		if (getNumber (_cur_wep >> "scope") >= 2 && _wep_type == "ItemsVests") then {
			_short_name = _classname call fnc_remove_Vest_;
			tcb_v_a pushBack _short_name;
		};
	};
};
tcb_all_items append tcb_v_a;

geco_arsenal_crates = geco_arsenal_crates - [objNull];
geco_arsenal_crates = geco_arsenal_crates - [Nil];

{
	["AmmoboxInit", [_x,true]] call BIS_fnc_arsenal;
	[_x,[true]] call BIS_fnc_removeVirtualWeaponCargo;
	[_x,[true]] call BIS_fnc_removeVirtualItemCargo;
	//[_x,[true]] call BIS_fnc_removeVirtualMagazineCargo;
	[_x,[true]] call BIS_fnc_removeVirtualBackpackCargo;
	
	[_x, tcb_all_weaps] call BIS_fnc_addVirtualWeaponCargo;
	[_x, tcb_bp_a] call BIS_fnc_addVirtualBackpackCargo;
	[_x, tcb_all_items] call BIS_fnc_addVirtualItemCargo;
	//[_x, tcb_mag_a] call BIS_fnc_addVirtualMagazineCargo;

} forEach geco_arsenal_crates;