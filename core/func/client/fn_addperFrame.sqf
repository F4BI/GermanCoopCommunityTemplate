private "_ar";
params [
	["_name",[]],
	"_code",
	"_time"	//_time = 0 = every frame
];

_name = toLower _name;
_ar = perframe_store getVariable ["_name", []];

_ar set [0, _code];
_ar set [1, _time];
_ar set [2, 0];

perframe_store setVariable [_name, _ar];
perframe_array pushBack _name;