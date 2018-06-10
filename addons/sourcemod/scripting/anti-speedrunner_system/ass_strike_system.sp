// Strike System
ConVar g_cvASSStrikeDelay;
ConVar g_cvASSStrikeDistanceLimit;
ConVar g_cvASSStrikeDistanceWarning;
ConVar g_cvASSStrikePunishMode;
ConVar g_cvASSStrikeStrikeMode;
Handle g_hAutoCheckTimer;
Handle g_hCheckTimers[MAXPLAYERS + 1];

void vStrikeCvars()
{
	vCreateConVar(g_cvASSStrikeDelay, "assstrike_detectiondelay", "5.0", "How many seconds between each check for speedrunners?", _, true, 0.0, true, 99999.0);
	vCreateConVar(g_cvASSStrikeDistanceLimit, "assstrike_distancelimit", "2000", "Distance allowed before speedrunners are dealt with.", _, true, 1.0, true, 99999.0);
	vCreateConVar(g_cvASSStrikeDistanceWarning, "assstrike_distancewarning", "1000", "Distance allowed before speedrunners are warned to go back.", _, true, 1.0, true, 99999.0);
	vCreateConVar(g_cvASSStrikePunishMode, "assstrike_punishmode", "1", "Combine punishment options or randomly pick one?\n(0: Combine)\n(1: Pick one)", _, true, 0.0, true, 1.0);
	vCreateConVar(g_cvASSStrikeStrikeLimit, "assstrike_strikelimit", "5", "Number of strikes needed to be punished for speedrunning.", _, true, 1.0, true, 99999.0);
	vCreateConVar(g_cvASSStrikeStrikeMode, "assstrike_strikemode", "1", "Give strikes first before punishing speedrunners?\n(0: OFF)\n(1: ON)", _, true, 0.0, true, 1.0);
	vCreateConVar(g_cvASSStrikeSystemOptions, "assstrike_systemoptions", "QqWweErRtTyYuUIiOopPAasSdDfFgGHhJjkKLlXxcCvVbBnNMm", "Which system options do you want to use to deal with speedrunners?\nCombine letters in any order for different results.\nRepeat the same letter to increase its chance of being chosen.\nCharacter limit: 52\n(A or a: Slow)\n(B or b: Drug)\n(C or c: Blindness)\n(D or d: Shove)\n(E or e: Shake)\n(F or f: Freeze)\n(G or g: Inversion)\n(H or h: Restart)\n(I or i: Warp)\n(J or j: Ammunition)\n(K or k: Disarmament)\n(L or l: Hurt)\n(M or m: Mirror)\n(N or n: Fire)\n(O or o: Health)\n(P or p: Vision)\n(Q or q: Incapacitation)\n(R or r: Rocket)\n(S or s: Shock)\n(T or t: Explosion)\n(U or u: Puke)\n(V or v: Chase)\n(W or w: Acidity, switches to Puke in L4D1.)\n(X or x: Charge, switches to Chase in L4D1.)\n(Y or y: Idle)\n(Z or z: Exile)");
}

void vHookStrikeCvars()
{
	g_cvASSStrikeDelay.AddChangeHook(vStrikeDelayCvar);
}

public Action cmdASSCheck(int client, int args)
{
	if (!g_cvASSEnable.BoolValue)
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "ASSOff") : ReplyToCommand(client, "%s The Anti-Speedrunner System is disabled.", ASS_PREFIX01);
		return Plugin_Handled;
	}
	if (!g_cvASSStrikeEnable.BoolValue || (g_cvASSNoFinales.BoolValue && bIsFinaleMap()))
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "StrikeOff") : ReplyToCommand(client, "%s Strike System disabled.", ASS_PREFIX01);
		return Plugin_Handled;
	}
	if (g_cvASSAutoMode.BoolValue)
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
			g_bCheckMenu[client] = true;
			g_bAdminMenu[client] = false;
			vPlayerMenu(client);
		}
		return Plugin_Handled;
	}
	else if (timer > 1 || toggle > 1 || args > 3)
	{
		ReplyToCommand(client, "%s Usage: ass_check <#userid|name> <0: off|1: on> <0: once|1: repeat>", ASS_PREFIX01);
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
			vCheckSpeedrunners(target_list[iPlayer], client, toggle, true, timer);
		}
		ShowActivity2(client, ASS_PREFIX2, "Used \"ass_check\" on %s.", target_name);
	}
	g_bCheckMenu[client] = true;
	g_bAdminMenu[client] = false;
	return Plugin_Handled;
}

