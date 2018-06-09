// Keyman Option
bool g_bAutoKeyman;
bool g_bKeymanCountdown;
bool g_bKeymanStarted;
ConVar g_cvASSKeymanCountdown;
ConVar g_cvASSKeymanKeymanAmount;
Handle g_hKeymanTimer;
int g_iKeymanCount;
int g_iKeymanCountdown;

void vKeymanCvars()
{
	vCreateConVar(g_cvASSKeymanCountdown, "asskeyman_countdown", "10", "The Keyman system will automatically pick a new Keyman if the current Keyman does not open the door after X second(s).");
	vCreateConVar(g_cvASSKeymanKeymanAmount, "asskeyman_keymanamount", "2", "How many Keymen are chosen per map?");
	g_iKeymanCountdown = g_cvASSKeymanCountdown.IntValue;
}

void vKeymanSettings()
{
	g_bKeymanStarted = false;
	g_bKeymanCountdown = false;
	g_bBFGKLVoteMenu = false;
	if (g_hKeymanTimer != null)
	{
		KillTimer(g_hKeymanTimer);
		g_hKeymanTimer = null;
	}
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		g_bKeyman[iPlayer] = false;
	}
	g_iKeymanCount = 0;
	g_iKeymanCountdown = g_cvASSKeymanCountdown.IntValue;
}

void vKeymanOption(int client, int entity)
{
	if (bIsSystemValid(g_cvASSGameMode, g_cvASSEnabledGameModes, g_cvASSDisabledGameModes) && bIsSystemValid(g_cvASSGameMode, g_cvASSSaferoomEnabledGameModes, g_cvASSSaferoomDisabledGameModes))
	{
		if (g_iKeymanCount == 0)
		{
			for (int iToucher = 1; iToucher <= MaxClients; iToucher++)
			{
				if (bIsHumanSurvivor(iToucher))
				{
					bHasTranslationFile() ? PrintToChat(iToucher, "%s %t", ASS_PREFIX01, "KeymanInvalid") : PrintToChat(iToucher, "%s Invalid Keyman! Selecting a new Keyman...", ASS_PREFIX01);
				}
			}
			g_bAutoKeyman = false;
			vSelectKeyman(client, client, 1, false);
		}
		else
		{
			if (g_bKeyman[client])
			{
				vEntryMode(entity);
				if (bIsSystemValid(g_cvASSGameMode, g_cvASSEnabledGameModes, g_cvASSDisabledGameModes) && bIsSystemValid(g_cvASSGameMode, g_cvASSSaferoomEnabledGameModes, g_cvASSSaferoomDisabledGameModes))
				{
					for (int iToucher = 1; iToucher <= MaxClients; iToucher++)
					{
						if (bIsHumanSurvivor(iToucher))
						{
							bHasTranslationFile() ? PrintToChat(iToucher, "%s %t", ASS_PREFIX01, "KeymanArrived", client) : PrintToChat(iToucher, "%s The Keyman %N arrived in the saferoom!", ASS_PREFIX01, client);
						}
					}
					if (g_hKeymanTimer != null)
					{
						KillTimer(g_hKeymanTimer);
						g_hKeymanTimer = null;
					}
				}
			}
			else
			{
				EmitSoundToAll("doors/latchlocked2.wav", entity);
				if (bIsHumanSurvivor(client))
				{
					bHasTranslationFile() ? PrintToChat(client, "%s %t", ASS_PREFIX01, "KeymanDeny") : PrintToChat(client, "%s Only Keymen can open the saferoom door!", ASS_PREFIX01);
				}
				for (int iToucher = 1; iToucher <= MaxClients; iToucher++)
				{
					if (g_bKeyman[iToucher])
					{
						bHasTranslationFile() ? PrintToChat(iToucher, "%s %t", ASS_PREFIX, "KeymanInform") : PrintToChat(iToucher, "%s You are a Keyman!", ASS_PREFIX);
					}
				}
				if (!g_bKeymanCountdown)
				{
					g_bKeymanCountdown = true;
					if (g_hKeymanTimer == null)
					{
						g_hKeymanTimer = CreateTimer(1.0, tTimerAutoChooseKeyman, entity, TIMER_REPEAT);
					}
					CreateTimer(g_cvASSKeymanCountdown.FloatValue + 1.0, tTimerKeymanChosen);
				}
			}
		}
	}
}

