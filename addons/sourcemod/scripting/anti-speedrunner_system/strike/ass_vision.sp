// Vision Option
Handle g_hVisionTimers[MAXPLAYERS + 1];
int g_iFov[MAXPLAYERS + 1];

public Action cmdASSVision(int client, int args)
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
	char arg4[32];
	GetCmdArg(4, arg4, sizeof(arg4));
	int timer = StringToInt(arg4);
	char arg3[32];
	GetCmdArg(3, arg3, sizeof(arg3));
	int fov = StringToInt(arg3);
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
			g_bVisionMenu[client] = true;
			g_bAdminMenu[client] = false;
			vPlayerMenu(client);
		}
		return Plugin_Handled;
	}
	else if (timer > 1 || fov > 160 || toggle > 1 || args > 4)
	{
		ReplyToCommand(client, "%s Usage: ass_vision <#userid|name> <0: off|1: on> <fov <= 160> <0: once|1: repeat>", ASS_PREFIX01);
		return Plugin_Handled;
	}
	char sTarget[32];
	GetCmdArg(1, sTarget, sizeof(sTarget));
	if (!bSelectTarget(sTarget, client, toggle, fov, timer, 0.0, 0.0, ""))
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
			vVisionSpeedrunners(target_list[iPlayer], client, toggle, true, fov, timer);
		}
		ShowActivity2(client, ASS_PREFIX2, "Used \"ass_vision\" on %s.", target_name);
	}
	g_bVisionMenu[client] = true;
	g_bAdminMenu[client] = false;
	return Plugin_Handled;
}

void vVision(int client)
{
	if (IsValidEntity(client))
	{
		SetEntData(client, FindSendPropInfo("CBasePlayer", "m_iFOV"), g_iFov[client], 4, true);
		SetEntData(client, FindSendPropInfo("CBasePlayer", "m_iDefaultFOV"), g_iFov[client], 4, true);
	}
}

void vVisionSpeedrunners(int target, int client, int toggle, bool log = true, int fov = 0, int timer = 0)
{
	fov == 0 ? (g_iFov[target] = 160) : (g_iFov[target] = fov);
	if (bIsInfected(target))
	{
		return;
	}
	if (bIsHumanSurvivor(target))
	{
		switch (toggle)
		{
			case 0:
			{
				vKillVisionTimer(target);
				if (bIsHumanSurvivor(target) && log)
				{
					bHasTranslationFile() ? PrintHintText(target, "%s %t", ASS_PREFIX, "VisionInform") : PrintHintText(target, "%s Your vision has changed!", ASS_PREFIX);
				}
				for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
				{
					if (bIsHumanSurvivor(iPlayer) && log)
					{
						bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "VisionAnnounce", target) : PrintToChat(iPlayer, "%s %N's vision has changed!", ASS_PREFIX01, target);
					}
				}
			}
			case 1:
			{
				if (g_bNull[target] || (g_cvASSAdminImmunity.BoolValue && bIsAdminAllowed(target)))
				{
					vKillVisionTimer(target);
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
						vVision(target);
					}
					else
					{
						if (!g_bVision[target])
						{
							g_bVision[target] = true;
							if (g_hVisionTimers[target] == null)
							{
								g_hVisionTimers[target] = CreateTimer(0.1, tTimerVisionSpeedrunners, target, TIMER_REPEAT);
							}
						}
					}
					if (bIsHumanSurvivor(target) && log)
					{
						bHasTranslationFile() ? PrintHintText(target, "%s %t", ASS_PREFIX, "VisionInform") : PrintHintText(target, "%s Your vision has changed!", ASS_PREFIX);
					}
					for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
					{
						if (bIsHumanSurvivor(iPlayer) && log)
						{
							bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "VisionAnnounce", target) : PrintToChat(iPlayer, "%s %N's vision has changed!", ASS_PREFIX01, target);
						}
					}
				}
			}
		}
		if (g_cvASSLogCommands.BoolValue && log)
		{
			LogAction(client, target, "%s \"%L\" used \"ass_vision\" on \"%L\".", ASS_PREFIX, client, target);
		}
	}
}

void vKillVisionTimer(int client)
{
	g_bVision[client] = false;
	if (g_hVisionTimers[client] != null)
	{
		if (IsValidEntity(client))
		{
			SetEntData(client, FindSendPropInfo("CBasePlayer", "m_iFOV"), 90, 4, true);
			SetEntData(client, FindSendPropInfo("CBasePlayer", "m_iDefaultFOV"), 90, 4, true);
		}
		KillTimer(g_hVisionTimers[client]);
		g_hVisionTimers[client] = null;
	}
}

public Action tTimerVisionSpeedrunners(Handle timer, any client)
{
	if (!IsClientInGame(client) || !IsPlayerAlive(client) || bIsPlayerIncapacitated(client))
	{
		vKillVisionTimer(client);
		return Plugin_Handled;
	}
	vVision(client);
	return Plugin_Continue;
}
