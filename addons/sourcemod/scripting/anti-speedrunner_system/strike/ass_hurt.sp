// Hurt Option
ConVar g_cvASSHurtDamageAmount;
Handle g_hHurtTimers[MAXPLAYERS + 1];
int g_iDamage[MAXPLAYERS + 1];

void vHurtCvars()
{
	vCreateConVar(g_cvASSHurtDamageAmount, "asshurt_damageamount", "1", "Hurt speedrunners by this much every second.", _, true, 1.0, true, 99999.0);
}

public Action cmdASSHurt(int client, int args)
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
	char arg4[32];
	GetCmdArg(4, arg4, sizeof(arg4));
	int timer = StringToInt(arg4);
	char arg3[32];
	GetCmdArg(3, arg3, sizeof(arg3));
	int damage = StringToInt(arg3);
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
			g_bHurtMenu[client] = true;
			g_bAdminMenu[client] = false;
			vPlayerMenu(client);
		}
		return Plugin_Handled;
	}
	else if (timer > 1 || toggle > 1 || args > 4)
	{
		ReplyToCommand(client, "%s Usage: ass_hurt <#userid|name> <0: off|1: on> <damage >= 0> <0: once|1: repeat>", ASS_PREFIX01);
		return Plugin_Handled;
	}
	char sTarget[32];
	GetCmdArg(1, sTarget, sizeof(sTarget));
	if (!bSelectTarget(sTarget, client, toggle, damage, timer, 0.0, 0.0, ""))
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
			vHurtSpeedrunners(target_list[iPlayer], client, toggle, true, damage, timer);
		}
		ShowActivity2(client, ASS_PREFIX2, "Used \"ass_hurt\" on %s.", target_name);
	}
	g_bHurtMenu[client] = true;
	g_bAdminMenu[client] = false;
	return Plugin_Handled;
}

void vHurtSpeedrunners(int target, int client, int toggle, bool log = true, int damage = 0, int timer = 0)
{
	damage == 0 ? (g_iDamage[target] = g_cvASSHurtDamageAmount.IntValue) : (g_iDamage[target] = damage);
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
				vKillHurtTimer(target);
				if (bIsHumanSurvivor(target) && log)
				{
					bHasTranslationFile() ? PrintHintText(target, "%s %t", ASS_PREFIX, "HurtNoInform") : PrintHintText(target, "%s You are not losing health anymore!", ASS_PREFIX);
				}
				for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
				{
					if (bIsHumanSurvivor(iPlayer) && log)
					{
						bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "HurtNoAnnounce", target) : PrintToChat(iPlayer, "%s %N is not losing health anymore!", ASS_PREFIX01, target);
					}
				}
			}
			case 1:
			{
				if (g_bNull[target] || (g_cvASSAdminImmunity.BoolValue && bIsAdminAllowed(target)))
				{
					vKillHurtTimer(target);
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
						damage == 0 ? SlapPlayer(client, g_cvASSHurtDamageAmount.IntValue, true) : SlapPlayer(client, damage, true);
					}
					else
					{
						if (!g_bHurt[target])
						{
							g_bHurt[target] = true;
							if (g_hHurtTimers[target] == null)
							{
								g_hHurtTimers[target] = CreateTimer(1.0, tTimerHurtSpeedrunners, target, TIMER_REPEAT);
							}
						}
					}
					if (bIsHumanSurvivor(target) && log)
					{
						bHasTranslationFile() ? PrintHintText(target, "%s %t", ASS_PREFIX, "HurtInform") : PrintHintText(target, "%s You are losing health!", ASS_PREFIX);
					}
					for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
					{
						if (bIsHumanSurvivor(iPlayer) && log)
						{
							bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "HurtAnnounce", target) : PrintToChat(iPlayer, "%s %N is losing health!", ASS_PREFIX01, target);
						}
					}
				}
			}
		}
		if (g_cvASSLogCommands.BoolValue && log)
		{
			LogAction(client, target, "%s \"%L\" used \"ass_hurt\" on \"%L\".", ASS_PREFIX, client, target);
		}
	}
}

void vKillHurtTimer(int client)
{
	g_bHurt[client] = false;
	if (g_hHurtTimers[client] != null)
	{
		KillTimer(g_hHurtTimers[client]);
		g_hHurtTimers[client] = null;
	}
}

public Action tTimerHurtSpeedrunners(Handle timer, any client)
{
	if (!IsClientInGame(client) || !IsPlayerAlive(client) || bIsPlayerIncapacitated(client))
	{
		vKillHurtTimer(client);
		return Plugin_Handled;
	}
	SlapPlayer(client, g_iDamage[client], true);
	return Plugin_Continue;
}
