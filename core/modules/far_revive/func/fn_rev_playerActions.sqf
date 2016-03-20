////////////////////////////////////////////////
// Player Actions
////////////////////////////////////////////////
if (alive player && player isKindOf "CAManBase") then {
	// addAction args: title, filename, (arguments, priority, showWindow, hideOnUse, shortcut, condition, positionInModel, radius, radiusView, showIn3D, available, textDefault, textToolTip)
	player addAction ["<t color=""#C90000"">" + "Wiederbeleben" + "</t>", "core\modules\FAR_revive\FAR_handleAction.sqf", ["action_revive"], 10, true, true, "", "call tcb_fnc_rev_CheckRevive"];
	player addAction ["<t color=""#C90000"">" + "Stabilisieren" + "</t>", "core\modules\FAR_revive\FAR_handleAction.sqf", ["action_stabilize"], 10, true, true, "", "call tcb_fnc_rev_CheckStabilize"];
	player addAction ["<t color=""#C90000"">" + "Aufgeben" + "</t>", "core\modules\FAR_revive\FAR_handleAction.sqf", ["action_suicide"], 9, false, true, "", "call tcb_fnc_rev_CheckSuicide"];
	player addAction ["<t color=""#C90000"">" + "Ziehen" + "</t>", "core\modules\FAR_revive\FAR_handleAction.sqf", ["action_drag"], 9, false, true, "", "call tcb_fnc_rev_CheckDragging"];
};

true