public Action cmdASSNull(int client, int args)
{
	if (!g_cvASSEnable.BoolValue)
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "ASSOff") : ReplyToCommand(client, "%s The Anti-Speedrunner System is disabled.", ASS_PREFIX01);
		return Plugin_Handled;
	}
	if (!g_cvASSStrikeEnable.BoolValue || (g_cvASSNoFinales.BoolValue && bIsFinaleMap()))
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "StrikeOff") : ReplyToCommand(client, "%s Strike System disabled.", ASS_PREFIX01);
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
			g_bNullMenu[client] = true;
			g_bAdminMenu[client] = false;
			vPlayerMenu(client);
		}
		return Plugin_Handled;
	}
	else if (toggle > 1 || args > 2)
	{
		ReplyToCommand(client, "%s Usage: ass_null <#userid|name> <0: off|1: on>", ASS_PREFIX01);
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
			vNullSpeedrunners(target_list[iPlayer], client, toggle);
		}
		ShowActivity2(client, ASS_PREFIX2, "Used \"ass_null\" on %s.", target_name);
	}
	g_bNullMenu[client] = true;
	g_bAdminMenu[client] = false;
	return Plugin_Handled;
}

public Action cmdASSStrike(int client, int args)
{
	if (!g_cvASSEnable.BoolValue)
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "ASSOff") : ReplyToCommand(client, "%s The Anti-Speedrunner System is disabled.", ASS_PREFIX01);
		return Plugin_Handled;
	}
	if (!g_cvASSStrikeEnable.BoolValue || (g_cvASSNoFinales.BoolValue && bIsFinaleMap()))
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "StrikeOff") : ReplyToCommand(client, "%s Strike System disabled.", ASS_PREFIX01);
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
	char arg2[32];
	GetCmdArg(2, arg2, sizeof(arg2));
	int amount = StringToInt(arg2);
	if (args < 1)
	{
		if (IsVoteInProgress())
		{
			ReplyToCommand(client, "%s %t", ASS_PREFIX01, "Vote in Progress");
		}
		else
		{
			g_bStrikeMenu[client] = true;
			g_bAdminMenu[client] = false;
			vPlayerMenu(client);
		}
		return Plugin_Handled;
	}
	else if (args > 2)
	{
		ReplyToCommand(client, "%s Usage: ass_strike <#userid|name> <amount >= 1>", ASS_PREFIX01);
		return Plugin_Handled;
	}
	char sTarget[32];
	GetCmdArg(1, sTarget, sizeof(sTarget));
	if (!bSelectTarget(sTarget, client, 0, amount, 0, 0.0, 0.0, ""))
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
			vStrikeSpeedrunners(target_list[iPlayer], client, true, amount);
		}
		ShowActivity2(client, ASS_PREFIX2, "Used \"ass_strike\" on %s.", target_name);
	}
	g_bStrikeMenu[client] = true;
	g_bAdminMenu[client] = false;
	return Plugin_Handled;
}

void vAutoCheckSpeedrunners(int toggle)
{
	switch (toggle)
	{
		case 0: vKillAutoCheckTimer();
		case 1:
		{
			for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
			{
				vKillCheckTimer(iPlayer);
			}
			vAutoCheckTimer();
		}
	}
}

void vAutoCheckTimer()
{
	g_bAutoCheck = true;
	if (g_hAutoCheckTimer == null)
	{
		g_hAutoCheckTimer = CreateTimer(g_cvASSStrikeDelay.FloatValue, tTimerAutoDetectSpeedrunners, _, TIMER_REPEAT);
	}
}

void vKillAutoCheckTimer()
{
	g_bAutoCheck = false;
	if (g_hAutoCheckTimer != null)
	{
		KillTimer(g_hAutoCheckTimer);
		g_hAutoCheckTimer = null;
	}
}

