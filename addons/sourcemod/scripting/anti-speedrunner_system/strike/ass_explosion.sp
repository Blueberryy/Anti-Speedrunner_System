// Explosion Option
void vExplodeStart()
{
	PrecacheSound("ambient/explosions/explode_1.wav", true);
	PrecacheSound("ambient/explosions/explode_2.wav", true);
	PrecacheSound("ambient/explosions/explode_3.wav", true);
	PrecacheSound("animation/van_inside_debris.wav", true);
}

public Action cmdASSExplode(int client, int args)
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
	if (args < 1)
	{
		if (IsVoteInProgress())
		{
			ReplyToCommand(client, "%s %t", ASS_PREFIX01, "Vote in Progress");
		}
		else
		{
			g_bExplodeMenu[client] = true;
			g_bAdminMenu[client] = false;
			vPlayerMenu(client);
		}
		return Plugin_Handled;
	}
	else if (args > 1)
	{
		ReplyToCommand(client, "%s Usage: ass_explode <#userid|name>", ASS_PREFIX01);
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
			vExplodeSpeedrunners(target_list[iPlayer], client);
		}
		ShowActivity2(client, ASS_PREFIX2, "Used \"ass_explode\" on %s.", target_name);
	}
	g_bExplodeMenu[client] = true;
	g_bAdminMenu[client] = false;
	return Plugin_Handled;
}

void vExplodeSpeedrunners(int target, int client, bool log = true)
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
			float flPosition[3];
			GetClientAbsOrigin(target, flPosition);
			vCreateExplosion(flPosition, target);
			if (bIsHumanSurvivor(target))
			{
				bHasTranslationFile() ? PrintHintText(target, "%s %t", ASS_PREFIX, "ExplodeInform") : PrintHintText(target, "%s You were caught in an explosion!", ASS_PREFIX);
			}
			for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
			{
				if (bIsHumanSurvivor(iPlayer))
				{
					bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "ExplodeAnnounce", target) : PrintToChat(iPlayer, "%s %N was caught in an explosion!", ASS_PREFIX01, target);
				}
			}
		}
		if (g_cvASSLogCommands.BoolValue && log)
		{
			LogAction(client, target, "%s \"%L\" used \"ass_explode\" on \"%L\".", ASS_PREFIX, client, target);
		}
	}
}

