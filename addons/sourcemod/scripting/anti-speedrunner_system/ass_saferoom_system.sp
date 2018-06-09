// Saferoom System
void vSaferoomCvars()
{
	vCreateConVar(g_cvASSSaferoomDisabledGameModes, "asssaferoom_disabledgamemodes", "versus,realismversus,scavenge,survival,mutation1", "Disable the Boss, Group, Keyman, and Lockdown systems in these game modes.\nSeparate game modes with commas.\nGame mode limit: 64\nCharacter limit for each game mode: 32\n(Empty: None)\n(Not empty: Disabled only in these game modes.)");
	vCreateConVar(g_cvASSSaferoomEnabledGameModes, "asssaferoom_enabledgamemodes", "coop,realism,mutation12", "Enable the Boss, Group, Keyman, and Lockdown systems in these game modes.\nSeparate game modes with commas.\nGame mode limit: 64\nCharacter limit for each game mode: 32\n(Empty: All)\n(Not empty: Enabled only in these game modes.)");
	vCreateConVar(g_cvASSSaferoomSystemOptions, "asssaferoom_systemoptions", "KkKkLLllfFfFbbBBgGGg", "Which system options do you want to use to deal with speedrunners?\nCombine letters in any order for different results.\nRepeat the same letter to increase its chance of being chosen.\nCharacter limit: 20\n(B or b: Boss)\n(F or f: Filter)\n(G or g: Group)\n(K or k: Keyman)\n(L or l: Lockdown)");
	g_iWarpCountdown = g_cvASSSaferoomWarpCountdown.IntValue;
}

void vHookSaferoomCvars()
{
	g_cvASSEnabledGameModes.AddChangeHook(vSaferoomGameModeCvars);
	g_cvASSDisabledGameModes.AddChangeHook(vSaferoomGameModeCvars);
	g_cvASSEnable.AddChangeHook(vSaferoomGameModeCvars);
	g_cvASSEnable.AddChangeHook(vASSBossEnableCvar);
	g_cvASSEnable.AddChangeHook(vASSFilterEnableCvar);
	g_cvASSEnable.AddChangeHook(vASSGroupEnableCvar);
	g_cvASSEnable.AddChangeHook(vASSKeymanEnableCvar);
	g_cvASSEnable.AddChangeHook(vASSLockdownEnableCvar);
	g_cvASSLockdownDoorType.AddChangeHook(vASSLockdownEnableCvar);
	g_cvASSSaferoomEnabledGameModes.AddChangeHook(vSaferoomGameModeCvars);
	g_cvASSSaferoomDisabledGameModes.AddChangeHook(vSaferoomGameModeCvars);
	g_cvASSSaferoomEnable.AddChangeHook(vSaferoomGameModeCvars);
	g_cvASSSaferoomEnable.AddChangeHook(vASSBossEnableCvar);
	g_cvASSSaferoomEnable.AddChangeHook(vASSFilterEnableCvar);
	g_cvASSSaferoomEnable.AddChangeHook(vASSGroupEnableCvar);
	g_cvASSSaferoomEnable.AddChangeHook(vASSKeymanEnableCvar);
	g_cvASSSaferoomEnable.AddChangeHook(vASSLockdownEnableCvar);
	g_cvASSSaferoomSystemOptions.AddChangeHook(vASSBossEnableCvar);
	g_cvASSSaferoomSystemOptions.AddChangeHook(vASSFilterEnableCvar);
	g_cvASSSaferoomSystemOptions.AddChangeHook(vASSGroupEnableCvar);
	g_cvASSSaferoomSystemOptions.AddChangeHook(vASSKeymanEnableCvar);
	g_cvASSSaferoomSystemOptions.AddChangeHook(vASSLockdownEnableCvar);
}

