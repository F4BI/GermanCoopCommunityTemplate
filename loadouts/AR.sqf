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
_unit forceAddUniform "U_IG_Guerilla2_1";
_unit addItemToUniform "FirstAidKit";
_unit addItemToUniform "HandGrenade";
_unit addItemToUniform "MiniGrenade";
_unit addItemToUniform "SmokeShell";
_unit addItemToUniform "Chemlight_blue";
_unit addVest "V_TacVest_blk";
for "_i" from 1 to 2 do {_unit addItemToVest "200Rnd_65x39_cased_Box";};
_unit addBackpack "B_TacticalPack_rgr";
for "_i" from 1 to 2 do {_unit addItemToBackpack "200Rnd_65x39_cased_Box";};
_unit addHeadgear "H_Bandanna_khk";

comment "Add weapons";
_unit addWeapon "LMG_Mk200_BI_F";
_unit addPrimaryWeaponItem "optic_Holosight_smg";
_unit addPrimaryWeaponItem "bipod_03_F_blk";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";

comment "Set identity";
_unit setFace "GreekHead_A3_03";
_unit setSpeaker "Male01GRE";
