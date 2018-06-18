// Disarmament Option
ConVar g_cvASSDisarmSlot;
Handle g_hDisarmTimers[MAXPLAYERS + 1];

void vDisarmCvars()
{
	vCreateConVar(g_cvASSDisarmSlot, "assdisarm_weaponslot", "34125", "Which weapon slot should be disarmed?\nCombine numbers in any order for different results.\nCharacter limit: 5\n(1: 1st slot only.)\n(2: 2nd slot only.)\n(3: 3rd slot only.)\n(4: 4th slot only.)\n(5: 5th slot only.)");
}

public Action cmdASSDisarm(int client, int args)
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
	char arg4[32];
	GetCmdArg(4, arg4, sizeof(arg4));
	int timer = StringToInt(arg4);
	char arg3[32];
	GetCmdArg(3, arg3, sizeof(arg3));
	int slot = StringToInt(arg3);
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
			g_bDisarmMenu[client] = true;
			g_bAdminMenu[client] = false;
			vPlayerMenu(client);
		}
		return Plugin_Handled;
	}
	else if (timer > 1 || slot > 6 || toggle > 1 || args > 4)
	{
		ReplyToCommand(client, "%s Usage: ass_disarm <#userid|name> <0: off|1: on> <1: 1st slot|2: 2nd slot|3: 3rd slot|4: 4th slot|5: 5th slot|6: all 5> <0: once|1: repeat>", ASS_PREFIX01);
		return Plugin_Handled;
	}
	char sTarget[32];
	GetCmdArg(1, sTarget, sizeof(sTarget));
	if (!bSelectTarget(sTarget, client, toggle, slot, timer, 0.0, 0.0, ""))
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
			vDisarmSpeedrunners(target_list[iPlayer], client, toggle, true, slot, timer);
		}
		ShowActivity2(client, ASS_PREFIX2, "Used \"ass_disarm\" on %s.", target_name);
	}
	g_bDisarmMenu[client] = true;
	g_bAdminMenu[client] = false;
	return Plugin_Handled;
}

void vDisarm(int client)
{
	if (g_iWeaponSlot[client] == 0 || g_iWeaponSlot[client] > 6)
	{
		char sWeaponSlot[6];
		g_cvASSDisarmSlot.GetString(sWeaponSlot, sizeof(sWeaponSlot));
		if (StrContains(sWeaponSlot, "1", false) != -1 && GetPlayerWeaponSlot(client, 0) > 0)
		{
			SDKHooks_DropWeapon(client, GetPlayerWeaponSlot(client, 0), NULL_VECTOR, NULL_VECTOR);
		}
		if (StrContains(sWeaponSlot, "2", false) != -1 && GetPlayerWeaponSlot(client, 1) > 0)
		{
			SDKHooks_DropWeapon(client, GetPlayerWeaponSlot(client, 1), NULL_VECTOR, NULL_VECTOR);
		}
		if (StrContains(sWeaponSlot, "3", false) != -1 && GetPlayerWeaponSlot(client, 2) > 0)
		{
			SDKHooks_DropWeapon(client, GetPlayerWeaponSlot(client, 2), NULL_VECTOR, NULL_VECTOR);
		}
		if (StrContains(sWeaponSlot, "4", false) != -1 && GetPlayerWeaponSlot(client, 3) > 0)
		{
			SDKHooks_DropWeapon(client, GetPlayerWeaponSlot(client, 3), NULL_VECTOR, NULL_VECTOR);
		}
		if (StrContains(sWeaponSlot, "5", false) != -1 && GetPlayerWeaponSlot(client, 4) > 0)
		{
			SDKHooks_DropWeapon(client, GetPlayerWeaponSlot(client, 4), NULL_VECTOR, NULL_VECTOR);
		}
	}
	else if (g_iWeaponSlot[client] >= 1 && g_iWeaponSlot[client] < 7)
	{
		if ((g_iWeaponSlot[client] == 1 || g_iWeaponSlot[client] == 6) && GetPlayerWeaponSlot(client, 0) > 0)
		{
			SDKHooks_DropWeapon(client, GetPlayerWeaponSlot(client, 0), NULL_VECTOR, NULL_VECTOR);
		}
		if ((g_iWeaponSlot[client] == 2 || g_iWeaponSlot[client] == 6) && GetPlayerWeaponSlot(client, 1) > 0)
		{
			SDKHooks_DropWeapon(client, GetPlayerWeaponSlot(client, 1), NULL_VECTOR, NULL_VECTOR);
		}
		if ((g_iWeaponSlot[client] == 3 || g_iWeaponSlot[client] == 6) && GetPlayerWeaponSlot(client, 2) > 0)
		{
			SDKHooks_DropWeapon(client, GetPlayerWeaponSlot(client, 2), NULL_VECTOR, NULL_VECTOR);
		}
		if ((g_iWeaponSlot[client] == 4 || g_iWeaponSlot[client] == 6) && GetPlayerWeaponSlot(client, 3) > 0)
		{
			SDKHooks_DropWeapon(client, GetPlayerWeaponSlot(client, 3), NULL_VECTOR, NULL_VECTOR);
		}
		if ((g_iWeaponSlot[client] == 5 || g_iWeaponSlot[client] == 6) && GetPlayerWeaponSlot(client, 4) > 0)
		{
			SDKHooks_DropWeapon(client, GetPlayerWeaponSlot(client, 4), NULL_VECTOR, NULL_VECTOR);
		}
	}
}