void vSaferoomStart()
{
	if (g_cvASSSaferoomEnable.BoolValue && bIsSystemValid(g_cvASSGameMode, g_cvASSSaferoomEnabledGameModes, g_cvASSSaferoomDisabledGameModes))
	{
		PrecacheModel("models/props_doors/checkpoint_door_02.mdl", true);
		PrecacheSound("ambient/alarms/klaxon1.wav", true);
		PrecacheSound("buttons/blip1.wav", true);
		PrecacheSound("buttons/button14.wav", true);
		PrecacheSound("doors/latchlocked2.wav", true);
		PrecacheSound("doors/door_squeek1.wav", true);
		g_cvASSSaferoomSystemOptions.GetString(g_sSaferoomOption, sizeof(g_sSaferoomOption));
		if (StrContains(g_sSaferoomOption, "g", false) != -1)
		{
			vGroupStart();
		}
	}
}

public Action cmdASSDoor(int client, int args)
{
	if (!g_cvASSEnable.BoolValue)
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "ASSOff") : ReplyToCommand(client, "%s The Anti-Speedrunner System is disabled.", ASS_PREFIX01);
		return Plugin_Handled;
	}
	if (!g_cvASSSaferoomEnable.BoolValue)
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "SaferoomOff") : ReplyToCommand(client, "%s Saferoom System disabled.", ASS_PREFIX01);
		return Plugin_Handled;
	}
	g_cvASSSaferoomSystemOptions.GetString(g_sSaferoomOption, sizeof(g_sSaferoomOption));
	g_cvASSLockdownDoorType.GetString(g_sLockdownType, sizeof(g_sLockdownType));
	char arg2[32];
	GetCmdArg(2, arg2, sizeof(arg2));
	int toggle = StringToInt(arg2);
	char arg[32];
	GetCmdArg(1, arg, sizeof(arg));
	int type = StringToInt(arg);
	if ((StrContains(g_sSaferoomOption, "b", false) == -1 && StrContains(g_sSaferoomOption, "f", false) == -1 && StrContains(g_sSaferoomOption, "g", false) == -1 && StrContains(g_sSaferoomOption, "k", false) == -1 && StrContains(g_sSaferoomOption, "l", false) == -1 && StrContains(g_sLockdownType, "1", false) == -1 && StrContains(g_sLockdownType, "2", false) == -1) || (type == 0 && (StrContains(g_sSaferoomOption, "l", false) == -1 || StrContains(g_sLockdownType, "1", false) == -1)))
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
	if (bIsFinaleMap() || bIsBuggedMap() || !bIsSystemValid(g_cvASSGameMode, g_cvASSEnabledGameModes, g_cvASSDisabledGameModes) || !bIsSystemValid(g_cvASSGameMode, g_cvASSSaferoomEnabledGameModes, g_cvASSSaferoomDisabledGameModes))
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "MapModeNotSupported") : ReplyToCommand(client, "%s Map or game mode not supported.", ASS_PREFIX01);
		return Plugin_Handled;
	}
	if (!bIsHumanSurvivor(client))
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "WrongTeam") : ReplyToCommand(client, "%s You must be on the survivor team to use this command.", ASS_PREFIX01);
		return Plugin_Handled;
	}
	if (args <= 1)
	{
		IsVoteInProgress() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "Vote in Progress") : vDoorTypeMenu(client);
		return Plugin_Handled;
	}
	else if (type > 1 || toggle > 1 || args > 2)
	{
		ReplyToCommand(client, "%s Usage: ass_door <0: starting door|1: ending door> <0: unlock|1: lock>", ASS_PREFIX01);
		return Plugin_Handled;
	}
	vDoorOperation(client, type, toggle);
	ShowActivity2(client, ASS_PREFIX2, "Used \"ass_door\".");
	return Plugin_Handled;
}

