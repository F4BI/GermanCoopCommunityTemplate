diag_log format ["############################# %1 #############################", missionName];
tcb_allunits_ai_add = [];

XGreyText = {"<t color='#f0bfbfbf'>" + _this + "</t>"};
XRedText = {"<t color='#f0ff0000'>" + _this + "</t>"};
XYellowText = {"<t color='#f07f7f00'>" + _this + "</t>"};
XBlueText = {"<t color='#655EDE'>" + _this + "</t>"};
XTuerkiesText = {"<t color='#00D3BF'>" + _this + "</t>"};
tcb_brown = "#6E5A2B";
tcb_blue = "#655EDE";
tcb_grey = "#f0bfbfbf";

AI_H_PATH = "core\modules\ai_handling\";
TK_PATH = "core\modules\tk_protection\";

if (!isDedicated) then {
	client_jip_init_trigger = createTrigger ["EmptyDetector", [0,0,0]];
	client_jip_init_trigger setTriggerArea [0,0,0,false];
	client_jip_init_trigger setTriggerActivation ["NONE", "PRESENT", false];
	client_jip_init_trigger setTriggerTimeout [1, 1, 1, false];
	client_jip_init_trigger setTriggerStatements ["!isNull player && {!isNil 'geco_init_processed'}","diag_log [diag_frameno, diag_tickTime, time, 'Executing local player JIP trigger']; call compile preprocessFileLineNumbers 'core\script\jip.sqf'", ""];
	tcb_fnc_preloadfin = {
		[tcb_prl_fin_id, "onPreloadFinished"] call BIS_fnc_removeStackedEventHandler;
		tcb_prl_fin_id = nil;
		tcb_fnc_preloadfin = nil;
		tcb_preload_done = true;
	};
	tcb_prl_fin_id = ["tcb_ID", "onPreloadFinished", "tcb_fnc_preloadfin"] call BIS_fnc_addStackedEventHandler;
};

diag_log format ["%1 --- geco preinit.sqf is processed",diag_ticktime];