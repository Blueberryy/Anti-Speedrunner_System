// Charge Option
Handle g_hChargeTimers[MAXPLAYERS + 1];
Handle g_hSDKChargePlayer;

void vChargeSDKCall()
{
	if (bHasGameDataFile())
	{
		g_hGameData = LoadGameConfigFile("anti-speedrunner_system");
		StartPrepSDKCall(SDKCall_Player);
		PrepSDKCall_SetFromConf(g_hGameData, SDKConf_Signature, "CTerrorPlayer_Fling");
		PrepSDKCall_AddParameter(SDKType_Vector, SDKPass_ByRef);
		PrepSDKCall_AddParameter(SDKType_PlainOldData, SDKPass_Plain);
		PrepSDKCall_AddParameter(SDKType_CBasePlayer, SDKPass_Pointer);
		PrepSDKCall_AddParameter(SDKType_Float, SDKPass_Plain);
		g_hSDKChargePlayer = EndPrepSDKCall();
		if (g_hSDKChargePlayer == null)
		{
			bHasTranslationFile() ? PrintToServer("%s %t", ASS_PREFIX, "ChargeSignature") : PrintToServer("%s Your \"CTerrorPlayer_Fling\" signature is outdated.", ASS_PREFIX);
		}
	}
}

public Action cmdASSCharge(int client, int args)
{
	if (!g_cvASSEnable.BoolValue)
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "ASSOff") : ReplyToCommand(client, "%s The Anti-Speedrunner System is disabled.", ASS_PREFIX01);
		return Plugin_Handled;
	}
	if (!bIsL4D2Game())
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "NotL4D2") : ReplyToCommand(client, "%s Available in Left 4 Dead 2 only.", ASS_PREFIX01);
		return Plugin_Handled;
	}
	if ((g_cvASSAutoMode.BoolValue && !g_cvASSCommandOverride.BoolValue) || !bHasGameDataFile())
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
			g_bChargeMenu[client] = true;
			g_bAdminMenu[client] = false;
			vPlayerMenu(client);
		}
		return Plugin_Handled;
	}
	else if (timer > 1 || toggle > 1 || args > 3)
	{
		ReplyToCommand(client, "%s Usage: ass_charge <#userid|name> <0: off|1: on> <0: once|1: repeat>", ASS_PREFIX01);
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
			vChargeSpeedrunners(target_list[iPlayer], client, toggle, true, timer);
		}
		ShowActivity2(client, ASS_PREFIX2, "Used \"ass_charge\" on %s.", target_name);
	}
	g_bChargeMenu[client] = true;
	g_bAdminMenu[client] = false;
	return Plugin_Handled;
}

void vCharge(int client)
{
	float flTpos[3];
	float flSpos[3];
	float flDistance[3];
	float flRatio[3];
	float flAddVel[3];
	float flTvec[3];
	for (int iSender = 1; iSender <= MaxClients; iSender++)
	{
		if (bIsSurvivor(client) && bIsSurvivor(iSender))
		{
			GetClientAbsOrigin(client, flTpos);
			GetClientAbsOrigin(iSender, flSpos);
			flDistance[0] = (flSpos[0] - flTpos[0]);
			flDistance[1] = (flSpos[1] - flTpos[1]);
			flDistance[2] = (flSpos[2] - flTpos[2]);
			GetEntPropVector(client, Prop_Data, "m_vecVelocity", flTvec);
			flRatio[0] =  FloatDiv(flDistance[0], SquareRoot(flDistance[1] * flDistance[1] + flDistance[0] * flDistance[0]));
			flRatio[1] =  FloatDiv(flDistance[1], SquareRoot(flDistance[1] * flDistance[1] + flDistance[0] * flDistance[0]));
			flAddVel[0] = FloatMul(flRatio[0] * -1, 500.0);
			flAddVel[1] = FloatMul(flRatio[1] * -1, 500.0);
			flAddVel[2] = 500.0;
			SDKCall(g_hSDKChargePlayer, client, flAddVel, 76, iSender, 7.0);
		}
	}
}

void vChargeSpeedrunners(int target, int client, int toggle, bool log = true, int timer = 0)
{
	if (bIsInfected(target) || !bHasGameDataFile() || !bIsL4D2Game())
	{
		return;
	}
	if ((bIsSurvivor(target) && g_cvASSCountBots.BoolValue) || (bIsHumanSurvivor(target) && !g_cvASSCountBots.BoolValue))
	{
		switch (toggle)
		{
			case 0:
			{
				vKillChargeTimer(target);
				if (bIsHumanSurvivor(target) && log)
				{
					bHasTranslationFile() ? PrintHintText(target, "%s %t", ASS_PREFIX, "ChargeNoInform") : PrintHintText(target, "%s You are not being charged at anymore!", ASS_PREFIX);
				}
				for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
				{
					if (bIsHumanSurvivor(iPlayer) && log)
					{
						bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "ChargeNoAnnounce", target) : PrintToChat(iPlayer, "%s %N is not being charged at anymore!", ASS_PREFIX01, target);
					}
				}
			}
			case 1:
			{
				if (g_bNull[target] || (g_cvASSAdminImmunity.BoolValue && bIsAdminAllowed(target)))
				{
					vKillChargeTimer(target);
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
						vCharge(target);
					}
					else
					{
						if (!g_bCharge[target])
						{
							g_bCharge[target] = true;
							if (g_hChargeTimers[target] == null)
							{
								g_hChargeTimers[target] = CreateTimer(5.0, tTimerChargeSpeedrunners, target, TIMER_REPEAT);
							}
						}
					}
					if (bIsHumanSurvivor(target) && log)
					{
						bHasTranslationFile() ? PrintHintText(target, "%s %t", ASS_PREFIX, "ChargeInform") : PrintHintText(target, "%s You are being charged at!", ASS_PREFIX);
					}
					for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
					{
						if (bIsHumanSurvivor(iPlayer) && log)
						{
							bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "ChargeAnnounce", target) : PrintToChat(iPlayer, "%s %N is being charged at!", ASS_PREFIX01, target);
						}
					}
				}
			}
		}
		if (g_cvASSLogCommands.BoolValue && log)
		{
			LogAction(client, target, "%s \"%L\" used \"ass_charge\" on \"%L\".", ASS_PREFIX, client, target);
		}
	}
}

void vKillChargeTimer(int client)
{
	g_bCharge[client] = false;
	if (g_hChargeTimers[client] != null)
	{
		KillTimer(g_hChargeTimers[client]);
		g_hChargeTimers[client] = null;
	}
}

public Action tTimerChargeSpeedrunners(Handle timer, any client)
{
	if (!IsClientInGame(client) || !IsPlayerAlive(client) || bIsPlayerIncapacitated(client))
	{
		vKillChargeTimer(client);
		return Plugin_Handled;
	}
	vCharge(client);
	return Plugin_Continue;
}
