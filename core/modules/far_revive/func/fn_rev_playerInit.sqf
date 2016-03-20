// Cache player's side
FAR_PlayerSide = playerSide;

// Clear event handler before adding it
player removeAllEventHandlers "HandleDamage";
player addEventHandler ["HandleDamage", tcb_fnc_rev_HandleDamage];

player setVariable ["FAR_isUnconscious", 0, true];
player setVariable ["FAR_isStabilized", 0, true];
player setVariable ["FAR_isDragged", 0, true];
player setVariable ["tcb_healer", objNull, true];
player setCaptive false;
FAR_isDragging = false;
tcb_ais_medequip_array = [];

closeDialog 5566;
closeDialog 5651;

[true] call tcb_fnc_rev_toggleTFAR;

if (!opt_far_f_r) then {
	["far_removeMapMarker", player] call tcb_fnc_NetCallEvent;
} else {
	opt_far_f_r = false;
};

[] spawn tcb_fnc_rev_PlayerActions;