// Puke Option
Handle g_hPukeTimers[MAXPLAYERS + 1];
Handle g_hSDKPukePlayer;

void vPukeSDKCall()
{
	if (bHasGameDataFile())
	{
		g_hGameData = LoadGameConfigFile("anti-speedrunner_system");
		StartPrepSDKCall(SDKCall_Player);
		PrepSDKCall_SetFromConf(g_hGameData, SDKConf_Signature, "CTerrorPlayer_OnVomitedUpon");
		PrepSDKCall_AddParameter(SDKType_CBasePlayer, SDKPass_Pointer);
		PrepSDKCall_AddParameter(SDKType_PlainOldData, SDKPass_Plain);
		g_hSDKPukePlayer = EndPrepSDKCall();
		if (g_hSDKPukePlayer == null)
		{
			bHasTranslationFile() ? PrintToServer("%s %t", ASS_PREFIX, "PukeSignature") : PrintToServer("%s Your \"CTerrorPlayer_OnVomitedUpon\" signature is outdated.", ASS_PREFIX);
		}
	}
}

public Action cmdASSPuke(int client, int args)
{
	if (!g_cvASSEnable.BoolValue)
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "ASSOff") : ReplyToCommand(client, "%s The Anti-Speedrunner System is disabled.", ASS_PREFIX01);
		return Plugin_Handled;
	}
	if ((g_cvASSAutoMode.BoolValue && !g_cvASSCommandOverride.BoolValue) || !bHasGameDataFile())
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
			g_bPukeMenu[client] = true;
			g_bAdminMenu[client] = false;
			vPlayerMenu(client);
		}
		return Plugin_Handled;
	}
	else if (timer > 1 || toggle > 1 || args > 3)
	{
		ReplyToCommand(client, "%s Usage: ass_puke <#userid|name> <0: off|1: on> <0: once|1: repeat>", ASS_PREFIX01);
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
			vPukeSpeedrunners(target_list[iPlayer], client, toggle, true, timer);
		}
		ShowActivity2(client, ASS_PREFIX2, "Used \"ass_puke\" on %s.", target_name);
	}
	g_bPukeMenu[client] = true;
	g_bAdminMenu[client] = false;
	return Plugin_Handled;
}

void vPuke(int client)
{
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		if ((bIsSurvivor(iPlayer) && g_cvASSCountBots.BoolValue) || (bIsHumanSurvivor(iPlayer) && !g_cvASSCountBots.BoolValue) && client != iPlayer)
		{
			SDKCall(g_hSDKPukePlayer, client, iPlayer, true);
		}
	}
}

void vPukeSpeedrunners(int target, int client, int toggle, bool log = true, int timer = 0)
{
	if (bIsInfected(target) || !bHasGameDataFile())
	{
		return;
	}
	if ((bIsSurvivor(target) && g_cvASSCountBots.BoolValue) || (bIsHumanSurvivor(target) && !g_cvASSCountBots.BoolValue))
	{
		switch (toggle)
		{
			case 0:
			{
				vKillPukeTimer(target);
				if (bIsHumanSurvivor(target) && log)
				{
					bHasTranslationFile() ? PrintHintText(target, "%s %t", ASS_PREFIX, "PukeNoInform") : PrintHintText(target, "%s You are not being puked on anymore!", ASS_PREFIX);
				}
				for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
				{
					if (bIsHumanSurvivor(iPlayer) && log)
					{
						bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "PukeNoAnnounce", target) : PrintToChat(iPlayer, "%s %N is not being puked on anymore!", ASS_PREFIX01, target);
					}
				}
			}
			case 1:
			{
				if (g_bNull[target] || (g_cvASSAdminImmunity.BoolValue && bIsAdminAllowed(target)))
				{
					vKillPukeTimer(target);
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
						vPuke(target);
					}
					else
					{
						if (!g_bPuke[target])
						{
							g_bPuke[target] = true;
							if (g_hPukeTimers[target] == null)
							{
								g_hPukeTimers[target] = CreateTimer(7.0, tTimerPukeSpeedrunners, target, TIMER_REPEAT);
							}
						}
					}
					if (bIsHumanSurvivor(target) && log)
					{
						bHasTranslationFile() ? PrintHintText(target, "%s %t", ASS_PREFIX, "PukeInform") : PrintHintText(target, "%s You are being puked on!", ASS_PREFIX);
					}
					for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
					{
						if (bIsHumanSurvivor(iPlayer) && log)
						{
							bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "PukeAnnounce", target) : PrintToChat(iPlayer, "%s %N is being puked on!", ASS_PREFIX01, target);
						}
					}
				}
			}
		}
		if (g_cvASSLogCommands.BoolValue && log)
		{
			LogAction(client, target, "%s \"%L\" used \"ass_puke\" on \"%L\".", ASS_PREFIX, client, target);
		}
	}
}

void vKillPukeTimer(int client)
{
	g_bPuke[client] = false;
	if (g_hPukeTimers[client] != null)
	{
		KillTimer(g_hPukeTimers[client]);
		g_hPukeTimers[client] = null;
	}
}

public Action tTimerPukeSpeedrunners(Handle timer, any client)
{
	if (!IsClientInGame(client) || !IsPlayerAlive(client) || bIsPlayerIncapacitated(client))
	{
		vKillPukeTimer(client);
		return Plugin_Handled;
	}
	vPuke(client);
	return Plugin_Continue;
}