void vCheckSpeedrunners(int target, int client, int toggle, bool log = true, int timer = 0)
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
				vKillCheckTimer(target);
				if (bIsHumanSurvivor(target) && log)
				{
					bHasTranslationFile() ? PrintHintText(target, "%s %t", ASS_PREFIX, "CheckNoInform") : PrintHintText(target, "%s You are not being checked anymore!", ASS_PREFIX);
				}
				for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
				{
					if (bIsHumanSurvivor(iPlayer) && log)
					{
						bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "CheckNoAnnounce", target) : PrintToChat(iPlayer, "%s %N is not being checked anymore!", ASS_PREFIX01, target);
					}
				}
			}
			case 1:
			{
				if (g_bNull[target] || (g_cvASSAdminImmunity.BoolValue && bIsAdminAllowed(target)))
				{
					vKillCheckTimer(target);
					if (!g_bCheck[target] && !g_bAutoCheck)
					{
						for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
						{
							if (bIsHumanSurvivor(iPlayer) && bIsAdminAllowed(iPlayer))
							{
								bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "AdminImmune", target) : PrintToChat(iPlayer, "%s %N is immune.", ASS_PREFIX01, target);
							}
						}
					}
				}
				else
				{
					if (timer == 0)
					{
						tTimerDetectSpeedrunners(null, target);
					}
					else
					{
						if (!g_bCheck[target])
						{
							g_bCheck[target] = true;
							if (g_hCheckTimers[target] == null)
							{
								g_hCheckTimers[target] = CreateTimer(g_cvASSStrikeDelay.FloatValue, tTimerDetectSpeedrunners, target, TIMER_REPEAT);
							}
						}
					}
					if (bIsHumanSurvivor(target) && log)
					{
						bHasTranslationFile() ? PrintHintText(target, "%s %t", ASS_PREFIX, "CheckInform") : PrintHintText(target, "%s You are being checked!", ASS_PREFIX);
					}
					for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
					{
						if (bIsHumanSurvivor(iPlayer) && log)
						{
							bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "CheckAnnounce", target) : PrintToChat(iPlayer, "%s %N is being checked!", ASS_PREFIX01, target);
						}
					}
				}
			}
		}
	}
	if (g_cvASSLogCommands.BoolValue && log)
	{
		LogAction(client, target, "%s \"%L\" used \"ass_check\" on \"%L\".", ASS_PREFIX, client, target);
	}
}

void vKillCheckTimer(int client)
{
	g_bCheck[client] = false;
	if (g_hCheckTimers[client] != null)
	{
		KillTimer(g_hCheckTimers[client]);
		g_hCheckTimers[client] = null;
	}
}

void vNullSpeedrunners(int target, int client, int toggle, bool log = true)
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
				vNullStats(target, false);
				if (bIsHumanSurvivor(target))
				{
					bHasTranslationFile() ? PrintToChat(target, "%s %t", ASS_PREFIX01, "AdminNotImmune", target) : PrintToChat(target, "%s %N is not immune anymore.", ASS_PREFIX01, target);
				}
				for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
				{
					if (bIsHumanSurvivor(iPlayer) && bIsAdminAllowed(iPlayer) && target != iPlayer)
					{
						bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "AdminNotImmune", target) : PrintToChat(iPlayer, "%s %N is not immune anymore.", ASS_PREFIX01, target);
					}
				}
			}
			case 1:
			{
				vNullStats(target, true);
				if (bIsHumanSurvivor(target))
				{
					bHasTranslationFile() ? PrintToChat(target, "%s %t", ASS_PREFIX01, "AdminImmune", target) : PrintToChat(target, "%s %N is immune.", ASS_PREFIX01, target);
				}
				for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
				{
					if (bIsHumanSurvivor(iPlayer) && bIsAdminAllowed(iPlayer) && target != iPlayer)
					{
						bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "AdminImmune", target) : PrintToChat(iPlayer, "%s %N is immune.", ASS_PREFIX01, target);
					}
				}
			}
		}
		if (g_cvASSLogCommands.BoolValue && log)
		{
			LogAction(client, target, "%s \"%L\" used \"ass_null\" on \"%L\".", ASS_PREFIX, client, target);
		}
	}
}