public Action cmdASSEntry(int client, int args)
{
	if (!g_cvASSEnable.BoolValue)
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "ASSOff") : ReplyToCommand(client, "%s The Anti-Speedrunner System is disabled.", ASS_PREFIX01);
		return Plugin_Handled;
	}
	g_cvASSSaferoomSystemOptions.GetString(g_sSaferoomOption, sizeof(g_sSaferoomOption));
	if (!g_cvASSSaferoomEnable.BoolValue)
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
	if (bIsFinaleMap() || bIsBuggedMap() || !bIsSystemValid(g_cvASSGameMode, g_cvASSEnabledGameModes, g_cvASSDisabledGameModes) || !bIsSystemValid(g_cvASSGameMode, g_cvASSSaferoomEnabledGameModes, g_cvASSSaferoomDisabledGameModes))
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "MapModeNotSupported") : ReplyToCommand(client, "%s Map or game mode not supported.", ASS_PREFIX01);
		return Plugin_Handled;
	}
	if (!bIsHumanSurvivor(client))
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "WrongTeam") : ReplyToCommand(client, "%s You must be on the survivor team to use this command.", ASS_PREFIX01);
		return Plugin_Handled;
	}
	if (args >= 1)
	{
		ReplyToCommand(client, "%s Usage: ass_entry", ASS_PREFIX01);
		return Plugin_Handled;
	}
	vEntry(client);
	ShowActivity2(client, ASS_PREFIX2, "Used \"ass_entry\".");
	return Plugin_Handled;
}

public Action cmdASSSaferoom(int client, int args)
{
	if (!g_cvASSEnable.BoolValue)
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "ASSOff") : ReplyToCommand(client, "%s The Anti-Speedrunner System is disabled.", ASS_PREFIX01);
		return Plugin_Handled;
	}
	g_cvASSSaferoomSystemOptions.GetString(g_sSaferoomOption, sizeof(g_sSaferoomOption));
	g_cvASSLockdownDoorType.GetString(g_sLockdownType, sizeof(g_sLockdownType));
	if (!g_cvASSSaferoomEnable.BoolValue || (StrContains(g_sSaferoomOption, "b", false) == -1 && StrContains(g_sSaferoomOption, "f", false) == -1 && StrContains(g_sSaferoomOption, "g", false) == -1 && StrContains(g_sSaferoomOption, "k", false) == -1 && StrContains(g_sSaferoomOption, "l", false) == -1 && StrContains(g_sLockdownType, "2", false) == -1))
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
	if (bIsFinaleMap() || bIsBuggedMap() || !bIsSystemValid(g_cvASSGameMode, g_cvASSEnabledGameModes, g_cvASSDisabledGameModes) || !bIsSystemValid(g_cvASSGameMode, g_cvASSSaferoomEnabledGameModes, g_cvASSSaferoomDisabledGameModes))
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "MapModeNotSupported") : ReplyToCommand(client, "%s Map or game mode not supported.", ASS_PREFIX01);
		return Plugin_Handled;
	}
	if (!bIsHumanSurvivor(client))
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "WrongTeam") : ReplyToCommand(client, "%s You must be on the survivor team to use this command.", ASS_PREFIX01);
		return Plugin_Handled;
	}
	char arg[32];
	GetCmdArg(1, arg, sizeof(arg));
	int toggle = StringToInt(arg);
	if (args < 1)
	{
		IsVoteInProgress() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "Vote in Progress") : vSaferoomOptionMenu(client);
		return Plugin_Handled;
	}
	else if (toggle > 5 || args > 1)
	{
		ReplyToCommand(client, "%s Usage: ass_room <0: none|1: boss|2: filter|3: group|4: keyman|5: lockdown>", ASS_PREFIX01);
		return Plugin_Handled;
	}
	vSaferoomMethods(client, toggle);
	ShowActivity2(client, ASS_PREFIX2, "Used \"ass_room\".");
	return Plugin_Handled;
}

