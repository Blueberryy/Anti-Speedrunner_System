// Idle Option
Handle g_hSDKIdlePlayer;
Handle g_hSDKSpecPlayer;

void vIdleSDKCalls()
{
	if (bHasGameDataFile())
	{
		g_hGameData = LoadGameConfigFile("anti-speedrunner_system");
		StartPrepSDKCall(SDKCall_Player);
		PrepSDKCall_SetFromConf(g_hGameData, SDKConf_Signature, "CTerrorPlayer::GoAwayFromKeyboard");
		g_hSDKIdlePlayer = EndPrepSDKCall();
		if (g_hSDKIdlePlayer == null)
		{
			bHasTranslationFile() ? PrintToServer("%s %t", ASS_PREFIX, "IdleSignature") : PrintToServer("%s Your \"CTerrorPlayer::GoAwayFromKeyboard\" signature is outdated.", ASS_PREFIX);
		}
		StartPrepSDKCall(SDKCall_Player);
		PrepSDKCall_SetFromConf(g_hGameData, SDKConf_Signature, "SetHumanSpec");
		PrepSDKCall_AddParameter(SDKType_CBasePlayer, SDKPass_Pointer);
		g_hSDKSpecPlayer = EndPrepSDKCall();
		if (g_hSDKSpecPlayer == null)
		{
			bHasTranslationFile() ? PrintToServer("%s %t", ASS_PREFIX, "IdleSignature2") : PrintToServer("%s Your \"SetHumanSpec\" signature is outdated.", ASS_PREFIX);
		}
	}
}

public Action cmdASSIdle(int client, int args)
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
	if (args < 1)
	{
		if (IsVoteInProgress())
		{
			ReplyToCommand(client, "%s %t", ASS_PREFIX01, "Vote in Progress");
		}
		else
		{
			g_bIdleMenu[client] = true;
			g_bAdminMenu[client] = false;
			vPlayerMenu(client);
		}
		return Plugin_Handled;
	}
	else if (args > 1)
	{
		ReplyToCommand(client, "%s Usage: ass_idle <#userid|name>", ASS_PREFIX01);
		return Plugin_Handled;
	}
	char sTarget[32];
	GetCmdArg(1, sTarget, sizeof(sTarget));
	if (!bSelectTarget(sTarget, client, 0, 0, 0, 0.0, 0.0, ""))
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
			vIdleSpeedrunners(target_list[iPlayer], client);
		}
		ShowActivity2(client, ASS_PREFIX2, "Used \"ass_idle\" on %s.", target_name);
	}
	g_bIdleMenu[client] = true;
	g_bAdminMenu[client] = false;
	return Plugin_Handled;
}

void vIdleMessage(int client)
{
	if (bIsValidClient(client))
	{
		bHasTranslationFile() ? PrintHintText(client, "%s %t", ASS_PREFIX, "IdleInform") : PrintHintText(client, "%s You are now idle!", ASS_PREFIX);
	}
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		if (bIsHumanSurvivor(iPlayer))
		{
			bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "IdleAnnounce", client) : PrintToChat(iPlayer, "%s %N is now idle!", ASS_PREFIX01, client);
		}
	}
}

void vIdleWarp(int bot)
{
	float flCurrentOrigin[3] = {0.0, 0.0, 0.0};
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		if ((!bIsSurvivor(iPlayer) && g_cvASSCountBots.BoolValue) || (!bIsHumanSurvivor(iPlayer) && !g_cvASSCountBots.BoolValue) || (g_cvASSAdminImmunity.BoolValue && bIsAdminAllowed(iPlayer)) || g_bRestart[iPlayer] || g_bWarp[iPlayer] || iPlayer == bot)
		{
			continue;
		}
		GetClientAbsOrigin(iPlayer, flCurrentOrigin);
		TeleportEntity(bot, flCurrentOrigin, NULL_VECTOR, NULL_VECTOR);
	}
}

void vIdleSpeedrunners(int target, int client, bool log = true)
{
	if (bIsInfected(target))
	{
		return;
	}
	if (bIsHumanSurvivor(target))
	{
		if (g_bNull[target] || (g_cvASSAdminImmunity.BoolValue && bIsAdminAllowed(target)))
		{
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
			if (!g_bIdle[target])
			{
				if (iGetHumanCount() > 1)
				{
					FakeClientCommand(target, "go_away_from_keyboard");
				}
				else
				{
					vIdleWarp(target);
					SDKCall(g_hSDKIdlePlayer, target);
					vIdleMessage(target);
				}
				if (bIsBotIdle(target))
				{
					g_bAFK[target] = true;
					g_bIdle[target] = true;
				}
			}
		}
		if (g_cvASSLogCommands.BoolValue && log)
		{
			LogAction(client, target, "%s \"%L\" used \"ass_idle\" on \"%L\".", ASS_PREFIX, client, target);
		}
	}
}

public Action tTimerAFKFix(Handle timer, Handle pack)
{
	ResetPack(pack);
	int iSurvivor = ReadPackCell(pack);
	int iBot = ReadPackCell(pack);
	if (!IsClientInGame(iSurvivor) || GetClientTeam(iSurvivor) != 1 || iGetIdleBot(iSurvivor) || IsFakeClient(iSurvivor))
	{
		g_bAFK[iSurvivor] = false;	
	}
	if (!bIsBotIdleSurvivor(iBot) || GetClientTeam(iBot) != 2)
	{
		iBot = iGetBotSurvivor();
	}
	if (iBot < 1)
	{
		g_bAFK[iSurvivor] = false; 
	}
	if (g_bAFK[iSurvivor])
	{
		g_bAFK[iSurvivor] = false;
		SDKCall(g_hSDKSpecPlayer, iBot, iSurvivor);
		SetEntProp(iSurvivor, Prop_Send, "m_iObserverMode", 5);
	}
}
