// Fire Option
Handle g_hFireTimers[MAXPLAYERS + 1];

public Action cmdASSFire(int client, int args)
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
			g_bFireMenu[client] = true;
			g_bAdminMenu[client] = false;
			vPlayerMenu(client);
		}
		return Plugin_Handled;
	}
	else if (timer > 1 || toggle > 1 || args > 3)
	{
		ReplyToCommand(client, "%s Usage: ass_fire <#userid|name> <0: off|1: on> <0: once|1: repeat>", ASS_PREFIX01);
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
			vFireSpeedrunners(target_list[iPlayer], client, toggle, true, timer);
		}
		ShowActivity2(client, ASS_PREFIX2, "Used \"ass_fire\" on %s.", target_name);
	}
	g_bFireMenu[client] = true;
	g_bAdminMenu[client] = false;
	return Plugin_Handled;
}

void vFire(int client)
{
	float flPosition[3];
	GetClientAbsOrigin(client, flPosition);
	char sUser[256];
	IntToString(GetClientUserId(client) + 25, sUser, sizeof(sUser));
	vCreateFire(client, "fire_small_01", true, 1.0);
	int iDamage = CreateEntityByName("point_hurt");
	DispatchKeyValue(iDamage, "Damage", "1");
	DispatchKeyValue(iDamage, "DamageType", "8");
	DispatchKeyValue(client, "targetname", sUser);
	DispatchKeyValue(iDamage, "DamageTarget", sUser);
	DispatchSpawn(iDamage);
	TeleportEntity(iDamage, flPosition, NULL_VECTOR, NULL_VECTOR);
	AcceptEntityInput(iDamage, "Hurt");
}

void vCreateFire(int client, char[] particle, bool parent, float duration)
{
	float flPosition[3];
	char sName[64];
	char sTargetName[64];
	int iParticle = CreateEntityByName("info_particle_system");
	GetClientAbsOrigin(client, flPosition);
	TeleportEntity(iParticle, flPosition, NULL_VECTOR, NULL_VECTOR);
	DispatchKeyValue(iParticle, "effect_name", particle);
	if (parent)
	{
		int iTarget = GetClientUserId(client);
		Format(sName, sizeof(sName), "%d", iTarget + 25);
		DispatchKeyValue(client, "targetname", sName);
		GetEntPropString(client, Prop_Data, "m_iName", sName, sizeof(sName));
		Format(sTargetName, sizeof(sTargetName), "%d", iTarget + 1000);
		DispatchKeyValue(iParticle, "targetname", sTargetName);
		DispatchKeyValue(iParticle, "parentname", sName);
	}
	DispatchSpawn(iParticle);
	DispatchSpawn(iParticle);
	if (parent)
	{
		SetVariantString(sName);
		AcceptEntityInput(iParticle, "SetParent", iParticle, iParticle);
	}
	ActivateEntity(iParticle);
	AcceptEntityInput(iParticle, "start");
	CreateTimer(duration, tTimerStopAndRemoveParticle, iParticle, TIMER_FLAG_NO_MAPCHANGE);
}

void vFireSpeedrunners(int target, int client, int toggle, bool log = true, int timer = 0)
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
				vKillFireTimer(target);
				if (bIsHumanSurvivor(target) && log)
				{
					bHasTranslationFile() ? PrintHintText(target, "%s %t", ASS_PREFIX, "FireNoInform") : PrintHintText(target, "%s You are not on fire anymore!", ASS_PREFIX);
				}
				for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
				{
					if (bIsHumanSurvivor(iPlayer) && log)
					{
						bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "FireNoAnnounce", target) : PrintToChat(iPlayer, "%s %N is not on fire anymore!", ASS_PREFIX01, target);
					}
				}
			}
			case 1:
			{
				if (g_bNull[target] || (g_cvASSAdminImmunity.BoolValue && bIsAdminAllowed(target)))
				{
					vKillFireTimer(target);
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
						vFire(target);
					}
					else
					{
						if (!g_bFire[target])
						{
							g_bFire[target] = true;
							if (g_hFireTimers[target] == null)
							{
								g_hFireTimers[target] = CreateTimer(1.0, tTimerFireSpeedrunners, GetClientUserId(target), TIMER_REPEAT);
							}
						}
					}
					if (bIsHumanSurvivor(target) && log)
					{
						bHasTranslationFile() ? PrintHintText(target, "%s %t", ASS_PREFIX, "FireInform") : PrintHintText(target, "%s You are on fire!", ASS_PREFIX);
					}
					for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
					{
						if (bIsHumanSurvivor(iPlayer) && log)
						{
							bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "FireAnnounce", target) : PrintToChat(iPlayer, "%s %N is on fire!", ASS_PREFIX01, target);
						}
					}
				}
			}
		}
		if (g_cvASSLogCommands.BoolValue && log)
		{
			LogAction(client, target, "%s \"%L\" used \"ass_fire\" on \"%L\".", ASS_PREFIX, client, target);
		}
	}
}

void vKillFireTimer(int client)
{
	g_bFire[client] = false;
	if (g_hFireTimers[client] != null)
	{
		KillTimer(g_hFireTimers[client]);
		g_hFireTimers[client] = null;
	}
}

public Action tTimerFireSpeedrunners(Handle timer, any userid)
{
	int client = GetClientOfUserId(userid);
	if (!IsClientInGame(client) || !IsPlayerAlive(client) || bIsPlayerIncapacitated(client))
	{
		vKillFireTimer(client);
		return Plugin_Handled;
	}
	vFire(client);
	return Plugin_Continue;
}

public Action tTimerStopAndRemoveParticle(Handle timer, any entity)
{
	if ((entity = EntRefToEntIndex(entity)) == INVALID_ENT_REFERENCE)
	{
		return Plugin_Stop;
	}
	if (entity > 0 && IsValidEntity(entity))
	{
		AcceptEntityInput(entity, "Kill");
	}
	return Plugin_Continue;
}