void vDoorOperation(int client, int type, int toggle)
{
	switch (toggle)
	{
		case 0:
		{
			bHasTranslationFile() ? PrintToChat(client, "%s %t", ASS_PREFIX01, "Unlocked") : PrintToChat(client, "%s Saferoom door forcefully unlocked.", ASS_PREFIX01);
			if (type == 0)
			{
				vSDoorControl(g_iDoorId, false);
			}
			else if (type == 1)
			{
				vEDoorControl(g_iDoorId2, false);
			}
			vResetVoteMenus();
		}
		case 1:
		{
			bHasTranslationFile() ? PrintToChat(client, "%s %t", ASS_PREFIX01, "Locked") : PrintToChat(client, "%s Saferoom door forcefully locked.", ASS_PREFIX01);
			if (type == 0)
			{
				vSDoorControl(g_iDoorId, true);
			}
			else if (type == 1)
			{
				vEDoorControl(g_iDoorId2, true);
			}
			vResetVoteMenus();
		}
	}
	if (g_cvASSLogCommands.BoolValue)
	{
		LogAction(client, -1, "%s \"%L\" used \"ass_door\".", ASS_PREFIX, client);
	}
}

void vEntry(int client, bool log = true)
{
	vCheatCommand(client, "warp_all_survivors_to_checkpoint");
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		if (bIsHumanSurvivor(iPlayer))
		{
			bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "EntryInform") : PrintToChat(iPlayer, "%s Warped all survivors inside the saferoom.", ASS_PREFIX01);
		}
	}
	if (g_cvASSLogCommands.BoolValue && log)
	{
		LogAction(client, -1, "%s \"%L\" used \"ass_entry\".", ASS_PREFIX, client);
	}
}

void vSaferoomMethods(int client, int toggle)
{
	g_cvASSSaferoomSystemOptions.GetString(g_sSaferoomOption, sizeof(g_sSaferoomOption));
	switch (toggle)
	{
		case 0: vNoneOption(g_iDoorId2, true);
		case 1:
		{
			if (StrContains(g_sSaferoomOption, "b", false) != -1)
			{
				g_bBossStarted = true;
				vEDoorControl(g_iDoorId2, true);
			}
			else
			{
				bHasTranslationFile() ? PrintToChat(client, "%s %t", ASS_PREFIX01, "BossOff") : PrintToChat(client, "%s Boss disabled.", ASS_PREFIX01);
			}
			vFilterSettings();
			vGroupSettings();
			vKeymanSettings();
			vLockdownSettings();
			vEntryModeSettings();
		}
		case 2:
		{
			if (StrContains(g_sSaferoomOption, "f", false) != -1)
			{
				g_bFilterStarted = true;
				vEDoorControl(g_iDoorId2, true);
			}
			else
			{
				bHasTranslationFile() ? PrintToChat(client, "%s %t", ASS_PREFIX01, "FilterOff") : PrintToChat(client, "%s Filter disabled.", ASS_PREFIX01);
			}
			vBossSettings();
			vGroupSettings();
			vKeymanSettings();
			vLockdownSettings();
			vEntryModeSettings();
		}
		case 3:
		{
			if (StrContains(g_sSaferoomOption, "g", false) != -1)
			{
				g_bGroupStarted = true;
				vEDoorControl(g_iDoorId2, true);
			}
			else
			{
				bHasTranslationFile() ? PrintToChat(client, "%s %t", ASS_PREFIX01, "GroupOff") : PrintToChat(client, "%s Group disabled.", ASS_PREFIX01);
			}
			vBossSettings();
			vFilterSettings();
			vKeymanSettings();
			vLockdownSettings();
			vEntryModeSettings();
		}
		case 4:
		{
			if (StrContains(g_sSaferoomOption, "k", false) != -1)
			{
				g_bKeymanStarted = true;
				vEDoorControl(g_iDoorId2, true);
			}
			else
			{
				bHasTranslationFile() ? PrintToChat(client, "%s %t", ASS_PREFIX01, "KeymanOff") : PrintToChat(client, "%s Keyman disabled.", ASS_PREFIX01);
			}
			vBossSettings();
			vFilterSettings();
			vGroupSettings();
			vLockdownSettings();
			vEntryModeSettings();
		}
		case 5:
		{
			g_cvASSLockdownDoorType.GetString(g_sLockdownType, sizeof(g_sLockdownType));
			if (StrContains(g_sSaferoomOption, "l", false) != -1 && StrContains(g_sLockdownType, "2", false) != -1)
			{
				g_bLockdownStarted2 = true;
				vEDoorControl(g_iDoorId2, true);
			}
			else
			{
				bHasTranslationFile() ? PrintToChat(client, "%s %t", ASS_PREFIX01, "LockdownOff") : PrintToChat(client, "%s Lockdown disabled.", ASS_PREFIX01);
			}
			vBossSettings();
			vFilterSettings();
			vGroupSettings();
			vKeymanSettings();
		}
	}
	if (g_cvASSLogCommands.BoolValue)
	{
		LogAction(client, -1, "%s \"%L\" used \"ass_room\".", ASS_PREFIX, client);
	}
}

