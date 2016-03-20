// by psycho
// check if given object/unit is a assigned curator
// return BOOL true or false
private "_ret";
params [["_player", player, [player], 0]];

_ret = false;

_allC = call BIS_fnc_listCuratorPlayers;
if (count _allC > 0) then {
	_ret = if (_player in _allC) then {true} else {false};
};


_ret