void vNullStats(int client, bool immunity)
{
	g_bNull[client] = immunity;
	g_iStrikeCount[client] = 0;
	vResetStats(client);
}

void vStrikeSpeedrunners(int target, int client, bool log = true, int amount = 0)
{
	if (bIsInfected(target))
	{
		return;
	}
	if ((bIsSurvivor(target) && g_cvASSCountBots.BoolValue) || (bIsHumanSurvivor(target) && !g_cvASSCountBots.BoolValue))
	{
		if (amount > 0)
		{
			if (amount > g_cvASSStrikeStrikeLimit.IntValue)
			{
				amount = g_cvASSStrikeStrikeLimit.IntValue;
			}
			if (g_cvASSStrikeStrikeMode.BoolValue)
			{
				g_iStrikeCount[target] = amount;
				if (bIsHumanSurvivor(target))
				{
					bHasTranslationFile() ? PrintHintText(target, "%s %t", ASS_PREFIX, "StrikeInform", g_iStrikeCount[target], g_cvASSStrikeStrikeLimit.IntValue) : PrintHintText(target, "%s You were given %d/%d strikes. Stay with your teammates!", ASS_PREFIX, g_iStrikeCount[target], g_cvASSStrikeStrikeLimit.IntValue);
				}
				for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
				{
					if (bIsHumanSurvivor(iPlayer))
					{
						bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "StrikeAnnounce", target, g_iStrikeCount[target], g_cvASSStrikeStrikeLimit.IntValue) : PrintToChat(iPlayer, "%s %N has been given %d/%d strikes!", ASS_PREFIX01, target, g_iStrikeCount[target], g_cvASSStrikeStrikeLimit.IntValue);
					}
				}
			}
			else
			{
				bHasTranslationFile() ? PrintToChat(client, "%s %t", ASS_PREFIX01, "CommandOff") : PrintToChat(client, "%s This command is disabled.", ASS_PREFIX01);
			}
		}
		else
		{
			if (g_bNull[target] || (g_cvASSAdminImmunity.BoolValue && bIsAdminAllowed(target)))
			{
				g_iStrikeCount[target] = 0;
				if (!g_bCheck[target] && !g_bAutoCheck)
				{
					for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
					{
						if (bIsHumanSurvivor(iPlayer) && bIsAdminAllowed(iPlayer))
						{
							bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "AdminImmune", target) : PrintToChat(iPlayer, "%s %N is immune.", ASS_PREFIX01, target);
						}
					}
				}
			}
			else
			{
				if (g_cvASSStrikeStrikeMode.BoolValue && g_iStrikeCount[target] < g_cvASSStrikeStrikeLimit.IntValue)
				{
					g_iStrikeCount[target]++;
					if (bIsHumanSurvivor(target))
					{
						bHasTranslationFile() ? PrintHintText(target, "%s %t", ASS_PREFIX, "StrikeInform", g_iStrikeCount[target], g_cvASSStrikeStrikeLimit.IntValue) : PrintHintText(target, "%s You were given %d/%d strikes. Stay with your teammates!", ASS_PREFIX, g_iStrikeCount[target], g_cvASSStrikeStrikeLimit.IntValue);
					}
					for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
					{
						if (bIsHumanSurvivor(iPlayer))
						{
							bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "StrikeAnnounce", target, g_iStrikeCount[target], g_cvASSStrikeStrikeLimit.IntValue) : PrintToChat(iPlayer, "%s %N has been given %d/%d strikes!", ASS_PREFIX01, target, g_iStrikeCount[target], g_cvASSStrikeStrikeLimit.IntValue);
						}
					}
				}
				else if ((g_cvASSStrikeStrikeMode.BoolValue && g_iStrikeCount[target] >= g_cvASSStrikeStrikeLimit.IntValue) || !g_cvASSStrikeStrikeMode.BoolValue)
				{
					if (g_cvASSStrikeStrikeMode.BoolValue)
					{
						if (bIsHumanSurvivor(target))
						{
							bHasTranslationFile() ? PrintHintText(target, "%s %t", ASS_PREFIX, "Inform", g_iStrikeCount[target], g_cvASSStrikeStrikeLimit.IntValue) : PrintHintText(target, "%s You have %d/%d strikes and will be punished!", ASS_PREFIX, g_iStrikeCount[target], g_cvASSStrikeStrikeLimit.IntValue);
						}
						for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
						{
							if (bIsHumanSurvivor(iPlayer))
							{
								bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "Announce", target, g_iStrikeCount[target], g_cvASSStrikeStrikeLimit.IntValue) : PrintToChat(iPlayer, "%s %N has %d/%d strikes and will be punished!", ASS_PREFIX01, target, g_iStrikeCount[target], g_cvASSStrikeStrikeLimit.IntValue);
							}
						}
					}
					g_cvASSStrikePunishMode.BoolValue ? vStrikeOptions(0, target, client, g_cvASSStrikeSystemOptions) : vStrikeOptions(1, target, client, g_cvASSStrikeSystemOptions);
				}
			}
		}
		if (g_cvASSLogCommands.BoolValue && log)
		{
			LogAction(client, target, "%s \"%L\" used \"ass_strike\" on \"%L\".", ASS_PREFIX, client, target);
		}
	}
}

