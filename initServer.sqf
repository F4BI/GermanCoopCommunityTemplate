//init only by server
diag_log format ["%1 --- GeCo server init startet",diag_ticktime];
#include "setup.sqf"

if (isDedicated) then {
	0 spawn {
		private ["_timeout"];
		_timeout = time + 20;
		waitUntil {!isNil "HC_AI_UNIT" || {time > _timeout}};
		if (!isNil "HC_AI_UNIT") then {
			waitUntil {!isNull HC_AI_UNIT || {time > _timeout}};
			if (!isNull HC_AI_UNIT) then {
				ai_HC_CLIENT_OBJ = HC_AI_UNIT;
				ai_HC_CLIENT_OBJ_NAME = name HC_AI_UNIT;
				diag_log format ["HC Object: %1 -----------  HC Name: %2",ai_HC_CLIENT_OBJ,ai_HC_CLIENT_OBJ_NAME];
				0 spawn {
					waitUntil {time > 3 || !isNil "tcb_MissionEndNumUnits"};
					if (!isNil "tcb_MissionEndNumUnits") then {
						tcb_MissionEndNumUnits = tcb_MissionEndNumUnits - 1;
						publicVariable "tcb_MissionEndNumUnits";
					};
				};
			};
		};
	};
};

tcb_num_players_dead = 0;
[[0,0,0], [0,0,0, false],["NONE", "PRESENT", false], ["isServer && (time > 1) && isMultiplayer && (tcb_num_players_dead >= count playableUnits) && (count playableUnits != 0)","['tcb_auto_end_looser',[0]] call XNetCallEvent;",""]] call tcb_fnc_CreateTrigger;

{_x setvariable ["BIS_nocoreconversations",true]} foreach playableUnits;

execVM "core\modules\ai_handling\ai_init.sqf";