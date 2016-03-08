// by psycho
// check if HC is present, if yes, let the server leave the script
private "_return";
_return = false;

if (!isNil "ai_HC_CLIENT_OBJ") then {
	if (!isNull ai_HC_CLIENT_OBJ) then {
		if (isServer) then {
			_return = true;
		};
	};
};

_return