public void vStrikeDelayCvar(ConVar convar, const char[] oldValue, const char[] newValue)
{
	if (g_cvASSEnable.BoolValue && g_cvASSStrikeEnable.BoolValue)
	{
		for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
		{
			if (((bIsSurvivor(iPlayer) && g_cvASSCountBots.BoolValue) || (bIsHumanSurvivor(iPlayer) && !g_cvASSCountBots.BoolValue)))
			{
				if (!g_cvASSAutoMode.BoolValue)
				{
					if (g_bCheck[iPlayer])
					{
						vKillCheckTimer(iPlayer);
						CreateTimer(1.0, tTimerCheckSpeedrunners, iPlayer);
					}
				}
				else
				{
					CreateTimer(1.0, tTimerAutoCheckSpeedrunners);
				}
			}
		}
	}
}

bool bIsPlayerBad(int client)
{
	return g_iStrikeCount[client] == g_cvASSStrikeStrikeLimit.IntValue;
}

public Action tTimerAutoCheckSpeedrunners(Handle timer)
{
	vAutoCheckSpeedrunners(1);
}

public Action tTimerCheckSpeedrunners(Handle timer, any client)
{
	vCheckSpeedrunners(client, client, 1, false);
}

public Action tTimerAutoDetectSpeedrunners(Handle timer)
{
	if (!g_cvASSEnable.BoolValue || !g_cvASSStrikeEnable.BoolValue || flGetSurvivorCount() < 3 || (!g_cvASSTankAlive.BoolValue && iGetTankCount() > 0) || (g_cvASSNoFinales.BoolValue && bIsFinaleMap()) || !bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSEnabledGameModes, g_cvASSDisabledGameModes))
	{
		return Plugin_Continue;
	}
	float flDistance[MAXPLAYERS + 1];
	float flOtherOrigin[3] = {0.0, 0.0, 0.0};
	float flOverLimit[MAXPLAYERS + 1];
	float flOwnOrigin[3] = {0.0, 0.0, 0.0};
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		if (((bIsHumanSurvivor(iPlayer) && !g_cvASSCountBots.BoolValue) || (bIsSurvivor(iPlayer) && g_cvASSCountBots.BoolValue)))
		{
			GetClientAbsOrigin(iPlayer, flOwnOrigin);
			for (int iDestination = 1; iDestination <= MaxClients; iDestination++)
			{
				if (((bIsHumanSurvivor(iDestination) && !g_cvASSCountBots.BoolValue) || (bIsSurvivor(iDestination) && g_cvASSCountBots.BoolValue)) && iDestination != iPlayer)
				{
					GetClientAbsOrigin(iDestination, flOtherOrigin);
					flDistance[iPlayer] += GetVectorDistance(flOwnOrigin, flOtherOrigin);
					if (GetVectorDistance(flOwnOrigin, flOtherOrigin) > g_cvASSStrikeDistanceLimit.IntValue)
					{
						flOverLimit[iPlayer]++;
					}
				}
			}
		}
		flDistance[iPlayer] = FloatDiv(flDistance[iPlayer], (flGetSurvivorCount() - 1));
		if (!g_bRestart[iPlayer] && (!g_cvASSAdminImmunity.BoolValue || (g_cvASSAdminImmunity.BoolValue && !bIsAdminAllowed(iPlayer))) && bIsAbleSurvivor(iPlayer) && flDistance[iPlayer] > g_cvASSStrikeDistanceWarning.IntValue && flDistance[iPlayer] > g_cvASSStrikeDistanceLimit.IntValue && flOverLimit[iPlayer] > 1)
		{
			vStrikeSpeedrunners(iPlayer, iPlayer, false);
			g_bWarp[iPlayer] = true;
			return Plugin_Continue;
		}
		else if (bIsAbleSurvivor(iPlayer) && flDistance[iPlayer] > g_cvASSStrikeDistanceWarning.IntValue && flDistance[iPlayer] < g_cvASSStrikeDistanceLimit.IntValue)
		{
			vResetStats(iPlayer);
			if (!g_bNull[iPlayer] && (!g_bRestart[iPlayer] || !g_cvASSAdminImmunity.BoolValue || (g_cvASSAdminImmunity.BoolValue && !bIsAdminAllowed(iPlayer))) && bIsAbleHumanSurvivor(iPlayer))
			{
				if (g_cvASSStrikeStrikeMode.BoolValue && g_iStrikeCount[iPlayer] < g_cvASSStrikeStrikeLimit.IntValue)
				{
					bHasTranslationFile() ? PrintHintText(iPlayer, "%s %t", ASS_PREFIX, "StrikeWarn") : PrintHintText(iPlayer, "%s Stay with your teammates or you will be given a strike!", ASS_PREFIX);
				}
				else if (!g_cvASSStrikeStrikeMode.BoolValue || g_iStrikeCount[iPlayer] == g_cvASSStrikeStrikeLimit.IntValue || g_iStrikeCount[iPlayer] > g_cvASSStrikeStrikeLimit.IntValue)
				{
					bHasTranslationFile() ? PrintHintText(iPlayer, "%s %t", ASS_PREFIX, "StrikeWarn2") : PrintHintText(iPlayer, "%s Stay with your teammates or you will be punished!", ASS_PREFIX);
				}
			}
		}
		else if (bIsSurvivor(iPlayer) && flDistance[iPlayer] < g_cvASSStrikeDistanceWarning.IntValue && flDistance[iPlayer] < g_cvASSStrikeDistanceLimit.IntValue)
		{
			vResetStats(iPlayer);
		}
	}
	return Plugin_Continue;
}