void vNoneOption(int entity, bool type)
{
	EmitSoundToAll("doors/door_squeek1.wav", entity);
	type ? vEDoorControl(entity, false) : vSDoorControl(entity, false);
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		if (bIsHumanSurvivor(iPlayer))
		{
			bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "DoorOpened") : PrintToChat(iPlayer, "%s The saferoom door has opened!", ASS_PREFIX01);
		}
	}
}

public void vSaferoomGameModeCvars(ConVar convar, const char[] oldValue, const char[] newValue)
{
	g_cvASSSaferoomSystemOptions.GetString(g_sSaferoomOption, sizeof(g_sSaferoomOption));
	g_cvASSLockdownDoorType.GetString(g_sLockdownType, sizeof(g_sLockdownType));
	if (bIsSystemValid(g_cvASSGameMode, g_cvASSEnabledGameModes, g_cvASSDisabledGameModes))
	{
		if (!g_cvASSSaferoomEnable.BoolValue || !bIsSystemValid(g_cvASSGameMode, g_cvASSSaferoomEnabledGameModes, g_cvASSSaferoomDisabledGameModes))
		{
			if (StrContains(g_sSaferoomOption, "l", false) != -1 && StrContains(g_sLockdownType, "1", false) != -1)
			{
				if (g_iDoorId != -1)
				{
					vResetVoteMenus();
					vSDoorControl(g_iDoorId, false);
				}
			}
			if (StrContains(g_sSaferoomOption, "b", false) != -1 || StrContains(g_sSaferoomOption, "f", false) != -1 || StrContains(g_sSaferoomOption, "g", false) != -1 || StrContains(g_sSaferoomOption, "k", false) != -1 || (StrContains(g_sSaferoomOption, "l", false) != -1 && StrContains(g_sLockdownType, "2", false) != -1))
			{
				if (g_iDoorId2 != -1)
				{
					vResetVoteMenus();
					vEDoorControl(g_iDoorId2, false);
					g_iDoorId2 = -1;
				}
			}
		}
		else if (g_cvASSSaferoomEnable.BoolValue && bIsSystemValid(g_cvASSGameMode, g_cvASSSaferoomEnabledGameModes, g_cvASSSaferoomDisabledGameModes))
		{
			if (StrContains(g_sSaferoomOption, "l", false) != -1 && StrContains(g_sLockdownType, "1", false) != -1)
			{
				if (g_iDoorId == -1)
				{
					vSInitializeDoor();
					vResetVoteMenus();
				}
				else
				{
					vResetVoteMenus();
					vSDoorControl(g_iDoorId, true);
				}
			}
			if (StrContains(g_sSaferoomOption, "b", false) != -1 || StrContains(g_sSaferoomOption, "f", false) != -1 || StrContains(g_sSaferoomOption, "g", false) != -1 || StrContains(g_sSaferoomOption, "k", false) != -1 || (StrContains(g_sSaferoomOption, "l", false) != -1 && StrContains(g_sLockdownType, "2", false) != -1))
			{
				if (g_iDoorId2 == -1)
				{
					vEInitializeDoor();
					vResetVoteMenus();
				}
				else
				{
					vResetVoteMenus();
					vEDoorControl(g_iDoorId2, true);
				}
			}
		}
	}
}

