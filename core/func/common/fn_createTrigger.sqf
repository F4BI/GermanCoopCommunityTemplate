//example: 	[_pos, [0, 0, 0, false],["NONE", "PRESENT", true], ["", "", ""]] call tcb_fnc_CreateTrigger;
params ["_pos","_trigarea","_trigact","_trigstatem"];

_trigger = createTrigger ["EmptyDetector" ,_pos];
_trigger setTriggerArea _trigarea;
_trigger setTriggerActivation _trigact;
_trigger setTriggerStatements _trigstatem;

_trigger