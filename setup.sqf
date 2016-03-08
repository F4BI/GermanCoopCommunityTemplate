//---------------------------------------------------------- SETUP FILE ----------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------------------------

// ------------------------------------------------- Funktionen des Templates aktivieren / deaktivieren -------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------

// wenn nicht auskommentiert mit // dann legt das die Viewdistance für die Spieler und den Server fest
#define __GECO_VIEWDISTANCE__ 2500

// wenn nicht auskommentiert mit // dann kann der Spieler selbst die Sichtweite bestimmen und Gras an/abschalten
#define __GECO_PLAYER_GRAPHIC_SETTINGS__

// wenn nicht auskommentiert mit // dann startet das GeCo Standard Intro
#define __GECO_ENABLE_INTRO__

// wenn nicht auskommentiert mit // dann werden die Waffen, Magazine und Ausrüstung des Spielers zum Todeszeitpunkt gespeichert und bei respawn wieder gegeben
#define __GECO_WEAPON_SAVER__

// wenn nicht auskommentiert mit // dann werden für definierte Spieler Marker auf der Karte erzeugt
// sollen alle Spieler einen Marker erhalten muß auch jeder einzeln unter dem Array tcb_p_entities definiert werden
// ["name des spielers als string (im editor definieren)" , "Markertext" , "Markertyp"]
#define __GECO_SHOW_CUSTOM_PLAYERMARKER__
tcb_p_entities = [
	["alpha_lead","Alpha","b_inf"],
	["bravo_lead","Bravo","b_inf"],
	["charlie_lead","Charlie","b_inf"],
	["delta_lead","Delta","b_inf"],
	["echo_lead","Echo","b_support"],
	["foxtrot_lead","Foxtrot","b_support"],
	["adler_1","Adler 1","b_air"],
	["adler_2","Adler 2","b_air"],
	["adler_3","Adler 3","b_air"],
	["adler_4","Adler 4","b_air"]
];

// wenn nicht auskommentiert mit // dann werden Blutspritzer bei Schaden erzeugt (optischer Effekt)
#define __GECO_BLOOD_SCREEN__

// wenn nicht auskommentiert mit // können leichte Reperaturen im Feld vorgenommen werden (z.B. defekten Reifen reparieren)
#define __GECO_FIELDREPAIR__

// wenn nicht auskommentiert mit // können umgekipte Fahrzeuge wieder aufgerichtet werden
#define __GECO_VEHILCLEFLIP__

// wenn nicht auskommentiert mit // können nur Crewmitglieder schwere Fahrzeuge fahren
#define __GECO_ONLY_CREW_CAN_DRIVE__

// wenn nicht auskommentiert mit // können Spectator definiert werden (z.B. der OPZ Slot)
#define __GECO_SPECTATING__
// hier werden Spieler als Spectating User definiert. Der zum Start der Mission echte eingeloggte Serveradmin erhält auomatisch Zugang zum Spectating!
// trage hier Einheiten Slots ein welche Zugang zum Spectating Mode erhalten sollen (varName des spielers als string (im editor definieren))
tcb_spectator_units = [
	"alpha_lead",
	"opz"
];
// trage hier Spielernamen ein welche Zugang zum Spectating Mode erhalten sollen
tcb_spectator_playerNames = [
	"Psychobastard",
	"blablabla"
];

// wenn nicht auskommentiert mit // wird das Arsenal Preset für die definierten Kisten geladen
#define __GECO_ARSENAL__
// trage hier die Kisten/Gegenstände ein welche als Arsenal zur Verfügung stehen sollen
// trage den Variablennamen der Kiste so wie im Editor benannt ein
// der Inhalt des Arsenals wird hier definiert: ---> core\script\arsenal_preset.sqf
geco_arsenal_crates = [
	geco_box_1,
	geco_box_2
];












// ------------------------------------------------------------------------ do not edit below this line! -----------------------------------------------------------
// vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

//-------------------------------------------------------------------------- Pilotenklassen --------------------------------------------------------------------------
// hier sind alle Classnames aufgelistet, welche als Piloten definiert werden um fliegen zu dürfen
tcb_pilots = ["I_G_Story_Protagonist_F","C_man_pilot_F","O_Pilot_F","O_helicrew_F","B_helicrew_F","B_Pilot_F","I_pilot_F","I_helicrew_F","I_helipilot_F","O_helipilot_F","B_Helipilot_F"];
//-------------------------------------------------------------------------- Crewklassen --------------------------------------------------------------------------
#ifdef __GECO_ONLY_CREW_CAN_DRIVE__
// hier sind alle Classnames aufgelistet, welche als Crew definiert werden um gepanzerte Fahrzeuge fahren zu dürfen (und Schützenposition)
tcb_crew = ["I_crew_F","O_crew_F","B_crew_F"];
#endif

//-------------------------------------------------------------------------- AI Settings --------------------------------------------------------------------------
// main enemy side (east, west, resistance)
tcb_enemy = resistance;

// if true, unit hasn't  NVGoggles
tcb_remove_nv = false;

// if true, ai unit hasn't First Aid Kits
tcb_remove_fak = false;

// set the cowardice of the units - 0 means they will never fleeing / 1 means they run always away
tcb_cowardice = 0.3;

// ai skill array: first number are the basic skill - second number are a random upward value
tcb_skill_array = [0.4,0.2];
tcb_spotDistance = 0.40;
tcb_spotTime = 0.60;
tcb_aimingSpeed = 0.35;
tcb_aimingShake = 0.75;
tcb_aimingAccuracy = 0.4;

// distance until the groups are reduced if group respawn is enabled
tcb_reduce_distance = 1200;

// lock spawned Airvehicles
tcb_LockAir = true;
// lock spawned tanks and apc's
tcb_LockArmored = true;
// lock spawned cars
tcb_LockCars = false;