public void vASSBossEnableCvar(ConVar convar, const char[] oldValue, const char[] newValue)
{
	g_cvASSSaferoomSystemOptions.GetString(g_sSaferoomOption, sizeof(g_sSaferoomOption));
	if (!g_cvASSEnable.BoolValue || !g_cvASSSaferoomEnable.BoolValue || StrContains(g_sSaferoomOption, "b", false) == -1 || (g_cvASSEnable.BoolValue && g_cvASSSaferoomEnable.BoolValue && StrContains(g_sSaferoomOption, "b", false) != -1))
	{
		vBossSettings();
		vEntryModeSettings();
	}
}

public void vASSFilterEnableCvar(ConVar convar, const char[] oldValue, const char[] newValue)
{
	g_cvASSSaferoomSystemOptions.GetString(g_sSaferoomOption, sizeof(g_sSaferoomOption));
	if (!g_cvASSEnable.BoolValue || !g_cvASSSaferoomEnable.BoolValue || StrContains(g_sSaferoomOption, "f", false) == -1 || (g_cvASSEnable.BoolValue && g_cvASSSaferoomEnable.BoolValue && StrContains(g_sSaferoomOption, "f", false) != -1))
	{
		vFilterSettings();
		vEntryModeSettings();
	}
}

public void vASSGroupEnableCvar(ConVar convar, const char[] oldValue, const char[] newValue)
{
	g_cvASSSaferoomSystemOptions.GetString(g_sSaferoomOption, sizeof(g_sSaferoomOption));
	if (!g_cvASSEnable.BoolValue || !g_cvASSSaferoomEnable.BoolValue || StrContains(g_sSaferoomOption, "g", false) == -1 || (g_cvASSEnable.BoolValue && g_cvASSSaferoomEnable.BoolValue && StrContains(g_sSaferoomOption, "g", false) != -1))
	{
		vGroupSettings();
		vEntryModeSettings();
	}
}

public void vASSKeymanEnableCvar(ConVar convar, const char[] oldValue, const char[] newValue)
{
	g_cvASSSaferoomSystemOptions.GetString(g_sSaferoomOption, sizeof(g_sSaferoomOption));
	if (!g_cvASSEnable.BoolValue || !g_cvASSSaferoomEnable.BoolValue || StrContains(g_sSaferoomOption, "k", false) == -1 || (g_cvASSEnable.BoolValue && g_cvASSSaferoomEnable.BoolValue && StrContains(g_sSaferoomOption, "k", false) != -1))
	{
		vKeymanSettings();
		vEntryModeSettings();
	}
}

public void vASSLockdownEnableCvar(ConVar convar, const char[] oldValue, const char[] newValue)
{
	g_cvASSSaferoomSystemOptions.GetString(g_sSaferoomOption, sizeof(g_sSaferoomOption));
	g_cvASSLockdownDoorType.GetString(g_sLockdownType, sizeof(g_sLockdownType));
	if (!g_cvASSEnable.BoolValue || !g_cvASSSaferoomEnable.BoolValue || StrContains(g_sSaferoomOption, "l", false) == -1 || (StrContains(g_sLockdownType, "1", false) == -1 && StrContains(g_sLockdownType, "2", false) == -1) || (g_cvASSEnable.BoolValue && g_cvASSSaferoomEnable.BoolValue && StrContains(g_sSaferoomOption, "l", false) != -1))
	{
		vLockdownSettings();
		vEntryModeSettings();
	}
}
