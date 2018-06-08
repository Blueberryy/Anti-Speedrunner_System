// Delay Option
ConVar g_cvASSDelayDoorDelay;
ConVar g_cvASSDelayDoorSpeed;
ConVar g_cvASSDelayDoorType;

void vDelayCvars()
{
	g_cvASSDelayDoorDelay = ASS_ConVar("assdelay_doordelay", "3.0", "Prevent saferoom doors from being spammed for X second(s).\n(0: OFF)", _, true, 0.0, true, 99999.0);
	g_cvASSDelayDoorSpeed = ASS_ConVar("assdelay_doorspeed", "25.0", "Saferoom doors move at this speed.\n(Default speed: 200.0)", _, true, 0.0, true, 99999.0);
	g_cvASSDelayDoorType = ASS_ConVar("assdelay_doortype", "21", "Which type of saferoom door should be affected?\nCombine numbers in any order for different results.\nCharacter limit: 2\n(1: Starting saferoom doors only.)\n(2: Ending saferoom doors only.)");
}

void vDoorSpeed(int client, int entity)
{
	if (!g_bNull[client] && (!g_cvASSAdminImmunity.BoolValue || (g_cvASSAdminImmunity.BoolValue && !bIsAdminAllowed(client))))
	{
		SetEntPropFloat(entity, Prop_Data, "m_flSpeed", g_cvASSDelayDoorSpeed.FloatValue);
	}
	else if (g_bNull[client] || (g_cvASSAdminImmunity && bIsAdminAllowed(client)))
	{
		SetEntPropFloat(entity, Prop_Data, "m_flSpeed", 200.0);
	}
}

public void vStartAntiSpamDoor(const char[] output, int caller, int activator, float delay)
{
	SetEntProp(caller, Prop_Data, "m_hasUnlockSequence", 1);
	AcceptEntityInput(caller, "Lock");
	CreateTimer(g_cvASSDelayDoorDelay.FloatValue, tTimerStopAntiSpamDoor, EntIndexToEntRef(caller));
}

public Action tTimerStopAntiSpamDoor(Handle timer, any entity)
{
	if ((entity = EntRefToEntIndex(entity)) == INVALID_ENT_REFERENCE)
	{
		return Plugin_Stop;
	}
	SetEntProp(entity, Prop_Data, "m_hasUnlockSequence", 0);
	AcceptEntityInput(entity, "Lock");
	return Plugin_Stop;
}