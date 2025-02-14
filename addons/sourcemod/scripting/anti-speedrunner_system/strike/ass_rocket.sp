// Rocket Option
int g_iRocket[MAXPLAYERS + 1];
int g_iExplosionSprite = -1;

void vRocketStart()
{
	g_iExplosionSprite = PrecacheModel(SPRITE_FIRE, true);
	PrecacheSound(SOUND_EXPLOSION4, true);
	PrecacheSound(SOUND_LAUNCH, true);
	PrecacheSound(SOUND_ROCKET, true);
}

public Action cmdASSRocket(int client, int args)
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
	if (!g_bPluginEnabled)
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
	float detonation = StringToFloat(arg3);
	char arg2[32];
	GetCmdArg(2, arg2, sizeof(arg2));
	float launch = StringToFloat(arg2);
	if (args < 1)
	{
		if (IsVoteInProgress())
		{
			ReplyToCommand(client, "%s %t", ASS_PREFIX01, "Vote in Progress");
		}
		else
		{
			g_bRocketMenu[client] = true;
			g_bAdminMenu[client] = false;
			vPlayerMenu(client, 0);
		}
		return Plugin_Handled;
	}
	else if (args > 3)
	{
		ReplyToCommand(client, "%s Usage: ass_rocket <#userid|name> <launch delay> <detonation delay>", ASS_PREFIX01);
		return Plugin_Handled;
	}
	char sTarget[32];
	GetCmdArg(1, sTarget, sizeof(sTarget));
	if (!bSelectTarget(sTarget, client, 0, 0, 0, launch, detonation, ""))
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
			vRocketSpeedrunners(target_list[iPlayer], client, true, launch, detonation);
		}
		ShowActivity2(client, ASS_PREFIX2, "Used \"ass_rocket\" on %s.", target_name);
	}
	g_bRocketMenu[client] = true;
	g_bAdminMenu[client] = false;
	return Plugin_Handled;
}

void vRocketSpeedrunners(int target, int client, bool log = true, float launch = 0.0, float detonation = 0.0)
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
			int iFlame = CreateEntityByName("env_steam");
			if (IsValidEntity(iFlame))
			{
				float flPosition[3];
				GetEntPropVector(client, Prop_Send, "m_vecOrigin", flPosition);
				flPosition[2] += 30;
				float flAngles[3];
				flAngles[0] = 90.0;
				flAngles[1] = 0.0;
				flAngles[2] = 0.0;
				DispatchKeyValue(iFlame, "spawnflags", "1");
				DispatchKeyValue(iFlame, "Type", "0");
				DispatchKeyValue(iFlame, "InitialState", "1");
				DispatchKeyValue(iFlame, "Spreadspeed", "10");
				DispatchKeyValue(iFlame, "Speed", "800");
				DispatchKeyValue(iFlame, "Startsize", "10");
				DispatchKeyValue(iFlame, "EndSize", "250");
				DispatchKeyValue(iFlame, "Rate", "15");
				DispatchKeyValue(iFlame, "JetLength", "400");
				SetEntityRenderColor(iFlame, 180, 70, 10, 180);
				TeleportEntity(iFlame, flPosition, flAngles, NULL_VECTOR);
				DispatchSpawn(iFlame);
				SetVariantString("!activator");
				AcceptEntityInput(iFlame, "SetParent", client);
				iFlame = EntIndexToEntRef(iFlame);
				vDeleteEntity(iFlame, 3.0);
				g_iRocket[client] = iFlame;
			}
			EmitSoundToAll(SOUND_ROCKET, target, _, _, _, 0.8);
			launch == 0.0 ? CreateTimer(2.0, tTimerLaunch, GetClientUserId(target)) : CreateTimer(launch, tTimerLaunch, GetClientUserId(target));
			detonation == 0.0 ? CreateTimer(3.5, tTimerDetonate, GetClientUserId(target)) : CreateTimer(detonation, tTimerDetonate, GetClientUserId(target));
			if (bIsHumanSurvivor(target))
			{
				bHasTranslationFile() ? PrintHintText(target, "%s %t", ASS_PREFIX, "RocketInform") : PrintHintText(target, "%s You were sent into space!", ASS_PREFIX);
			}
			for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
			{
				if (bIsHumanSurvivor(iPlayer))
				{
					bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "RocketAnnounce", target) : PrintToChat(iPlayer, "%s %N was sent into space!", ASS_PREFIX01, target);
				}
			}
		}
		if (g_cvASSLogCommands.BoolValue && log)
		{
			LogAction(client, target, "%s \"%L\" used \"ass_rocket\" on \"%L\".", ASS_PREFIX, client, target);
		}
	}
}

public Action tTimerLaunch(Handle timer, any userid)
{
	int client = GetClientOfUserId(userid);
	if (bIsSurvivor(client))
	{
		float flVelocity[3];
		flVelocity[0] = 0.0;
		flVelocity[1] = 0.0;
		flVelocity[2] = 800.0;
		EmitSoundToAll(SOUND_EXPLOSION4, client, _, _, _, 1.0);
		EmitSoundToAll(SOUND_LAUNCH, client, _, _, _, 1.0);
		TeleportEntity(client, NULL_VECTOR, NULL_VECTOR, flVelocity);
		SetEntityGravity(client, 0.1);
	}
	return Plugin_Handled;
}

public Action tTimerDetonate(Handle timer, any userid)
{
	int client = GetClientOfUserId(userid);
	if (bIsSurvivor(client))
	{
		float flPosition[3];
		GetClientAbsOrigin(client, flPosition);
		TE_SetupExplosion(flPosition, g_iExplosionSprite, 10.0, 1, 0, 600, 5000);
		TE_SendToAll();
		g_iRocket[client] = 0;
		ForcePlayerSuicide(client);
		SetEntityGravity(client, 1.0);
	}
	return Plugin_Handled;
}