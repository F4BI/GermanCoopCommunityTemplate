private ["_ar", "_wf", "_nt"];
_cf = diag_frameno;
if (_cf == xprevPFrame) exitWith {};
xprevPFrame = _cf;

if (count perframe_array > 0) then {
	{
		_ar = perframe_store getVariable [_x, []];
		if (count _ar > 0) then {
			_wf = _ar select 1;
			if (_wf > 0) then {
				_nt = _ar select 2;
				if (time >= _nt) then {
					call (_ar select 0);
					_ar set [2, time + (_ar select 1)];
				};
			} else {
				call (_ar select 0);
			};
		};
		true
	} count perframe_array;
};