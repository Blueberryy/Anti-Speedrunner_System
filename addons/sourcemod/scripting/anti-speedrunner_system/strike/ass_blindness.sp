// Blindness Option
public Action cmdASSBlind(int client, int args)
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
			g_bBlindMenu[client] = true;
			g_bAdminMenu[client] = false;
			vPlayerMenu(client);
		}
		return Plugin_Handled;
	}
	else if (toggle > 1 || args > 2)
	{
		ReplyToCommand(client, "%s Usage: ass_blind <#userid|name> <0: off|1: on>", ASS_PREFIX01);
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
			vBlindSpeedrunners(target_list[iPlayer], client, toggle);
		}
		ShowActivity2(client, ASS_PREFIX2, "Used \"ass_blind\" on %s.", target_name);
	}
	g_bBlindMenu[client] = true;
	g_bAdminMenu[client] = false;
	return Plugin_Handled;
}

void vApplyBlindness(int client, int amount)
{
	if (bIsInfected(client))
	{
		return;
	}
	int iTargets[2];
	iTargets[0] = client;
	int iFlags;
	if ((bIsSurvivor(client) && g_cvASSCountBots.BoolValue) || (bIsHumanSurvivor(client) && !g_cvASSCountBots.BoolValue))
	{
		amount == 0 ? (iFlags = (0x0001|0x0010)) : (iFlags = (0x0002|0x0008));
		int iColor[4] = {0, 0, 0, 0};
		iColor[3] = amount;
		Handle hBlindTarget = StartMessageEx(g_umFadeUserMsgId, iTargets, 1);
		if (GetUserMessageType() == UM_Protobuf)
		{
			Protobuf pbSet = UserMessageToProtobuf(hBlindTarget);
			pbSet.SetInt("duration", 1536);
			pbSet.SetInt("hold_time", 1536);
			pbSet.SetInt("flags", iFlags);
			pbSet.SetColor("clr", iColor);
		}
		else
		{
			BfWrite bfWrite = UserMessageToBfWrite(hBlindTarget);
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

void vBlindSpeedrunners(int target, int client, int toggle, bool log = true)
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
				g_bBlind[target] = false;
				vApplyBlindness(target, 0);
				if (bIsHumanSurvivor(target) && log)
				{
					bHasTranslationFile() ? PrintHintText(target, "%s %t", ASS_PREFIX, "BlindNoInform") : PrintHintText(target, "%s You are not blind anymore!", ASS_PREFIX);
				}
				for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
				{
					if (bIsHumanSurvivor(iPlayer) && log)
					{
						bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "BlindNoAnnounce", target) : PrintToChat(iPlayer, "%s %N is not blind anymore!", ASS_PREFIX01, target);
					}
				}
			}
			case 1:
			{
				if (g_bNull[target] || (g_cvASSAdminImmunity.BoolValue && bIsAdminAllowed(target)))
				{
					g_bBlind[target] = false;
					vApplyBlindness(target, 0);
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
					if (!g_bBlind[target])
					{
						g_bBlind[target] = true;
						vApplyBlindness(target, 255);
						if (bIsHumanSurvivor(target))
						{
							bHasTranslationFile() ? PrintHintText(target, "%s %t", ASS_PREFIX, "BlindInform") : PrintHintText(target, "%s You are blind!", ASS_PREFIX);
						}
						for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
						{
							if (bIsHumanSurvivor(iPlayer))
							{
								bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "BlindAnnounce", target) : PrintToChat(iPlayer, "%s %N is blind!", ASS_PREFIX01, target);
							}
						}
					}
				}
			}
		}
		if (g_cvASSLogCommands.BoolValue && log)
		{
			LogAction(client, target, "%s \"%L\" used \"ass_blind\" on \"%L\".", ASS_PREFIX, client, target);
		}
	}
}
