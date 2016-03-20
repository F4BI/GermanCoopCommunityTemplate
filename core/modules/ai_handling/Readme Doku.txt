// by Psycho
// Unit and Vehicle Spawn System == AI Handler

Features:
-----------------------------------------------------------------------------------------------------------
	- Gruppen Spawn
	- Fahrzeug Spawn
	- gemischte Gruppen
	- alle Gruppen aus den Standard Arma Configs zusammen gestellt, teilweise randomisiert
	- Gruppen werden automatisch verkleinert wenn keine Spieler in der Umgebung sind (Performance)
	- simpler Aufruf über möglichst kurze Scriptaufrufe per Trigger, einfaches Setup
	- unterschiedliche Tasks welche das Verhalten der Gruppen beeinflussen
	- Zeus und Headless Client support
	

How To:
-----------------------------------------------------------------------------------------------------------
Alle Aufrufe werden in auf der Map platzierten triggern vorgenommen. Alle Aufrufe können auch mit Scripten erfolgen sofern dann auch ein Ausgangspunkt (Ort) definiert wird.
Jeder Aufruf besteht aus mind. einem Ort/Objekt und einem Array welches die Gtruppe und deren Aktionen definiert.

	Syntax minimum:
		--> position: center Position für alle weiteren Berechnungen. Kann der Trigger selbst sein, ein Marker oder direkte Position. (object, string, array)
		--> group_type: Art der Gruppe welche gespawnt werden soll, als String. Siehe hierzu -Group Type Table- weiter unten. 
		
		psy = [position, ["group_type"] ] spawn ai_handler;
	
	
	Syntax maximum:
		--> action_radius: Dieser Radius (Zahl) gibt an in welchem Umfeld die Einheiten um das Center zufällig spawnen. Außerdem gibt es den Radius für Patrollienwegpunkte vor. Standard ist 100m
		--> task: Hier können als String oder Array besondere Tasks definiert werden. Der Standard task ist immer "PATROL". (siehe -Task Type Table-)
		--> side: hier kann eine abweichende Seite von der Variable tcb_enemy in der setup.sqf definiert werden. Seiten: blufor, opfor, independent (z.B. um verbündete Truppen zu spawnen)
		
		psy = [position, ["group_type", action_radius, "task", side] ] spawn ai_handler;
	

	Syntax für mehrere Gruppen für einen Bereich:
		--> jedes weitere Array kann eine beliebige Gruppe mit belieben Paramatern/Aufgaben generieren.
		
		psy = [position, ["group_type_1"], ["group_type_2"], ["group_type_n"] ] spawn ai_handler;




Beispiele für Aufrufe:
-----------------------------------------------------------------------------------------------------------
psy = [thisTrigger,["basic",300]] spawn ai_handler;												Basic Inf Trupp mit, area 300m, Task Patrol
psy = [thisTrigger,["basic",50,"defend"]] spawn ai_handler;										Basic Inf Trupp mit, area 50m, Task Defend
psy = [thisTrigger,["motor_basic",200,["repsawn",3]], ["basic",400]] spawn ai_handler;			motorisierte Inf, area 200m, Task respawn 2x, weitere Truppe, Basic Inf Trupp mit, area 400m, Task Patrol





-Group Type Table- (immer als String!!!)
-----------------------------------------------------------------------------------------------------------
basic					// normale Inf Gruppe, div. Stärke zwischen 4 bis 8 Einheiten
specops					// kleinere Inf Gruppe, dafür stärkere Fähigkeiten (Recon Patrol o. Sniper Team)

motor_basic				// kleinere Inf Gruppe und ein leichtes Fahrzeug (z.B. Ifrit mit HMG)
motor_at				// wie Basic jedoch auf AT spezialisiert
motor_aa				// wie Basic jedoch auf AA spezialisiert

mech_basic				// Gruppe von 8 Inf Soldaten und ein APC Begleitfahrzeug (z.B. Marid)
mech_at					// wie Basic jedoch auf AT spezialisiert
mech_aa					// wie Basic jedoch auf AA spezialisiert
mech_support			// wie Basic jedoch auf Reperatur spezialisiert

tank_section			// 2 starke MBT's im Verbund (z.B. T-100)
apc_section				// 2 APC's im Verbund
tank_aa_platoon			// 2  MBT's + 2 ZSU's im Verbund (sehr stark!)

- hier können einzelne Fahrzeugtypen aufgerufen werden:
mbt						// 1 MBT
apc_tracked				// 1 APC tracked
apc_wheeled				// 1 APC wheeled
aa						// 1 AA-APC
car						// 1 MRAP
car_armed				// 1 bewaffnetes MRAP
static_light			// 1 statischer Pod (HMG oder GMG)
static_heavy			// 1 statischer Pod (AA oder AT)
static_mortar			// 1 Mörser Pod
supply_fuel				// Supply Truck
supply_rep				// Supply Truck
supply_ammo				// Supply Truck




-Task Type Table-
-----------------------------------------------------------------------------------------------------------
"patrol"					// Patrollie in gebiet mit zufälligen Wegpunkten (Standard task wenn nichts definiert)
"defend"					// definierte Stellung (Center) wird verteidigt. Einheiten suchen sich automatisch leere statische Waffen, setzen sich um Lagerfeuer usw...
"attack"					// Gruppe spawnt am äußeren Rand des Bereiches (action_radius) und greift Zentrum an. Wenn eingenommen wechselt die Gruppe auf Task defend.
["attack",thereObj]			// Wie Attack jedoch mit definiertem Angriffspunkt (thereObj). Dieser kann auch außerhalb des Spawnbereiches oder Trigger liegen. (beliebig)
["attack","thereMarker"]	// selbes wie Oben jedoch mit einem Marker als Ziel statt einem Objekt.
["respawn",3]				// Die Gruppe mit diesem Task startet mit dem task Defend an der Center Position. Wenn die Gruppe ausgelöscht wurde spawnt eine neue. Die neue Gruppe startet mit dem Task Attack und greift die ursprüngliche Stellung an. Die Zahl gibt die Anzahl der Respawn Tickets wieder. (3 = 3 Respawns, also 4x die Gruppe auslöschen)
["respawn",3,thereObj]		// selbes wie oben, jedoch mit definiertem Respawn Punkt. (kann auch ein Marker oder eine direkte Position sein)
["respawn",3,thereObj,300]	// selbes wie oben, jedoch mit zusätzlichem Respawn Delay in Sekunden. (standard bei Inf: 1 Minute, bei Fahrzeugen 2 Minuten)





-allgm. Infos-
-----------------------------------------------------------------------------------------------------------
- Patrolradius ist 25% größer als der Spawnradius bei Inf (wenn action_radius 200m werden die Wegpunkte also im 250m Radius kalkuliert)
- Patrolradius ist 50% größer als der Spawnradius bei Vecs (wenn action_radius 200m werden die Wegpunkte also im 300m Radius kalkuliert)
- Inf Gruppen patrouillieren zufällig auch durch Gebäude oder besetzen diese von Zeit zu Zeit
- die hauptsächlich gegnerische Seite die gespawnt werden soll (und noch ein paar andere Dinge) kann in der setup.sqf definiert werden. (z.B. --> tcb_enemy = opfor;)





TODO bei public stand-alone release:
- prüfen ob alle common functions enthalten sind (arraypushstack2, tcb_fnc_RandomArrayVal)
- nethandling vorhanden?...
- Attack Heli Gruppe anlegen
- Inf resupply Gruppen anlegen (Paradrops und LKW)