// uncomment for debugging with __TRACE. see below

//#define __DEBUG__

// ------------------------------------------------------------------------------------------ AI handling ---------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
// uncomment this to allow Respawn Groups
// that means that the groups are reduced to one unit (the leader) for the time there are no players around
// you can edit the distance in setup_classnames.sqf

//#define __AI_RESPAWN_GROUPS__

#define __getMNsVar(mvarname) (missionNamespace getVariable #mvarname)
#define __getMNsVar2(mvarname) (missionNamespace getVariable mvarname)
#define __mNsSetVar missionNamespace setVariable
#define __addDead(xunitx) ai_allunits_add pushBack xunitx;

#define __aiccppfln(aifile1) call compile preprocessFileLineNumbers (AI_H_PATH + #aifile1)
#define __aicppfln(aifunc,aifile2) aifunc = compile preprocessFileLineNumbers (AI_H_PATH + #aifile2)