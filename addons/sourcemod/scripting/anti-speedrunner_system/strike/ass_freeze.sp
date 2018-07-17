// Freeze Option
Handle g_hFreezeTimers[MAXPLAYERS + 1];

void vFreezeStart()
{
	PrecacheSound(SOUND_GLASS, true);
}

public Action cmdASSFreeze(int client, int args)
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
	if (!g_bPluginEnabled)
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "MapModeNotSupported") : ReplyToCommand(client, "%s Map or game mode not supported.", ASS_PREFIX01);
		return Plugin_Handled;
	}
	if (!bIsHumanSurvivor(client))
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "WrongTeam") : ReplyToCommand(client, "%s You must be on the survivor team to use this command.", ASS_PREFIX01);
		return Plugin_Handled;
	}
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
			g_bFreezeMenu[client] = true;
			g_bAdminMenu[client] = false;
			vPlayerMenu(client, 0);
		}
		return Plugin_Handled;
	}
	else if (toggle > 1 || args > 2)
	{
		ReplyToCommand(client, "%s Usage: ass_freeze <#userid|name> <0: off|1: on>", ASS_PREFIX01);
		return Plugin_Handled;
	}
	char sTarget[32];
	GetCmdArg(1, sTarget, sizeof(sTarget));
	if (!bSelectTarget(sTarget, client, toggle, 0, 0, 0.0, 0.0, ""))
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
			vFreezeSpeedrunners(target_list[iPlayer], client, toggle);
		}
		ShowActivity2(client, ASS_PREFIX2, "Used \"ass_freeze\" on %s.", target_name);
	}
	g_bFreezeMenu[client] = true;
	g_bAdminMenu[client] = false;
	return Plugin_Handled;
}

void vFreezeSpeedrunners(int target, int client, int toggle, bool log = true)
{
	if (bIsInfected(target))
	{
		return;
	}
	if ((bIsSurvivor(target) && g_cvASSCountBots.BoolValue) || (bIsHumanSurvivor(target) && !g_cvASSCountBots.BoolValue))
	{
		switch (toggle)
		{
			case 0:
			{
				vKillFreezeTimer(target);
				if (bIsHumanSurvivor(target) && log)
				{
					bHasTranslationFile() ? PrintHintText(target, "%s %t", ASS_PREFIX, "FreezeNoInform") : PrintHintText(target, "%s You are not frozen anymore!", ASS_PREFIX);
				}
				for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
				{
					if (bIsHumanSurvivor(iPlayer) && log)
					{
						bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "FreezeNoAnnounce", target) : PrintToChat(iPlayer, "%s %N is not frozen anymore!", ASS_PREFIX01, target);
					}
				}
			}
			case 1:
			{
				if (g_bNull[target] || (g_cvASSAdminImmunity.BoolValue && bIsAdminAllowed(target)))
				{
					vKillFreezeTimer(target);
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
					if (!g_bFreeze[target])
					{
						g_bFreeze[target] = true;
						if (g_hFreezeTimers[target] == null)
						{
							g_hFreezeTimers[target] = CreateTimer(1.0, tTimerFreezeSpeedrunners, GetClientUserId(target), TIMER_REPEAT);
						}
						if (bIsHumanSurvivor(target))
						{
							bHasTranslationFile() ? PrintHintText(target, "%s %t", ASS_PREFIX, "FreezeInform") : PrintHintText(target, "%s You are frozen!", ASS_PREFIX);
						}
						for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
						{
							if (bIsHumanSurvivor(iPlayer))
							{
								bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "FreezeAnnounce", target) : PrintToChat(iPlayer, "%s %N is frozen!", ASS_PREFIX01, target);
							}
						}
					}
				}
			}
		}
		if (g_cvASSLogCommands.BoolValue && log)
		{
			LogAction(client, target, "%s \"%L\" used \"ass_freeze\" on \"%L\".", ASS_PREFIX, client, target);
		}
	}
}

void vKillFreezeTimer(int client)
{
	g_bFreeze[client] = false;
	if (g_hFreezeTimers[client] != null)
	{
		float flVector[3];
		GetClientEyePosition(client, flVector);
		if (GetEntityMoveType(client) == MOVETYPE_NONE)
		{
			SetEntityMoveType(client, MOVETYPE_WALK);
			SetEntityRenderColor(client, 255, 255, 255, 255);
			EmitAmbientSound(SOUND_GLASS, flVector, client, SNDLEVEL_RAIDSIREN);
		}
		KillTimer(g_hFreezeTimers[client]);
		g_hFreezeTimers[client] = null;
	}
}

public Action tTimerFreezeSpeedrunners(Handle timer, any userid)
{
	int client = GetClientOfUserId(userid);
	if (!IsClientInGame(client) || !IsPlayerAlive(client) || bIsPlayerIncapacitated(client))
	{
		vKillFreezeTimer(client);
		return Plugin_Handled;
	}
	float flVector[3];
	GetClientEyePosition(client, flVector);
	if (GetEntityMoveType(client) != MOVETYPE_NONE)
	{
		SetEntityMoveType(client, MOVETYPE_NONE);
		SetEntityRenderColor(client, 0, 130, 255, 190);
		EmitAmbientSound(SOUND_GLASS, flVector, client, SNDLEVEL_RAIDSIREN);
	}
	return Plugin_Continue;
}