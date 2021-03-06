﻿// by psycho
// initialization of player markers, defined in tcb_p_entities

_side_array = switch (playerSide) do {
	case (west) : {["ColorBlufor","b_inf"]};
	case (east) : {["ColorOpfor","o_inf"]};
	case (resistance) : {["ColorIndependent","n_inf"]};
	case (civilian) : {["ColorCivilian","n_unknown"]};
	default {["ColorUnknown","n_unknown"]};
};

if (!isNil "tcb_p_entities") then {
	if (toUpper(typeName tcb_p_entities) == "ARRAY") then {
		{
			[(_x select 0), [0,0],"ICON",(_side_array select 0),[1,1],"",0,(_side_array select 1)] call tcb_fnc_CreateMarkerLocal;
			true
		} count tcb_p_entities;
	};
};

[] spawn {
	sleep 3;
	["marker_units", {call tcb_fnc_MarkerPlayers}, 2.02] call tcb_fnc_addPerFrame;
};