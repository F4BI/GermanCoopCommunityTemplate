// uncomment for debugging with __TRACE. see below

//#define __DEBUG__

//#define __AI_RESPAWN_GROUPS__

#define __getMNsVar(mvarname) (missionNamespace getVariable #mvarname)
#define __getMNsVar2(mvarname) (missionNamespace getVariable mvarname)
#define __mNsSetVar missionNamespace setVariable
#define __addDead(xunitx) ai_allunits_add pushBack xunitx;

#define __aiccppfln(aifile1) call compile preprocessFileLineNumbers (AI_H_PATH + #aifile1)
#define __aicppfln(aifunc,aifile2) aifunc = compile preprocessFileLineNumbers (AI_H_PATH + #aifile2)