//by psycho
diag_log format ["%1 --- Executing GeCo init.sqf",diag_ticktime];
#include "setup.sqf"
if (!isNil "geco_init_processed") exitWith {
	diag_log format ["%1 --- TcB init.sqf executed more than once",diag_ticktime];
};

#ifdef __GECO_ENABLE_INTRO__
titleCut ["","BLACK IN", 999];
#endif

// mission params
if (isNil "paramsArray") then {
	if (isClass (missionConfigFile/"Params")) then {
		_conf = missionConfigFile/"Params";
		for "_i" from 0 to (count _conf - 1) do {
			_paramName = configName (_conf select _i);
			_paramval = getNumber (_conf/_paramName/"default");
			if (_paramval != -99999) then {
				missionNamespace setVariable [_paramName, _paramval];
			};
		};
	};
} else {
	for "_i" from 0 to (count paramsArray - 1) do {
		_paramval = paramsArray select _i;
		if (_paramval != -99999) then {
			missionNamespace setVariable [configName ((missionConfigFile/"Params") select _i), _paramval];
		};
	};
};

// HC_AI_UNIT ----> physischer HC
ai_IS_HC_CLIENT = !isDedicated && {!hasInterface};

if (isNil "tcb_netinit") then {
	x_reload = compile preprocessFileLineNumbers "core\script\x_reload.sqf";
	call compile preprocessFileLineNumbers "core\script\x_netinit.sqf";
	call compile preprocessFileLineNumbers "core\script\netEvents.sqf";
	tcb_netinit = true;
};

setTerrainGrid 3.25;

#ifdef __GECO_VIEWDISTANCE__
setViewDistance __GECO_VIEWDISTANCE__;
#endif

// post-init area:
[] spawn {
	enableRadio false;
	player disableConversation true;
	enableSentences false;
	showSubtitles false;
	enableSaving [false,false];
	enableTeamswitch false;
	
	#ifdef __GECO_FIELDREPAIR__
	call compile preprocessFileLineNumbers "core\modules\f_repair\fieldrepair.sqf";
	#endif
};

geco_init_processed = true;
diag_log format ["%1 --- GeCo init.sqf is processed",diag_ticktime];

#include "init_custom.sqf"