public Action tTimerDetectSpeedrunners(Handle timer, any client)
{
	if (!g_cvASSAutoMode.BoolValue && (!IsClientInGame(client) || !IsPlayerAlive(client)))
	{
		vKillCheckTimer(client);
		return Plugin_Handled;
	}
	if (!g_cvASSEnable.BoolValue || !g_cvASSStrikeEnable.BoolValue || flGetSurvivorCount() < 3 || (!g_cvASSTankAlive.BoolValue && iGetTankCount() > 0) || (g_cvASSNoFinales.BoolValue && bIsFinaleMap()) || !bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSEnabledGameModes, g_cvASSDisabledGameModes))
	{
		return Plugin_Continue;
	}
	float flDistance[MAXPLAYERS + 1];
	float flOtherOrigin[3] = {0.0, 0.0, 0.0};
	float flOverLimit[MAXPLAYERS + 1];
	float flOwnOrigin[3] = {0.0, 0.0, 0.0};
	if (((bIsHumanSurvivor(client) && !g_cvASSCountBots.BoolValue) || (bIsSurvivor(client) && g_cvASSCountBots.BoolValue)))
	{
		GetClientAbsOrigin(client, flOwnOrigin);
		for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
		{
			if (((bIsHumanSurvivor(iPlayer) && !g_cvASSCountBots.BoolValue) || (bIsSurvivor(iPlayer) && g_cvASSCountBots.BoolValue)) && iPlayer != client)
			{
				GetClientAbsOrigin(iPlayer, flOtherOrigin);
				flDistance[client] += GetVectorDistance(flOwnOrigin, flOtherOrigin);
				if (GetVectorDistance(flOwnOrigin, flOtherOrigin) > g_cvASSStrikeDistanceLimit.IntValue)
				{
					flOverLimit[client]++;
				}
			}
		}
	}
	flDistance[client] = FloatDiv(flDistance[client], (flGetSurvivorCount() - 1));
	if (!g_bRestart[client] && bIsAbleSurvivor(client) && flDistance[client] > g_cvASSStrikeDistanceWarning.IntValue && flDistance[client] > g_cvASSStrikeDistanceLimit.IntValue && flOverLimit[client] > 1)
	{
		vStrikeSpeedrunners(client, client, false);
		g_bWarp[client] = true;
		return Plugin_Continue;
	}
	else if (bIsAbleSurvivor(client) && flDistance[client] > g_cvASSStrikeDistanceWarning.IntValue && flDistance[client] < g_cvASSStrikeDistanceLimit.IntValue)
	{
		vResetStats(client);
		if (!g_bNull[client] && !g_bRestart[client] && bIsAbleHumanSurvivor(client))
		{
			if (g_cvASSStrikeStrikeMode.BoolValue && g_iStrikeCount[client] < g_cvASSStrikeStrikeLimit.IntValue)
			{
				bHasTranslationFile() ? PrintHintText(client, "%s %t", ASS_PREFIX, "StrikeWarn") : PrintHintText(client, "%s Stay with your teammates or you will be given a strike!", ASS_PREFIX);
			}
			else if (!g_cvASSStrikeStrikeMode.BoolValue || g_iStrikeCount[client] == g_cvASSStrikeStrikeLimit.IntValue || g_iStrikeCount[client] > g_cvASSStrikeStrikeLimit.IntValue)
			{
				bHasTranslationFile() ? PrintHintText(client, "%s %t", ASS_PREFIX, "StrikeWarn2") : PrintHintText(client, "%s Stay with your teammates or you will be punished!", ASS_PREFIX);
			}
		}
	}
	else if (bIsSurvivor(client) && flDistance[client] < g_cvASSStrikeDistanceWarning.IntValue && flDistance[client] < g_cvASSStrikeDistanceLimit.IntValue)
	{
		vResetStats(client);
	}
	return Plugin_Continue;
}

