// Drug Option
float g_flDrugAngles[20] = {0.0, 5.0, 10.0, 15.0, 20.0, 25.0, 20.0, 15.0, 10.0, 5.0, 0.0, -5.0, -10.0, -15.0, -20.0, -25.0, -20.0, -15.0, -10.0, -5.0};
Handle g_hDrugTimers[MAXPLAYERS + 1];

public Action cmdASSDrug(int client, int args)
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
			g_bDrugMenu[client] = true;
			g_bAdminMenu[client] = false;
			vPlayerMenu(client);
		}
		return Plugin_Handled;
	}
	else if (toggle > 1 || args > 2)
	{
		ReplyToCommand(client, "%s Usage: ass_drug <#userid|name> <0: off|1: on>", ASS_PREFIX01);
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
			vDrugSpeedrunners(target_list[iPlayer], client, toggle);
		}
		ShowActivity2(client, ASS_PREFIX2, "Used \"ass_drug\" on %s.", target_name);
	}
	g_bDrugMenu[client] = true;
	g_bAdminMenu[client] = false;
	return Plugin_Handled;
}

void vDrugSpeedrunners(int target, int client, int toggle, bool log = true)
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
				vKillDrugTimer(target);
				if (bIsHumanSurvivor(target) && log)
				{
					bHasTranslationFile() ? PrintHintText(target, "%s %t", ASS_PREFIX, "DrugNoInform") : PrintHintText(target, "%s You are not drugged anymore!", ASS_PREFIX);
				}
				for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
				{
					if (bIsHumanSurvivor(iPlayer) && log)
					{
						bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "DrugNoAnnounce", target) : PrintToChat(iPlayer, "%s %N is not drugged anymore!", ASS_PREFIX01, target);
					}
				}
			}
			case 1:
			{
				if (g_bNull[target] || (g_cvASSAdminImmunity.BoolValue && bIsAdminAllowed(target)))
				{
					vKillDrugTimer(target);
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
					if (!g_bDrug[target])
					{
						g_bDrug[target] = true;
						if (g_hDrugTimers[target] == null)
						{
							g_hDrugTimers[target] = CreateTimer(1.0, tTimerDrugSpeedrunners, GetClientUserId(target), TIMER_REPEAT);
						}
						if (bIsHumanSurvivor(target))
						{
							bHasTranslationFile() ? PrintHintText(target, "%s %t", ASS_PREFIX, "DrugInform") : PrintHintText(target, "%s You are drugged!", ASS_PREFIX);
						}
						for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
						{
							if (bIsHumanSurvivor(iPlayer))
							{
								bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "DrugAnnounce", target) : PrintToChat(iPlayer, "%s %N is drugged!", ASS_PREFIX01, target);
							}
						}
					}
				}
			}
		}
		if (g_cvASSLogCommands.BoolValue && log)
		{
			LogAction(client, target, "%s \"%L\" used \"ass_drug\" on \"%L\".", ASS_PREFIX, client, target);
		}
	}
}

void vKillDrugTimer(int client)
{
	g_bDrug[client] = false;
	if (g_hDrugTimers[client] != null)
	{
		KillTimer(g_hDrugTimers[client]);
		g_hDrugTimers[client] = null;
	}
	if ((bIsSurvivor(client) && g_cvASSCountBots.BoolValue) || (bIsHumanSurvivor(client) && !g_cvASSCountBots.BoolValue))
	{
		float flAngles[3];
		GetClientEyeAngles(client, flAngles);
		flAngles[2] = 0.0;
		TeleportEntity(client, NULL_VECTOR, flAngles, NULL_VECTOR);
		int iClients[2];
		iClients[0] = client;
		int iFlags = (0x0001|0x0010);
		int iColor[4] = {0, 0, 0, 0};
		Handle hDrugTarget = StartMessageEx(g_umFadeUserMsgId, iClients, 1);
		if (GetUserMessageType() == UM_Protobuf)
		{
			Protobuf pbSet = UserMessageToProtobuf(hDrugTarget);
			pbSet.SetInt("duration", 1536);
			pbSet.SetInt("hold_time", 1536);
			pbSet.SetInt("flags", iFlags);
			pbSet.SetColor("clr", iColor);
		}
		else
		{
			BfWrite bfWrite = UserMessageToBfWrite(hDrugTarget);
			bfWrite.WriteShort(1536);
			bfWrite.WriteShort(1536);
			bfWrite.WriteShort(iFlags);
			bfWrite.WriteByte(iColor[0]);
			bfWrite.WriteByte(iColor[1]);
			bfWrite.WriteByte(iColor[2]);
			bfWrite.WriteByte(iColor[3]);
		}
		EndMessage();
	}
}

public Action tTimerDrugSpeedrunners(Handle timer, any userid)
{
	int client = GetClientOfUserId(userid);
	if (!IsClientInGame(client) || !IsPlayerAlive(client) || bIsPlayerIncapacitated(client))
	{
		vKillDrugTimer(client);
		return Plugin_Handled;
	}
	float flAngles[3];
	GetClientEyeAngles(client, flAngles);
	flAngles[2] = g_flDrugAngles[GetRandomInt(0, 100) % 20];
	TeleportEntity(client, NULL_VECTOR, flAngles, NULL_VECTOR);
	int iClients[2];
	iClients[0] = client;
	int iFlags = 0x0002;
	int iColor[4] = {0, 0, 0, 128};
	iColor[0] = GetRandomInt(0, 255);
	iColor[1] = GetRandomInt(0, 255);
	iColor[2] = GetRandomInt(0, 255);
	Handle hDrugTarget = StartMessageEx(g_umFadeUserMsgId, iClients, 1);
	if (GetUserMessageType() == UM_Protobuf)
	{
		Protobuf pbSet = UserMessageToProtobuf(hDrugTarget);
		pbSet.SetInt("duration", 255);
		pbSet.SetInt("hold_time", 255);
		pbSet.SetInt("flags", iFlags);
		pbSet.SetColor("clr", iColor);
	}
	else
	{
		BfWrite bfWrite = UserMessageToBfWrite(hDrugTarget);
		bfWrite.WriteShort(255);
		bfWrite.WriteShort(255);
		bfWrite.WriteShort(iFlags);
		bfWrite.WriteByte(iColor[0]);
		bfWrite.WriteByte(iColor[1]);
		bfWrite.WriteByte(iColor[2]);
		bfWrite.WriteByte(iColor[3]);
	}
	EndMessage();
	return Plugin_Handled;
}