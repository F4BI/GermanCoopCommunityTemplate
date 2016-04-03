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
for "_i" from 1 to 2 do {_unit addItemToUniform "30Rnd_65x39_caseless_mag";};
_unit addVest "V_TacVest_blk";
_unit addItemToVest "9Rnd_45ACP_Mag";
_unit addItemToVest "MiniGrenade";
_unit addItemToVest "SmokeShell";
_unit addItemToVest "SmokeShellGreen";
_unit addItemToVest "SmokeShellRed";
_unit addItemToVest "SmokeShellBlue";
for "_i" from 1 to 2 do {_unit addItemToVest "Chemlight_blue";};
for "_i" from 1 to 4 do {_unit addItemToVest "30Rnd_65x39_caseless_mag";};
_unit addBackpack "G_FieldPack_Medic";
for "_i" from 1 to 3 do {_unit addItemToBackpack "Medikit";};
_unit addHeadgear "H_Cap_oli";

comment "Add weapons";
_unit addWeapon "arifle_MX_F";
_unit addPrimaryWeaponItem "optic_Holosight";
_unit addWeapon "hgun_ACPC2_F";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";

comment "Set identity";
_unit setFace "GreekHead_A3_04";
_unit setSpeaker "Male02GRE";
