// returns the number of human players currently playing a mission in MP
private "_ret";
_ret = playersNumber opfor + playersNumber blufor + playersNumber independent + playersNumber civilian;
if (isNil "ai_IS_HC_CLIENT") then {ai_IS_HC_CLIENT = false};
if (ai_IS_HC_CLIENT && {_ret > 0}) then {
	_ret = _ret - 1;
};
_ret