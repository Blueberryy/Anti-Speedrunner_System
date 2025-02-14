// Delay Option
ConVar g_cvASSDelayDoorDelay;
ConVar g_cvASSDelayDoorSpeed;
ConVar g_cvASSDelayDoorType;

void vDelayCvars()
{
	vCreateConVar(g_cvASSDelayDoorDelay, "assdelay_doordelay", "3.0", "Prevent saferoom doors from being spammed for X second(s).\n(0: OFF)", _, true, 1.0, true, 99999.0);
	vCreateConVar(g_cvASSDelayDoorSpeed, "assdelay_doorspeed", "25.0", "Saferoom doors move at this speed.\n(Default speed: 200.0)", _, true, 1.0, true, 200.0);
	vCreateConVar(g_cvASSDelayDoorType, "assdelay_doortype", "21", "Which type of saferoom door should be affected?\nCombine numbers in any order for different results.\nCharacter limit: 2\n(1: Starting saferoom doors only.)\n(2: Ending saferoom doors only.)");
}

void vSDoorSpeed(int client, int entity)
{
	if (g_cvASSEnable.BoolValue && g_cvASSSaferoomEnable.BoolValue && !g_bNull[client] && (!g_cvASSAdminImmunity.BoolValue || (g_cvASSAdminImmunity.BoolValue && !bIsAdminAllowed(client))) && (!g_cvASSNoFinales.BoolValue || (g_cvASSNoFinales.BoolValue && !bIsFinaleMap())) && StrContains(g_sDoorType, "1", false) != -1 && g_bPluginEnabled && g_bPluginEnabled2)
	{
		SetEntPropFloat(entity, Prop_Data, "m_flSpeed", g_cvASSDelayDoorSpeed.FloatValue);
	}
	else if (!g_cvASSEnable.BoolValue || !g_cvASSSaferoomEnable.BoolValue || g_bNull[client] || (g_cvASSAdminImmunity && bIsAdminAllowed(client)) || (g_cvASSNoFinales.BoolValue && bIsFinaleMap()) || StrContains(g_sDoorType, "1", false) == -1 || !g_bPluginEnabled || !g_bPluginEnabled2)
	{
		SetEntPropFloat(entity, Prop_Data, "m_flSpeed", 200.0);
	}
}

void vEDoorSpeed(int client, int entity)
{
	if (g_cvASSEnable.BoolValue && g_cvASSSaferoomEnable.BoolValue && !g_bNull[client] && (!g_cvASSAdminImmunity.BoolValue || (g_cvASSAdminImmunity.BoolValue && !bIsAdminAllowed(client))) && (!g_cvASSNoFinales.BoolValue || (g_cvASSNoFinales.BoolValue && !bIsFinaleMap())) && StrContains(g_sDoorType, "2", false) != -1 && g_bPluginEnabled && g_bPluginEnabled2)
	{
		SetEntPropFloat(entity, Prop_Data, "m_flSpeed", g_cvASSDelayDoorSpeed.FloatValue);
	}
	else if (!g_cvASSEnable.BoolValue || !g_cvASSSaferoomEnable.BoolValue || g_bNull[client] || (g_cvASSAdminImmunity && bIsAdminAllowed(client)) || (g_cvASSNoFinales.BoolValue && bIsFinaleMap()) || StrContains(g_sDoorType, "2", false) == -1 || !g_bPluginEnabled || !g_bPluginEnabled2)
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