// Warp Option
public Action cmdASSWarp(int client, int args)
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
	if (args < 1)
	{
		if (IsVoteInProgress())
		{
			ReplyToCommand(client, "%s %t", ASS_PREFIX01, "Vote in Progress");
		}
		else
		{
			g_bWarpMenu[client] = true;
			g_bAdminMenu[client] = false;
			vPlayerMenu(client);
		}
		return Plugin_Handled;
	}
	else if (args > 1)
	{
		ReplyToCommand(client, "%s Usage: ass_warp <optional - #userid|name>", ASS_PREFIX01);
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
			vWarpSpeedrunners(target_list[iPlayer], client);
		}
		ShowActivity2(client, ASS_PREFIX2, "Used \"ass_warp\" on %s.", target_name);
	}
	g_bWarpMenu[client] = true;
	g_bAdminMenu[client] = false;
	return Plugin_Handled;
}

void vWarpSpeedrunners(int target, int client, bool log = true)
{
	if (bIsInfected(target))
	{
		return;
	}
	if (((bIsSurvivor(target) && g_cvASSCountBots.BoolValue) || (bIsHumanSurvivor(target) && !g_cvASSCountBots.BoolValue)))
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
			float flCurrentOrigin[3] = {0.0, 0.0, 0.0};
			for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
			{
				if (((bIsSurvivor(iPlayer) && g_cvASSCountBots.BoolValue) || (bIsHumanSurvivor(iPlayer) && !g_cvASSCountBots.BoolValue)) && ( !g_cvASSAdminImmunity.BoolValue || (g_cvASSAdminImmunity.BoolValue && !bIsAdminAllowed(iPlayer))) && !g_bRestart[iPlayer] && !g_bWarp[iPlayer] && iPlayer != target)
				{
					GetClientAbsOrigin(iPlayer, flCurrentOrigin);
					TeleportEntity(target, flCurrentOrigin, NULL_VECTOR, NULL_VECTOR);
					break;
				}
				if (bIsHumanSurvivor(iPlayer))
				{
					bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "WarpAnnounce", target) : PrintToChat(iPlayer, "%s %N was warped back to the team!", ASS_PREFIX01, target);
				}
			}
			if (bIsHumanSurvivor(target))
			{
				bHasTranslationFile() ? PrintHintText(target, "%s %t", ASS_PREFIX, "WarpInform") : PrintHintText(target, "%s You were warped back to the team!", ASS_PREFIX);
			}
		}
		if (g_cvASSLogCommands.BoolValue && log)
		{
			LogAction(client, target, "%s \"%L\" used \"ass_warp\" on \"%L\".", ASS_PREFIX, client, target);
		}
	}
}