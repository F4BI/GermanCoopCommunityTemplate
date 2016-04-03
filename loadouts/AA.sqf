_unit = _this select 1;

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "U_IG_Guerilla1_1";
_unit addItemToUniform "FirstAidKit";
_unit addItemToUniform "MiniGrenade";
_unit addItemToUniform "30Rnd_65x39_caseless_mag";
_unit addVest "V_Chestrig_oli";
_unit addItemToVest "HandGrenade";
_unit addItemToVest "SmokeShell";
_unit addItemToVest "SmokeShellGreen";
for "_i" from 1 to 2 do {_unit addItemToVest "Chemlight_blue";};
for "_i" from 1 to 3 do {_unit addItemToVest "30Rnd_65x39_caseless_mag";};
_unit addBackpack "B_TacticalPack_blk";
for "_i" from 1 to 2 do {_unit addItemToBackpack "Titan_AA";};
_unit addHeadgear "H_Shemag_olive";
_unit addGoggles "G_Shades_Black";

comment "Add weapons";
_unit addWeapon "arifle_MX_F";
_unit addPrimaryWeaponItem "optic_Hamr";
_unit addWeapon "launch_B_Titan_F";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";

comment "Set identity";
_unit setFace "GreekHead_A3_01";
_unit setSpeaker "Male05GRE";
