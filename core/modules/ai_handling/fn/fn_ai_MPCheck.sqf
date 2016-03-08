if (isMultiplayer) then {
	if ((call tcb_fnc_playersNumber) == 0) then {
		if (!ai_all_simulation_stoped) then {
			ai_all_simulation_stoped = true;
			{_x enableSimulation false} forEach allUnits;
		};
		waitUntil {sleep (1.012 + random 1);(call tcb_fnc_playersNumber) > 0};
		if (ai_all_simulation_stoped) then {
			ai_all_simulation_stoped = false;
			{_x enableSimulation true} forEach allUnits;
		};
	};
};
true