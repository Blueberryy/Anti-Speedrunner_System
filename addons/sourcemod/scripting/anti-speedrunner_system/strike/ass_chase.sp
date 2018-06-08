// Chase Option
char g_sInfectedName[32];
ConVar g_cvASSChaseInfectedType;

void vChaseCvars()
{
	g_cvASSChaseInfectedType = ASS_ConVar("asschase_infectedtype", "3333111144442222", "Spawn this type of special infected to chase speedrunners.\nCombine numbers in any order for different results.\nRepeat the same number to increase its chance of being chosen.\nCharacter limit: 16\n(1: Hunter)\n(2: Smoker)\n(3: Jockey, switches to Hunter in L4D1.)\n(4: Charger, switches to Smoker in L4D1.)");
}

public Action cmdASSChase(int client, int args)
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
	char arg2[32];
	GetCmdArg(2, arg2, sizeof(arg2));
	int type = StringToInt(arg2);
	if (args < 1)
	{
		if (IsVoteInProgress())
		{
			ReplyToCommand(client, "%s %t", ASS_PREFIX01, "Vote in Progress");
		}
		else
		{
			g_bChaseMenu[client] = true;
			g_bAdminMenu[client] = false;
			vPlayerMenu(client);
		}
		return Plugin_Handled;
	}
	else if (type > 4 || args > 2)
	{
		ReplyToCommand(client, "%s Usage: ass_chase <optional - #userid|name> <optional - 1: hunter|2: smoker|3: jockey|4: charger>", ASS_PREFIX01);
		return Plugin_Handled;
	}
	char sTarget[32];
	GetCmdArg(1, sTarget, sizeof(sTarget));
	if (!bSelectTarget(sTarget, client, 0, type, 0, 0.0, 0.0, ""))
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
			vChaseSpeedrunners(target_list[iPlayer], client, true, type);
		}
		ShowActivity2(client, ASS_PREFIX2, "Used \"ass_chase\" on %s.", target_name);
	}
	g_bChaseMenu[client] = true;
	g_bAdminMenu[client] = false;
	return Plugin_Handled;
}

void vChaseSpeedrunners(int target, int client, bool log = true, int type = 0)
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
			float flHitPosition[3];
			float flPosition[3];
			float flAngle[3];
			float flVector[3];
			GetClientEyePosition(target, flPosition);
			GetClientEyeAngles(target, flAngle);
			flAngle[0] = -25.0;
			GetAngleVectors(flAngle, flAngle, NULL_VECTOR, NULL_VECTOR);
			NormalizeVector(flAngle, flAngle);
			ScaleVector(flAngle, -1.0);
			vCopyVector(flAngle, flVector);
			GetVectorAngles(flAngle, flAngle);
			Handle hTrace = TR_TraceRayFilterEx(flPosition, flAngle, MASK_SOLID, RayType_Infinite, bTraceRayDontHitSelf, target);
			if (TR_DidHit(hTrace))
			{
				TR_GetEndPosition(flHitPosition, hTrace);
				NormalizeVector(flVector, flVector);
				ScaleVector(flVector, -40.0);
				AddVectors(flHitPosition, flVector, flHitPosition);
				if (GetVectorDistance(flHitPosition, flPosition) < 200.0 && GetVectorDistance(flHitPosition, flPosition) > 40.0)
				{
					vSpecialInfectedSpawner(flHitPosition, type);
				}
			}
			delete hTrace;
			if (bIsHumanSurvivor(target))
			{
				bHasTranslationFile() ? PrintHintText(target, "%s %t", ASS_PREFIX, "ChaseInform", g_sInfectedName) : PrintHintText(target, "%s A %s is after you now!", ASS_PREFIX, g_sInfectedName);
			}
			for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
			{
				if (bIsHumanSurvivor(iPlayer))
				{
					bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "ChaseAnnounce", target, g_sInfectedName) : PrintToChat(iPlayer, "%s %N is being chased by a %s!", ASS_PREFIX01, target, g_sInfectedName);
				}
			}
		}
		if (g_cvASSLogCommands.BoolValue && log)
		{
			LogAction(client, target, "%s \"%L\" used \"ass_chase\" on \"%L\".", ASS_PREFIX, client, target);
		}
	}
}

void vSpecialInfectedSpawner(float pos[3], int type)
{
	bool bIsPlayerSI[MAXPLAYERS + 1];
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		bIsPlayerSI[iPlayer] = false;
		if (bIsInfected(iPlayer))
		{
			bIsPlayerSI[iPlayer] = true;
		}
	}
	if (type > 0)
	{
		switch (type)
		{
			case 1: g_sInfectedName = "hunter";
			case 2: g_sInfectedName = "smoker";
			case 3: g_sInfectedName = (bIsL4D2Game() ? "jockey" : "hunter");
			case 4: g_sInfectedName = (bIsL4D2Game() ? "charger" : "smoker");
			default: g_sInfectedName = "hunter";
		}
	}
	else
	{
		char sInfectedType[17];
		g_cvASSChaseInfectedType.GetString(sInfectedType, sizeof(sInfectedType));
		char sLetters = sInfectedType[GetRandomInt(0, strlen(sInfectedType))];
		switch (sLetters)
		{
			case '1': g_sInfectedName = "hunter";
			case '2': g_sInfectedName = "smoker";
			case '3': g_sInfectedName = (bIsL4D2Game() ? "jockey" : "hunter");
			case '4': g_sInfectedName = (bIsL4D2Game() ? "charger" : "smoker");
			default: g_sInfectedName = "hunter";
		}
	}
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		if (bIsValidClient(iPlayer))
		{
			vCheatCommand(iPlayer, (bIsL4D2Game() ? "z_spawn_old" : "z_spawn"), g_sInfectedName);
			break;
		}
	}
	int iSelectedType = 0;
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		if (bIsInfected(iPlayer))
		{
			if (!bIsPlayerSI[iPlayer])
			{
				iSelectedType = iPlayer;
				break;
			}
		}
	}
	if (iSelectedType > 0)
	{
		TeleportEntity(iSelectedType, pos, NULL_VECTOR, NULL_VECTOR);
	}
}