public Action cmdASSKey(int client, int args)
{
	if (!g_cvASSEnable.BoolValue)
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "ASSOff") : ReplyToCommand(client, "%s The Anti-Speedrunner System is disabled.", ASS_PREFIX01);
		return Plugin_Handled;
	}
	g_cvASSSaferoomSystemOptions.GetString(g_sSaferoomOption, sizeof(g_sSaferoomOption));
	if ((g_cvASSAutoMode.BoolValue && !g_cvASSCommandOverride.BoolValue) || StrContains(g_sSaferoomOption, "k", false) == -1 || bIsFinaleMap() || bIsBuggedMap())
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
	if (!bIsSystemValid(g_cvASSGameMode, g_cvASSEnabledGameModes, g_cvASSDisabledGameModes) || !bIsSystemValid(g_cvASSGameMode, g_cvASSSaferoomEnabledGameModes, g_cvASSSaferoomDisabledGameModes))
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
		for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
		{
			if (g_bKeyman[iPlayer])
			{
				bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "KeymanChosen", iPlayer) : ReplyToCommand(client, "%s %N is a Keyman.", ASS_PREFIX01, iPlayer);
			}
		}
		if (IsVoteInProgress())
		{
			ReplyToCommand(client, "%s %t", ASS_PREFIX01, "Vote in Progress");
		}
		else
		{
			g_bKeymanMenu[client] = true;
			g_bAdminMenu[client] = false;
			vPlayerMenu(client);
		}
		return Plugin_Handled;
	}
	else if (toggle > 1 || args > 2)
	{
		ReplyToCommand(client, "%s Usage: ass_key <#userid|name> <0: off|1: on>", ASS_PREFIX01);
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
			vSelectKeyman(target_list[iPlayer], client, toggle);
		}
		ShowActivity2(client, ASS_PREFIX2, "Used \"ass_key\" on %s.", target_name);
	}
	g_bKeymanMenu[client] = true;
	g_bAdminMenu[client] = false;
	return Plugin_Handled;
}

void vSelectKeyman(int target, int client, int toggle, bool log = true)
{
	if (bIsInfected(target))
	{
		return;
	}
	if (bIsValidClient(target))
	{
		switch (toggle)
		{
			case 0:
			{
				g_bKeyman[target] = false;
				g_iKeymanCount--;
				for (int iAdmin = 1; iAdmin <= MaxClients; iAdmin++)
				{
					if (bIsHumanSurvivor(iAdmin) && bIsAdminAllowed(iAdmin))
					{
						bHasTranslationFile() ? PrintToChat(iAdmin, "%s %t", ASS_PREFIX01, "NotKeyman", target) : PrintToChat(iAdmin, "%s %N is not a Keyman anymore.", ASS_PREFIX01, target);
					}
				}
			}
			case 1:
			{
				if (g_bKeyman[target] && bIsAbleHumanSurvivor(target))
				{
					g_bAutoKeyman = false;
					vNotifyPlayers(target);
					g_bKeyman[target] = true;
				}
				else if (!g_bKeyman[target] && bIsAbleHumanSurvivor(target))
				{
					if (g_iKeymanCount < g_cvASSKeymanKeymanAmount.IntValue)
					{
						g_bAutoKeyman = false;
						vNotifyPlayers(target);
						g_bKeyman[target] = true;
						g_iKeymanCount++;
					}
					else if (g_iKeymanCount == g_cvASSKeymanKeymanAmount.IntValue)
					{
						if (bIsHumanSurvivor(client))
						{
							bHasTranslationFile() ? PrintToChat(client, "%s %t", ASS_PREFIX01, "KeymanEnough", g_iKeymanCount, g_cvASSKeymanKeymanAmount.IntValue) : PrintToChat(client, "%s There are already %d/%d Keymen for this map.", ASS_PREFIX01, g_iKeymanCount, g_cvASSKeymanKeymanAmount.IntValue);
						}
					}
				}
			}
		}
		if (g_cvASSLogCommands.BoolValue && log)
		{
			LogAction(client, target, "%s \"%L\" used \"ass_key\" on \"%L\".", ASS_PREFIX, client, target);
		}
	}
}

