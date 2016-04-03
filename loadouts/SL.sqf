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
_unit forceAddUniform "U_IG_leader";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "30Rnd_65x39_caseless_mag";};
_unit addVest "V_Chestrig_blk";
_unit addItemToVest "9Rnd_45ACP_Mag";
_unit addItemToVest "HandGrenade";
_unit addItemToVest "MiniGrenade";
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
for "_i" from 1 to 3 do {_unit addItemToVest "SmokeShellGreen";};
for "_i" from 1 to 3 do {_unit addItemToVest "SmokeShellRed";};
for "_i" from 1 to 3 do {_unit addItemToVest "SmokeShellBlue";};
for "_i" from 1 to 2 do {_unit addItemToVest "Chemlight_blue";};
for "_i" from 1 to 3 do {_unit addItemToVest "30Rnd_65x39_caseless_mag";};
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShellPurple";};
_unit addBackpack "B_AssaultPack_mcamo";
for "_i" from 1 to 2 do {_unit addItemToBackpack "30Rnd_65x39_caseless_mag_Tracer";};
_unit addHeadgear "H_Watchcap_blk";

comment "Add weapons";
_unit addWeapon "arifle_MX_F";
_unit addPrimaryWeaponItem "optic_Hamr";
_unit addWeapon "hgun_ACPC2_F";
_unit addWeapon "Binocular";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";

comment "Set identity";
_unit setFace "GreekHead_A3_05";
_unit setSpeaker "Male04GRE";
