_unit = __unit select 1;

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
_unit forceAddUniform "U_IG_Guerilla2_3";
_unit addItemToUniform "FirstAidKit";
_unit addItemToUniform "MiniGrenade";
_unit addItemToUniform "30Rnd_65x39_caseless_mag";
_unit addItemToUniform "1Rnd_HE_Grenade_shell";
_unit addVest "V_Chestrig_blk";
for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
_unit addItemToVest "MiniGrenade";
for "_i" from 1 to 9 do {_unit addItemToVest "1Rnd_HE_Grenade_shell";};
_unit addItemToVest "SmokeShell";
_unit addItemToVest "SmokeShellGreen";
for "_i" from 1 to 2 do {_unit addItemToVest "Chemlight_blue";};
for "_i" from 1 to 2 do {_unit addItemToVest "1Rnd_Smoke_Grenade_shell";};
_unit addItemToVest "1Rnd_SmokeGreen_Grenade_shell";
_unit addItemToVest "1Rnd_SmokeRed_Grenade_shell";
_unit addItemToVest "1Rnd_SmokeBlue_Grenade_shell";
for "_i" from 1 to 4 do {_unit addItemToVest "30Rnd_65x39_caseless_mag";};
_unit addHeadgear "H_Bandanna_khk";

comment "Add weapons";
_unit addWeapon "arifle_MX_GL_F";
_unit addPrimaryWeaponItem "optic_Hamr";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";

comment "Set identity";
_unit setFace "GreekHead_A3_04";
_unit setSpeaker "Male02GRE";