void vDisarmSpeedrunners(int target, int client, int toggle, bool log = true, int slot = 0, int timer = 0)
{
	g_iWeaponSlot[target] = slot;
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
				vKillDisarmTimer(target);
				if (bIsHumanSurvivor(target) && log)
				{
					bHasTranslationFile() ? PrintHintText(target, "%s %t", ASS_PREFIX, "DisarmNoInform") : PrintHintText(target, "%s You are not being disarmed anymore!", ASS_PREFIX);
				}
				for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
				{
					if (bIsHumanSurvivor(iPlayer) && log)
					{
						bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "DisarmNoAnnounce", target) : PrintToChat(iPlayer, "%s %N is not being disarmed anymore!", ASS_PREFIX01, target);
					}
				}
			}
			case 1:
			{
				if (g_bNull[target] || (g_cvASSAdminImmunity.BoolValue && bIsAdminAllowed(target)))
				{
					vKillDisarmTimer(target);
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
						vDisarm(target);
					}
					else
					{
						if (!g_bDisarm[target])
						{
							g_bDisarm[target] = true;
							if (g_hDisarmTimers[target] == null)
							{
								g_hDisarmTimers[target] = CreateTimer(1.0, tTimerDisarmSpeedrunners, GetClientUserId(target), TIMER_REPEAT);
							}
						}
					}
					if (bIsHumanSurvivor(target) && log)
					{
						bHasTranslationFile() ? PrintHintText(target, "%s %t", ASS_PREFIX, "DisarmInform") : PrintHintText(target, "%s You are being disarmed!", ASS_PREFIX);
					}
					for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
					{
						if (bIsHumanSurvivor(iPlayer) && log)
						{
							bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "DisarmAnnounce", target) : PrintToChat(iPlayer, "%s %N is being disarmed!", ASS_PREFIX01, target);
						}
					}
				}
			}
		}
		if (g_cvASSLogCommands.BoolValue && log)
		{
			LogAction(client, target, "%s \"%L\" used \"ass_disarm\" on \"%L\".", ASS_PREFIX, client, target);
		}
	}
}

void vKillDisarmTimer(int client)
{
	g_bDisarm[client] = false;
	if (g_hDisarmTimers[client] != null)
	{
		KillTimer(g_hDisarmTimers[client]);
		g_hDisarmTimers[client] = null;
	}
}

public Action tTimerDisarmSpeedrunners(Handle timer, any userid)
{
	int client = GetClientOfUserId(userid);
	if (!IsClientInGame(client) || !IsPlayerAlive(client) || bIsPlayerIncapacitated(client))
	{
		vKillDisarmTimer(client);
		return Plugin_Handled;
	}
	vDisarm(client);
	return Plugin_Continue;
}