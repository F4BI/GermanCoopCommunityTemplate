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
_unit forceAddUniform "U_IG_Guerrilla_6_1";
_unit addItemToUniform "FirstAidKit";
_unit addItemToUniform "SmokeShell";
_unit addItemToUniform "Chemlight_blue";
_unit addItemToUniform "30Rnd_65x39_caseless_mag";
_unit addVest "V_TacVest_blk";
_unit addItemToVest "SmokeShellGreen";
_unit addItemToVest "Chemlight_blue";
for "_i" from 1 to 3 do {_unit addItemToVest "30Rnd_65x39_caseless_mag";};
_unit addBackpack "G_FieldPack_LAT";
for "_i" from 1 to 3 do {_unit addItemToBackpack "RPG32_F";};
_unit addItemToBackpack "RPG32_HE_F";
_unit addHeadgear "H_Bandanna_khk";
_unit addGoggles "G_Shades_Blue";

comment "Add weapons";
_unit addWeapon "arifle_MX_F";
_unit addPrimaryWeaponItem "optic_Hamr";
_unit addWeapon "launch_RPG32_F";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";

comment "Set identity";
_unit setFace "GreekHead_A3_01";
_unit setSpeaker "Male03GRE";
