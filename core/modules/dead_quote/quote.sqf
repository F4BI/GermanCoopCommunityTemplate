﻿/*
 * Show a quote on screen, with the Quote in the center and author in the middle
 * 
 * _this select 0: Quote
 * _this select 1: Author of quote
 * _this select 2: (optional) time to display (default 10)
 */
disableSerialization;

_quote = _this select 0;
_author = _this select 1;
_duration = if (count _this > 2) then {_this select 2} else {10};

disableSerialization;
_layer = "tcbDeadLayer" call BIS_fnc_rscLayer;
_layer cutRsc ["RscDeadQuote", "PLAIN"]; sleep 1;
_time = time;
waitUntil {
	_xxx = uinamespace getvariable "tcb_title";
	!isNil ("_xxx") || (_time + 1 > time)
};

_display = uinamespace getvariable "tcb_title";
if (str (_display) != "no display") then {
    _myText = format ["<t size=2 color='#BEC4FB'>%1</t><br/><br/><br/><t color='#ffffff'><t font='PuristaMedium'><t align='right'>%2</t></t></t>", _quote, _author];
    _text = parseText  _myText;
	_cntrl = _display displayCtrl 1793;
	_cntrl ctrlSetStructuredText _text;
	_cntrl ctrlCommit 0;
    sleep _duration;
};

_layer cutfadeout 0;