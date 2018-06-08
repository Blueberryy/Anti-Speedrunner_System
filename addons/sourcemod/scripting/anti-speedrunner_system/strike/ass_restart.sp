// Restart Option
ConVar g_cvASSRestartLoadout;
Handle g_hSDKRespawnPlayer;

void vRestartCvars()
{
	g_cvASSRestartLoadout = ASS_ConVar("assrestart_loadout", "smg,pistol,pain_pills", "What loadout should speedrunners restart with?\nSeparate items with commas.\nItem limit: 5\nValid formats:\n1. \"rifle,smg,pistol,pain_pills,pipe_bomb\"\n2. \"pain_pills,molotov,first_aid_kit,autoshotgun\"\n3. \"hunting_rifle,rifle,smg\"\n4. \"autoshotgun,pistol\"\n5. \"molotov\"");
}

void vRestartSDKCall()
{
	if (bHasGameDataFile())
	{
		g_hGameData = LoadGameConfigFile("anti-speedrunner_system");
		StartPrepSDKCall(SDKCall_Player);
		PrepSDKCall_SetFromConf(g_hGameData, SDKConf_Signature, "RoundRespawn");
		g_hSDKRespawnPlayer = EndPrepSDKCall();
		if (g_hSDKRespawnPlayer == null)
		{
			bHasTranslationFile() ? PrintToServer("%s %t", ASS_PREFIX, "RestartSignature") : PrintToServer("%s Your \"RoundRespawn\" signature is outdated.", ASS_PREFIX);
		}
	}
}

public Action cmdASSRestart(int client, int args)
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
	char loadout[512];
	GetCmdArg(2, loadout, sizeof(loadout));
	if (args < 1)
	{
		if (IsVoteInProgress())
		{
			ReplyToCommand(client, "%s %t", ASS_PREFIX01, "Vote in Progress");
		}
		else
		{
			g_bRestartMenu[client] = true;
			g_bAdminMenu[client] = false;
			vPlayerMenu(client);
		}
		return Plugin_Handled;
	}
	else if (args > 2)
	{
		ReplyToCommand(client, "%s Usage: ass_restart <optional - #userid|name> <optional - item1,item2,item3,item4,item5>", ASS_PREFIX01);
		return Plugin_Handled;
	}
	char sTarget[32];
	GetCmdArg(1, sTarget, sizeof(sTarget));
	if (!bSelectTarget(sTarget, client, 0, 0, 0, 0.0, 0.0, loadout))
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
			vRestartSpeedrunners(target_list[iPlayer], client, true, loadout);
		}
		ShowActivity2(client, ASS_PREFIX2, "Used \"ass_restart\" on %s.", target_name);
	}
	g_bRestartMenu[client] = true;
	g_bAdminMenu[client] = false;
	return Plugin_Handled;
}

void vRestartSpeedrunners(int target, int client, bool log = true, char[] loadout = "")
{
	if (bIsInfected(target))
	{
		return;
	}
	if (((bIsSurvivor(target) && g_cvASSCountBots.BoolValue) || (bIsHumanSurvivor(target) && !g_cvASSCountBots.BoolValue)))
	{
		if (g_bImmune[target] || (g_cvASSAdminImmunity.BoolValue && bIsAdminAllowed(target)))
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
			if (g_bRestartValid)
			{
				g_bRestart[target] = true;
				SDKCall(g_hSDKRespawnPlayer, target);
				char sItems[5][64];
				if (loadout[0] != '\0')
				{
					ExplodeString(loadout, ",", sItems, sizeof(sItems), sizeof(sItems[]));
					for (int iItem = 0; iItem < sizeof(sItems); iItem++)
					{
						if (StrContains(loadout, sItems[iItem], false) != -1 && sItems[iItem][0] != '\0')
						{
							vCheatCommand(target, "give", sItems[iItem]);
						}
					}
				}
				else
				{
					char sLoadout[512];
					g_cvASSRestartLoadout.GetString(sLoadout, sizeof(sLoadout));
					ExplodeString(sLoadout, ",", sItems, sizeof(sItems), sizeof(sItems[]));
					for (int iItem = 0; iItem < sizeof(sItems); iItem++)
					{
						if (StrContains(sLoadout, sItems[iItem], false) != -1 && sItems[iItem][0] != '\0')
						{
							vCheatCommand(target, "give", sItems[iItem]);
						}
					}
				}
				TeleportEntity(target, g_flSpawnPosition, NULL_VECTOR, NULL_VECTOR);
				if (bIsHumanSurvivor(target))
				{
					bHasTranslationFile() ? PrintHintText(target, "%s %t", ASS_PREFIX, "RestartInform") : PrintHintText(target, "%s You restarted in the safe area!", ASS_PREFIX);
				}
				for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
				{
					if (bIsHumanSurvivor(iPlayer))
					{
						bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "RestartAnnounce", target) : PrintToChat(iPlayer, "%s %N restarted in the safe area!", ASS_PREFIX01, target);
					}
				}
			}
			else
			{
				vWarpSpeedrunners(target, client);
			}
		}
		if (g_cvASSLogCommands.BoolValue && log)
		{
			LogAction(client, target, "%s \"%L\" used \"ass_restart\" on \"%L\".", ASS_PREFIX, client, target);
		}
	}
}