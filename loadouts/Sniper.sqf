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
_unit forceAddUniform "U_IG_Guerilla3_1";
_unit addItemToUniform "FirstAidKit";
_unit addItemToUniform "Chemlight_blue";
for "_i" from 1 to 3 do {_unit addItemToUniform "20Rnd_762x51_Mag";};
_unit addVest "V_BandollierB_khk";
_unit addItemToVest "HandGrenade";
_unit addItemToVest "MiniGrenade";
_unit addItemToVest "SmokeShell";
_unit addItemToVest "SmokeShellGreen";
_unit addItemToVest "Chemlight_blue";
for "_i" from 1 to 3 do {_unit addItemToVest "20Rnd_762x51_Mag";};
_unit addHeadgear "H_Shemag_olive";

comment "Add weapons";
_unit addWeapon "srifle_EBR_F";
_unit addPrimaryWeaponItem "optic_MRCO";
_unit addWeapon "Binocular";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";

comment "Set identity";
_unit setFace "GreekHead_A3_03";
_unit setSpeaker "Male02GRE";