void vCreateExplosion(float pos[3], int entity)
{
	GetClientAbsOrigin(entity, pos);
	int iParticle = CreateEntityByName("info_particle_system");
	int iParticle2 = CreateEntityByName("info_particle_system");
	int iParticle3 = CreateEntityByName("info_particle_system");
	int iTrace = CreateEntityByName("info_particle_system");
	int iPhysics = CreateEntityByName("env_physexplosion");
	int iHurt = CreateEntityByName("point_hurt");
	int iEntity = CreateEntityByName("env_explosion");
	DispatchKeyValue(iParticle, "effect_name", "FluidExplosion_fps");
	DispatchSpawn(iParticle);
	ActivateEntity(iParticle);
	TeleportEntity(iParticle, pos, NULL_VECTOR, NULL_VECTOR);
	DispatchKeyValue(iParticle2, "effect_name", "weapon_grenade_explosion");
	DispatchSpawn(iParticle2);
	ActivateEntity(iParticle2);
	TeleportEntity(iParticle2, pos, NULL_VECTOR, NULL_VECTOR);
	DispatchKeyValue(iParticle3, "effect_name", "explosion_huge_b");
	DispatchSpawn(iParticle3);
	ActivateEntity(iParticle3);
	TeleportEntity(iParticle3, pos, NULL_VECTOR, NULL_VECTOR);
	DispatchKeyValue(iTrace, "effect_name", "gas_explosion_ground_fire");
	DispatchSpawn(iTrace);
	ActivateEntity(iTrace);
	TeleportEntity(iTrace, pos, NULL_VECTOR, NULL_VECTOR);
	DispatchKeyValue(iEntity, "fireballsprite", "sprites/muzzleflash4.vmt");
	DispatchKeyValue(iEntity, "iMagnitude", "150");
	DispatchKeyValue(iEntity, "iRadiusOverride", "150");
	DispatchKeyValue(iEntity, "spawnflags", "828");
	DispatchSpawn(iEntity);
	TeleportEntity(iEntity, pos, NULL_VECTOR, NULL_VECTOR);
	DispatchKeyValue(iPhysics, "radius", "150");
	DispatchKeyValue(iPhysics, "magnitude", "150");
	DispatchSpawn(iPhysics);
	TeleportEntity(iPhysics, pos, NULL_VECTOR, NULL_VECTOR);
	DispatchKeyValue(iHurt, "DamageRadius", "150");
	DispatchKeyValue(iHurt, "DamageDelay", "0.5");
	DispatchKeyValue(iHurt, "Damage", "5");
	DispatchKeyValue(iHurt, "DamageType", "8");
	DispatchSpawn(iHurt);
	TeleportEntity(iHurt, pos, NULL_VECTOR, NULL_VECTOR);
	switch (GetRandomInt(1, 3))
	{
		case 1: EmitSoundToAll("ambient/explosions/explode_1.wav", entity);
		case 2: EmitSoundToAll("ambient/explosions/explode_2.wav", entity);
		case 3: EmitSoundToAll("ambient/explosions/explode_3.wav", entity);
	}
	EmitSoundToAll("animation/van_inside_debris.wav", entity);
	AcceptEntityInput(iParticle, "Start");
	AcceptEntityInput(iParticle2, "Start");
	AcceptEntityInput(iParticle3, "Start");
	AcceptEntityInput(iTrace, "Start");
	AcceptEntityInput(iEntity, "Explode");
	AcceptEntityInput(iPhysics, "Explode");
	AcceptEntityInput(iHurt, "TurnOn");
	CreateTimer(16.5, tTimerDeleteEntity, iParticle, TIMER_FLAG_NO_MAPCHANGE);
	CreateTimer(16.5, tTimerDeleteEntity, iParticle2, TIMER_FLAG_NO_MAPCHANGE);
	CreateTimer(16.5, tTimerDeleteEntity, iParticle3, TIMER_FLAG_NO_MAPCHANGE);
	CreateTimer(16.5, tTimerDeleteEntity, iTrace, TIMER_FLAG_NO_MAPCHANGE);
	CreateTimer(16.5, tTimerDeleteEntity, iEntity, TIMER_FLAG_NO_MAPCHANGE);
	CreateTimer(16.5, tTimerDeleteEntity, iPhysics, TIMER_FLAG_NO_MAPCHANGE);
	CreateTimer(16.5, tTimerDeleteEntity, iHurt, TIMER_FLAG_NO_MAPCHANGE);
	CreateTimer(15.0, tTimerStopExplosion, iTrace, TIMER_FLAG_NO_MAPCHANGE);
	CreateTimer(15.0, tTimerStopExplosion, iHurt, TIMER_FLAG_NO_MAPCHANGE);
}

public Action tTimerStopExplosion(Handle timer, any entity)
{
	if ((entity = EntRefToEntIndex(entity)) == INVALID_ENT_REFERENCE)
	{
		return Plugin_Stop;
	}
	char sClassname[32];
	GetEntityClassname(entity, sClassname, sizeof(sClassname));
	if (IsValidEntity(entity))
	{
		if (StrEqual(sClassname, "info_particle_system", false))
		{
			AcceptEntityInput(entity, "Stop");
		}
		else if (StrEqual(sClassname, "point_hurt", false))
		{
			AcceptEntityInput(entity, "TurnOff");
		}
	}
	return Plugin_Continue;
}

public Action tTimerDeleteEntity(Handle timer, any entity)
{
	if ((entity = EntRefToEntIndex(entity)) == INVALID_ENT_REFERENCE)
	{
		return Plugin_Stop;
	}
	if (IsValidEntity(entity))
	{
		AcceptEntityInput(entity, "Kill");
	}
	return Plugin_Continue;
}