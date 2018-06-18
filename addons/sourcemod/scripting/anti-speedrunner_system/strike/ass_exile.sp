// Exile Option
ConVar g_cvASSExileMode;
ConVar g_cvASSExileBanDuration;

void vExileCvars()
{
	vCreateConVar(g_cvASSExileBanDuration, "assexile_banduration", "60", "Ban speedrunners for X minute(s).\n(0: Permanent ban.)\n(X: Ban for this many minutes.)", _, true, 0.0, true, 99999.0);
	vCreateConVar(g_cvASSExileMode, "assexile_exilemode", "0", "Kick or ban speedrunners?\n(0: Kick)\n(1: Ban)", _, true, 0.0, true, 1.0);
}

public Action cmdASSExile(int client, int args)
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
	char arg3[32];
	GetCmdArg(3, arg3, sizeof(arg3));
	int duration = StringToInt(arg3);
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
			g_bExileMenu[client] = true;
			g_bAdminMenu[client] = false;
			vExileModeMenu(client);
		}
		return Plugin_Handled;
	}
	else if (toggle > 1 || args > 3)
	{
		ReplyToCommand(client, "%s Usage: ass_exile <#userid|name> <0: kick|1: ban> <duration >= 1>", ASS_PREFIX01);
		return Plugin_Handled;
	}
	char sTarget[32];
	GetCmdArg(1, sTarget, sizeof(sTarget));
	if (!bSelectTarget(sTarget, client, toggle, duration, 0, 0.0, 0.0, ""))
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
			vExileSpeedrunners(target_list[iPlayer], client, toggle, true, duration);
		}
		ShowActivity2(client, ASS_PREFIX2, "Used \"ass_exile\" on %s.", target_name);
	}
	g_bExileMenu[client] = true;
	g_bAdminMenu[client] = false;
	return Plugin_Handled;
}

void vExileSpeedrunners(int target, int client, int toggle = 0, bool log = true, int duration = 0)
{
	if (bIsInfected(target))
	{
		return;
	}
	if ((bIsSurvivor(target) && g_cvASSCountBots.BoolValue) || (bIsHumanSurvivor(target) && !g_cvASSCountBots.BoolValue))
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
			switch (toggle)
			{
				case 0:
				{
					KickClient(target, "You have been kicked for passing the distance limit many times");
					for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
					{
						if (bIsHumanSurvivor(iPlayer))
						{
							bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "KickAnnounce", target) : PrintToChat(iPlayer, "%s %N was kicked off the server!", ASS_PREFIX01, target);
						}
					}
				}
				case 1:
				{
					duration > 0 ? BanClient(target, duration, BANFLAG_AUTO, "Banned for passing the distance limit many times.", "You have been banned for passing the distance limit many times", "", target) : BanClient(target, g_cvASSExileBanDuration.IntValue, BANFLAG_AUTO, "Banned for passing the distance limit many times.", "You have been banned for passing the distance limit many times", "", target);
					for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
					{
						if (bIsHumanSurvivor(iPlayer))
						{
							bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "BanAnnounce", target, g_cvASSExileBanDuration.IntValue) : PrintToChat(iPlayer, "%s %N was banned for %d minutes!", ASS_PREFIX01, target, g_cvASSExileBanDuration.IntValue);
						}
					}
				}
			}
		}
		if (g_cvASSLogCommands.BoolValue && log)
		{
			LogAction(client, target, "%s \"%L\" used \"ass_exile\" on \"%L\".", ASS_PREFIX, client, target);
		}
	}
}