float flGetSurvivorCount()
{
	float flSurvivorCount;
	for (int iSurvivor = 1; iSurvivor <= MaxClients; iSurvivor++)
	{
		if ((bIsHumanSurvivor(iSurvivor) && !g_cvASSCountBots.BoolValue) || (bIsSurvivor(iSurvivor) && g_cvASSCountBots.BoolValue))
		{
			flSurvivorCount++;
		}
	}
	return flSurvivorCount;
}

void vResetStats(int client)
{
	g_bIdle[client] = false;
	g_bRestart[client] = false;
	g_bWarp[client] = false;
	vAcidSpeedrunners(client, client, 0, false);
	vAmmoSpeedrunners(client, client, 0, false);
	vBlindSpeedrunners(client, client, 0, false);
	vChargeSpeedrunners(client, client, 0, false);
	vDisarmSpeedrunners(client, client, 0, false);
	vDrugSpeedrunners(client, client, 0, false);
	vFireSpeedrunners(client, client, 0, false);
	vFreezeSpeedrunners(client, client, 0, false);
	vHurtSpeedrunners(client, client, 0, false);
	vIncapSpeedrunners(client, client, 0, false);
	vInvertSpeedrunners(client, client, 0, false);
	vPukeSpeedrunners(client, client, 0, false);
	vShakeSpeedrunners(client, client, 0, false);
	vShoveSpeedrunners(client, client, 0, false);
	vSlowSpeedrunners(client, client, 0, false);
	vMirrorSpeedrunners(client, client, 0, false);
	vVisionSpeedrunners(client, client, 0, false);
}