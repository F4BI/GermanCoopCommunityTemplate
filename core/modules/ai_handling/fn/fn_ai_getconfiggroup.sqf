private ["_side", "_type", "_typeunits", "_typegroup", "_ret", "_config", "_i", "_cfgn"];
_side = _this select 0;
_type = _this select 1;
_typeunits = _this select 2;
_typegroup = _this select 3;
_ret = [];

_config = (configFile/"CfgGroups"/_side/_type/_typeunits/_typegroup);
if (isClass _config) then {
	for "_i" from 0 to (count _config - 1) do {
		_cfgn = _config select _i;
		if (isClass _cfgn) then {_ret pushBack (getText (_cfgn/"vehicle"))};
	};
};
_ret