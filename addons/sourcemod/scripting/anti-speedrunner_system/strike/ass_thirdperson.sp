// Thirdperson Option
Handle g_hThirdpersonTimers[MAXPLAYERS + 1];

public Action cmdASSThirdperson(int client, int args)
{
	if (!g_cvASSEnable.BoolValue)
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "ASSOff") : ReplyToCommand(client, "%s The Anti-Speedrunner System is disabled.", ASS_PREFIX01);
		return Plugin_Handled;
	}
	if (!bIsL4D2Game())
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "NotL4D2") : ReplyToCommand(client, "%s Available in Left 4 Dead 2 only.", ASS_PREFIX01);
		return Plugin_Handled;
	}
	if (g_cvASSAutoMode.BoolValue && !g_cvASSCommandOverride.BoolValue)
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "CommandOff") : ReplyToCommand(client, "%s This command is disabled.", ASS_PREFIX01);
		return Plugin_Handled;
	}
	vCountTanks();
	if (!g_cvASSTankAlive.BoolValue && g_iTankCount > 0)
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "TankAlive") : ReplyToCommand(client, "%s There is a Tank alive.", ASS_PREFIX01);
		return Plugin_Handled;
	}
	if (!bIsValidClient(client))
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX, "InGame") : ReplyToCommand(client, "%s This command is to be used only in-game.", ASS_PREFIX);
		return Plugin_Handled;
	}
	if (!bIsSystemValid(g_cvASSGameMode, g_cvASSEnabledGameModes, g_cvASSDisabledGameModes))
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
			g_bThirdpersonMenu[client] = true;
			g_bAdminMenu[client] = false;
			vPlayerMenu(client);
		}
		return Plugin_Handled;
	}
	else if (timer > 1 || toggle > 1 || args > 3)
	{
		ReplyToCommand(client, "%s Usage: ass_third <optional - #userid|name> <optional - 0: off|1: on> <optional - 0: once|1: repeat>", ASS_PREFIX01);
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
			vThirdpersonSpeedrunners(target_list[iPlayer], client, toggle, true, timer);
		}
		ShowActivity2(client, ASS_PREFIX2, "Used \"ass_third\" on %s.", target_name);
	}
	g_bThirdpersonMenu[client] = true;
	g_bAdminMenu[client] = false;
	return Plugin_Handled;
}

void vThirdpersonSpeedrunners(int target, int client, int toggle, bool log = true, int timer = 0)
{
	if (bIsInfected(target) || !bIsL4D2Game())
	{
		return;
	}
	if (bIsHumanSurvivor(target))
	{
		switch (toggle)
		{
			case 0:
			{
				vKillThirdpersonTimer(target);
				if (bIsHumanSurvivor(target) && log)
				{
					bHasTranslationFile() ? PrintHintText(target, "%s %t", ASS_PREFIX, "ThirdpersonNoInform") : PrintHintText(target, "%s You are not switching between firstperson and thirdperson anymore!", ASS_PREFIX);
				}
				for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
				{
					if (bIsHumanSurvivor(iPlayer) && log)
					{
						bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "ThirdpersonNoAnnounce", target) : PrintToChat(iPlayer, "%s %N is not switching between firstperson and thirdperson anymore!", ASS_PREFIX01, target);
					}
				}
			}
			case 1:
			{
				if (g_bImmune[target] || (g_cvASSAdminImmunity.BoolValue && bIsAdminAllowed(target)))
				{
					vKillThirdpersonTimer(target);
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
						bIsThirdperson(target) ? SetEntPropFloat(target, Prop_Send, "m_TimeForceExternalView", 0.0) : (bIsPlayerIncapacitated(client) ? SetEntPropFloat(client, Prop_Send, "m_TimeForceExternalView", 0.0) : SetEntPropFloat(client, Prop_Send, "m_TimeForceExternalView", 99999.3));
					}
					else
					{
						if (!g_bThirdperson[target])
						{
							g_bThirdperson[target] = true;
							if (g_hThirdpersonTimers[target] == null)
							{
								g_hThirdpersonTimers[target] = CreateTimer(0.5, tTimerThirdpersonSpeedrunners, target, TIMER_REPEAT);
							}
						}
					}
					if (bIsHumanSurvivor(target) && log)
					{
						bHasTranslationFile() ? PrintHintText(target, "%s %t", ASS_PREFIX, "ThirdpersonInform") : PrintHintText(target, "%s You are switching between firstperson and thirdperson!", ASS_PREFIX);
					}
					for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
					{
						if (bIsHumanSurvivor(iPlayer) && log)
						{
							bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "ThirdpersonAnnounce", target) : PrintToChat(iPlayer, "%s %N is switching between firstperson and thirdperson!", ASS_PREFIX01, target);
						}
					}
				}
			}
		}
		if (g_cvASSLogCommands.BoolValue && log)
		{
			LogAction(client, target, "%s \"%L\" used \"ass_third\" on \"%L\".", ASS_PREFIX, client, target);
		}
	}
}

void vKillThirdpersonTimer(int client)
{
	g_bThirdperson[client] = false;
	if (bIsL4D2Game() && IsClientInGame(client))
	{
		SetEntPropFloat(client, Prop_Send, "m_TimeForceExternalView", 0.0);
	}
	if (g_hThirdpersonTimers[client] != null)
	{
		KillTimer(g_hThirdpersonTimers[client]);
		g_hThirdpersonTimers[client] = null;
	}
}

public Action tTimerThirdpersonSpeedrunners(Handle timer, any client)
{
	if (!IsClientInGame(client) || !IsPlayerAlive(client) || bIsPlayerIncapacitated(client))
	{
		vKillThirdpersonTimer(client);
		return Plugin_Handled;
	}
	bIsThirdperson(client) ? SetEntPropFloat(client, Prop_Send, "m_TimeForceExternalView", 0.0) : SetEntPropFloat(client, Prop_Send, "m_TimeForceExternalView", 99999.3);
	return Plugin_Continue;
}