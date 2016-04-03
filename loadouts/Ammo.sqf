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
_unit addVest "V_Chestrig_oli";
_unit addItemToVest "HandGrenade";
_unit addItemToVest "SmokeShell";
_unit addItemToVest "SmokeShellGreen";
for "_i" from 1 to 2 do {_unit addItemToVest "Chemlight_blue";};
for "_i" from 1 to 2 do {_unit addItemToVest "30Rnd_65x39_caseless_mag";};
_unit addBackpack "G_Carryall_Ammo";
for "_i" from 1 to 2 do {_unit addItemToBackpack "200Rnd_65x39_cased_Box";};
_unit addItemToBackpack "RPG32_F";
for "_i" from 1 to 3 do {_unit addItemToBackpack "20Rnd_762x51_Mag";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "30Rnd_65x39_caseless_mag";};
_unit addHeadgear "H_Booniehat_khk";

comment "Add weapons";
_unit addWeapon "arifle_MX_F";
_unit addPrimaryWeaponItem "optic_Hamr";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";

comment "Set identity";
_unit setFace "GreekHead_A3_07";
_unit setSpeaker "Male03GRE";
