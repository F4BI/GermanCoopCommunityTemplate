/*
		---------------------------------------------Teamkill Protection Script----------------------------------------------------------
																by Psychobastard, 2015, Version 1.10

																
	- arbeitet präventiv - bedeutet es wird versucht dem Teamkiller / Base Raper die Möglichkeit genommen "Spass" zu haben
	- in dieser Setupfile werden alle Einstellungen nach Wunsch vorgenommen
	- Serveradmins und Spieler der White-List sind von diesem System ausgenommen

	- nötige Komponenten zur Funktion:
	
		--> Aufruf in der init.sqf durch jede Maschine : 
			execVM "tk_protection\tk_init.sqf";
			
		--> ein unsichtbares Heli-H (kann auch ein anderes Objekt sein, wie ein Flaggenmast) auf der Karte, platziert in deiner Basis mit Namen:
			TcB_Ref_Point
		
*/

// ------------------------Teamkills:
// - setze TRUE wenn ein Spieler durch versuchten Teamkill NICHT verwundet werden soll
// - die Zahl gibt den Bereich in Distanz um den TcB_Ref_Point an, also den Bereich der Basis (setze Zahl auf 20000 für Komplette Karte, macht aber wenig Sinn)
// dem Schützen werden die versuchten Teamkills trotzdem angerechnet - auch wenn keiner gestorben ist
// wird hier "false" gesetzt, dann ist der tot durch einen Teamkill möglich - die Teamkills werden dem Schützen ebenfalls angerechnet
tcb_tk_handler = [false, 250];

// -------------------------Satchels: 
// - setze den ersten Werta uf TRUE wenn eine Satchel sofort gelöscht werden soll
// - setze den zweiten Wert auf TRUE wenn das legen einer Satchel auch als Teamkill gezählt werden soll
// - die Zahl gibt wieder den Bereich an in dem die Satchels erfasst werden
tcb_satchel_handler = [true, true, 400];

// ------------------------Granaten in der Basis:
// - wenn der erste Wert auf TRUE gesetzt ist wird der Key zum Granaten werfen blockiert
// - die Zahl gibt wieder den Bereich um den TcB_Ref_Point an in dem das werfen von Granaten geblockt wird
tcb_grenade_handler = [true, 250];

// ------------------------Schießen in der Basis:
// Anzahl der Schüsse die in der Basis abgegeben werden dürfen bis die Bestrafung einsetzt (gebe 0 an um diese Funktion zu deaktivieren)
tcb_base_shoots = 10;

// ------------------------maximale Regelverstöße
// Anzahl an gezählten Teamkills (auch der Versuch wird gezählt) bis eine Bestrafung folgt (setzte größer 999999 für unendlich)
tcb_max_num_tk = 3;

// ------------------------Zeit bis ein JIP Fahrzeuge fahren darf oder deren Waffen nutzen kann
// - das System greift nur für JIP-Spieler die vorher noch nicht auf dem Server waren
// - sollte der JIP den Server disconnecten bevor die Zeit abgelaufen ist, so startet sie bei neuem connecten erneut
// - sollte der Spieler vorher schon einmal bestraft worden sein, arbeitet das System auch für bereits bekannte Spieler und die Zeit verdreifacht sich automatisch
// - es wird eine Zeit von 600 Sekunden (10min) empfohlen
tcb_jip_vehicle_protection_time = 600;

// ------------------------Bestrafung
// Art der Bestrafung (bitte nur eine auf TRUE setzen):
tcb_auto_kick = true;		// kickt ihn vom Server

// ------------------------Chancen
// setze diese Variable auf TRUE und die Taten des Teamkillers werden "gemerkt". Das bedeutet - wenn der Teamkiller sich irgendwie befreit
// (z.B. durch respawn) oder den Server neu connected wird seine Bestrafung ohne Verzögerung sofort erneut durchgeführt (beseitigt das lästige und zeitaufwändige Bannen eines Spielers).
// generell werden alle Aktion des Spielers gespeichert - Namenwechsel bringt ihm auch nichts. Wurde er einmal bestraft und connected neu und wird zum Wiederholungstäter wird die Strafe ebenfalls sofort vollzogen.
tcb_tk_only_one_chance = false;

// ------------------------Log Einträge
// setze TRUE und es wird für jeden "Bestraften" Teamkiller eine Kartei im Briefing angelegt mit folgendem Inhalt:
// Spieler-ID auf dem Server (wie #userlist), Name des Spielers, seine ArmA2 Game-ID  und der Grund für die Bestrafung
// außerdem werden seine Daten nochmal in die server.rpt geschrieben um diese auch noch nach dem Spiel abrufen zu können
tcb_show_his_ass = true;

// ----------------------- Captcha Check
// stellt dem Spieler eine Frage auf Deutsch um seine Identität zu prüfen
// wenn der Spieler deutschsprachig ist, ist die Frage für ihn kein Hinderniss und er wird aufgefordert den Teamspeakserver zu betreten.
// wer nach 3 versuchen keine Antwort hat, wird freundlich vom Server gekickt.
// das System ist remanent, bereits passierte Spieler werden nicht nochmal gefragt, bereits gekickte Spieler kommen nicht mehr auf den Server
// wenn "tcb_tk_only_one_chance" auf true steht.
tcb_tk_captcha = true;





// ------------------------Einstellung für den Mission-Designer:

// setze hier den Pfad in welchem du den Ordner tk_protection untergebracht hast (keine Änderung nötig, falls im mission-ordner):
tk_path = "core\modules\tk_protection\";

// White List - Spielernamen die vom Teamkill System ausgenommen werden sollen
tk_white_list = ["gecoadmin","Grey Wolf"];

// Black List - Spielernamen die vom Teamkill System ausgenommen werden sollen. Wirkt wie ein perma-ban bezogen auf eine Mission.
// Diese Liste sollte hauptsächlich korrupte oder obzöne Name enthalten, wie bereits die aufgeführten.
tk_black_list = ["PLAYER 1"," ","_","Arsch"];

// Captcha Liste - listet alle Captcha Fragen und die dazugehörige Antwort
// die Frage wird zufällig und automatisch ausgewählt, Mehrfachnennung ist möglich
tk_captcha_array = [
	["In welchem Jahr fiel die Berliner Mauer?","1989"],
	["Wie lautet der Vorname unserer Kanzlerin?","angela"],
	["Wieviel Bundeslaender gibt es?","16"],
	["Welches ist das groesste Bundesland?","bayern"],
	["Welche ist die groesste Stadt in Deutschland?","berlin"],
	["Wie oft wurde die Nationalmanschaft Fussballweltmeister? (Zahl)","4"],
	["Wer entwickelte die Relativitaetstheorie? (Vorname)","albert"],
	["Wer steht bei den Bremer Stadtmusikante gaz oben?","hahn"],
	["Welches ist die ehemailige Hauptstadt der Bundesrepublik?","bonn"],
	["Ein beruehmter friesischer Komiker? (Kuenstlername)","otto"],
	["Was bedeutet das Wort GeCo?","german coop"],
	["Wie viele Meere grenzen an Deutschland? (Zahl)","2"],
	["In welchem Bundesland werden gerne Lederhosen getragen?","bayern"],
	["Die Schwester von Haensel ist?","gretel"],
	["Was traegt der gestiefelte Kater am liebsten?","stiefel"],
	["Wer anderen eine Grube graebt faellt selbst...","hinein"]
];