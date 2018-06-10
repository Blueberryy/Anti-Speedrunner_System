// Incapacitation Option
Handle g_hIncapTimers[MAXPLAYERS + 1];
int g_iBeamSprite = -1;
int g_iGreyColor[4] = {128, 128, 128, 255};
int g_iHaloSprite = -1;
int g_iWhiteColor[4] = {255, 255, 255, 255};

void vIncapStart()
{
	g_iBeamSprite = PrecacheModel("sprites/laserbeam.vmt", true);
	g_iHaloSprite = PrecacheModel("sprites/glow01.vmt", true);
}

public Action cmdASSIncap(int client, int args)
{
	if (!g_cvASSEnable.BoolValue)
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "ASSOff") : ReplyToCommand(client, "%s The Anti-Speedrunner System is disabled.", ASS_PREFIX01);
		return Plugin_Handled;
	}
	if (g_cvASSAutoMode.BoolValue && !g_cvASSCommandOverride.BoolValue)
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "CommandOff") : ReplyToCommand(client, "%s This command is disabled.", ASS_PREFIX01);
		return Plugin_Handled;
	}
	if (!g_cvASSTankAlive.BoolValue && iGetTankCount() > 0)
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "TankAlive") : ReplyToCommand(client, "%s There is a Tank alive.", ASS_PREFIX01);
		return Plugin_Handled;
	}
	if (!bIsValidClient(client))
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX, "InGame") : ReplyToCommand(client, "%s This command is to be used only in-game.", ASS_PREFIX);
		return Plugin_Handled;
	}
	if (!bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSEnabledGameModes, g_cvASSDisabledGameModes))
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "MapModeNotSupported") : ReplyToCommand(client, "%s Map or game mode not supported.", ASS_PREFIX01);
		return Plugin_Handled;
	}
	if (!bIsHumanSurvivor(client))
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "WrongTeam") : ReplyToCommand(client, "%s You must be on the survivor team to use this command.", ASS_PREFIX01);
		return Plugin_Handled;
	}
	char arg3[32];
	GetCmdArg(3, arg3, sizeof(arg3));
	int timer = StringToInt(arg3);
	char arg2[32];
	GetCmdArg(2, arg2, sizeof(arg2));
	int toggle = StringToInt(arg2);
	if (args <= 1)
	{
		if (IsVoteInProgress())
		{
			ReplyToCommand(client, "%s %t", ASS_PREFIX01, "Vote in Progress");
		}
		else
		{
			g_bIncapMenu[client] = true;
			g_bAdminMenu[client] = false;
			vPlayerMenu(client);
		}
		return Plugin_Handled;
	}
	else if (timer > 1 || toggle > 1 || args > 3)
	{
		ReplyToCommand(client, "%s Usage: ass_incap <#userid|name> <0: off|1: on> <0: once|1: repeat>", ASS_PREFIX01);
		return Plugin_Handled;
	}
	char sTarget[32];
	GetCmdArg(1, sTarget, sizeof(sTarget));
	if (!bSelectTarget(sTarget, client, toggle, timer, 0, 0.0, 0.0, ""))
	{
		char target_name[32];
		int target_list[MAXPLAYERS];
		int target_count;
		bool tn_is_ml;
		if ((target_count = ProcessTargetString(sTarget, client, target_list, MAXPLAYERS, COMMAND_FILTER_ALIVE, target_name, sizeof(target_name), tn_is_ml)) <= 0)
		{
			ReplyToTargetError(client, target_count);
			return Plugin_Handled;
		}
		for (int iPlayer = 0; iPlayer < target_count; iPlayer++)
		{
			vIncapSpeedrunners(target_list[iPlayer], client, toggle, true, timer);
		}
		ShowActivity2(client, ASS_PREFIX2, "Used \"ass_incap\" on %s.", target_name);
	}
	g_bIncapMenu[client] = true;
	g_bAdminMenu[client] = false;
	return Plugin_Handled;
}

void vIncap(int client)
{
	if (!bIsPlayerIncapacitated(client))
	{
		SetEntProp(client, Prop_Send, "m_isIncapacitated", 1);
	}
	float flVector[3];
	GetClientAbsOrigin(client, flVector);
	flVector[2] += 10;
	TE_SetupBeamRingPoint(flVector, 10.0, 500.0, g_iBeamSprite, g_iHaloSprite, 0, 15, 0.5, 5.0, 0.0, g_iGreyColor, 10, 0);
	TE_SendToAll();
	TE_SetupBeamRingPoint(flVector, 10.0, 500.0, g_iBeamSprite, g_iHaloSprite, 0, 10, 0.6, 10.0, 0.5, g_iWhiteColor, 10, 0);
	TE_SendToAll();
}

void vIncapSpeedrunners(int target, int client, int toggle, bool log = true, int timer = 0)
{
	if (bIsInfected(target))
	{
		return;
	}
	if ((bIsSurvivor(target) && g_cvASSCountBots.BoolValue) || (bIsHumanSurvivor(target) && !g_cvASSCountBots.BoolValue))
	{
		switch (toggle)
		{
			case 0: vKillIncapTimer(target);
			case 1:
			{
				if (g_bNull[target] || (g_cvASSAdminImmunity.BoolValue && bIsAdminAllowed(target)))
				{
					vKillIncapTimer(target);
					if (!g_bCheck[target] && !g_bAutoCheck)
					{
						if (bIsHumanSurvivor(client) && bIsAdminAllowed(client))
						{
							bHasTranslationFile() ? PrintToChat(client, "%s %t", ASS_PREFIX01, "AdminImmune", target) : PrintToChat(client, "%s %N is immune.", ASS_PREFIX01, target);
						}
					}
				}
				else
				{
					if (timer == 0)
					{
						vIncap(target);
					}
					else
					{
						if (!g_bIncap[target])
						{
							g_bIncap[target] = true;
							if (g_hIncapTimers[target] == null)
							{
								g_hIncapTimers[target] = CreateTimer(1.0, tTimerIncapSpeedrunners, target, TIMER_REPEAT);
							}
						}
					}
					if (bIsHumanSurvivor(target) && log)
					{
						bHasTranslationFile() ? PrintHintText(target, "%s %t", ASS_PREFIX, "IncapInform") : PrintHintText(target, "%s You are incapacitated!", ASS_PREFIX);
					}
					for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
					{
						if (bIsHumanSurvivor(iPlayer) && log)
						{
							bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "IncapAnnounce", target) : PrintToChat(iPlayer, "%s %N is incapacitated!", ASS_PREFIX01, target);
						}
					}
				}
			}
		}
		if (g_cvASSLogCommands.BoolValue && log)
		{
			LogAction(client, target, "%s \"%L\" used \"ass_incap\" on \"%L\".", ASS_PREFIX, client, target);
		}
	}
}

void vKillIncapTimer(int client)
{
	g_bIncap[client] = false;
	if (g_hIncapTimers[client] != null)
	{
		KillTimer(g_hIncapTimers[client]);
		g_hIncapTimers[client] = null;
	}
}

public Action tTimerIncapSpeedrunners(Handle timer, any client)
{
	if (!IsClientInGame(client) || !IsPlayerAlive(client))
	{
		vKillIncapTimer(client);
		return Plugin_Handled;
	}
	vIncap(client);
	return Plugin_Continue;
}