void vKeymanStats()
{
	g_bLeftSaferoom = false;
	g_bPlayerMoved = false;
	g_iKeymanCount = 0;
	vSetStarted(false);
}

void vSetStarted(bool started)
{
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		g_bStarted[iPlayer] = started;
	}
}

void vChooseKeyman()
{
	for (int iKeyman = 1; iKeyman <= MaxClients; iKeyman++)
	{
		if (g_bKeyman[iKeyman] || !bIsAbleHumanSurvivor(iKeyman) || g_iKeymanCount == g_cvASSKeymanKeymanAmount.IntValue)
		{
			continue;
		}
		vNotifyPlayers(iKeyman);
		g_bKeyman[iKeyman] = true;
		g_iKeymanCount++;
	}
}

void vNotifyPlayers(int client)
{
	if (bIsSystemValid(g_cvASSGameMode, g_cvASSEnabledGameModes, g_cvASSDisabledGameModes) && bIsSystemValid(g_cvASSGameMode, g_cvASSSaferoomEnabledGameModes, g_cvASSSaferoomDisabledGameModes) && !bIsFinaleMap() && !bIsBuggedMap())
	{
		for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
		{
			if (client > 0 && !bIsHumanSurvivor(client))
			{
				client = 0;
			}
			if (g_iKeymanCount > 0 && g_bKeyman[client] && !bIsHumanSurvivor(client))
			{
				g_iKeymanCount = 0;
			}
			if ((bIsHumanSurvivor(iPlayer) && g_bAutoKeyman) || (bIsHumanSurvivor(iPlayer) && bIsAdminAllowed(iPlayer) && !g_bAutoKeyman))
			{
				!bIsHumanSurvivor(client) ? (bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "KeymanNotChosen") : PrintToChat(iPlayer, "%s A Keyman was not chosen.", ASS_PREFIX01)) : (g_iKeymanCount == 0 ? (bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "KeymanChosen", client) : PrintToChat(iPlayer, "%s %N is a Keyman.", ASS_PREFIX01, client)) : (g_bKeyman[client] ? (bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "KeymanSame", client) : PrintToChat(iPlayer, "%s %N is still a Keyman.", ASS_PREFIX01, client)) : (bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "KeymanChosen", client) : PrintToChat(iPlayer, "%s %N is a Keyman.", ASS_PREFIX01, client))));
			}
		}
	}
}

public Action tTimerAutoChooseKeyman(Handle timer, any entity)
{
	EmitSoundToAll("buttons/blip1.wav", entity);
	g_iKeymanCountdown--;
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		if (bIsHumanSurvivor(iPlayer))
		{
			bHasTranslationFile() ? PrintHintText(iPlayer, "%s %t", ASS_PREFIX, "KeymanCountdown", g_iKeymanCountdown) : PrintHintText(iPlayer, "%s Selecting new Keymen in %d.", ASS_PREFIX, g_iKeymanCountdown);
		}
	}
	return Plugin_Continue;
}

public Action tTimerChooseKeyman(Handle timer)
{
	if (g_bLeftSaferoom && bIsSystemValid(g_cvASSGameMode, g_cvASSEnabledGameModes, g_cvASSDisabledGameModes) && bIsSystemValid(g_cvASSGameMode, g_cvASSSaferoomEnabledGameModes, g_cvASSSaferoomDisabledGameModes) && !bIsFinaleMap() && !bIsBuggedMap())
	{
		g_bAutoKeyman = false;
		vChooseKeyman();
	}
}

public Action tTimerKeymanChosen(Handle timer)
{
	if (g_hKeymanTimer != null)
	{
		g_bKeymanCountdown = false;
		g_bAutoKeyman = true;
		g_iKeymanCount = 0;
		g_iKeymanCountdown = g_cvASSKeymanCountdown.IntValue;
		vChooseKeyman();
		KillTimer(g_hKeymanTimer);
		g_hKeymanTimer = null;
	}
}
