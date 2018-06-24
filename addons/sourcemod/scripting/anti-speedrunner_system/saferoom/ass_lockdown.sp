// Lockdown Option
bool g_bLockdownStarted;
bool g_bLockdownStarted2;
bool g_bLockdownStarts;
bool g_bLockdownStarts2;
ConVar g_cvASSLockdownCountdown;
ConVar g_cvASSLockdownCountdown2;
ConVar g_cvASSLockdownSpawnMobs;
Handle g_hLockdownTimer;
Handle g_hLockdownTimer2;
int g_iLockdownCountdown;
int g_iLockdownCountdown2;

void vLockdownCvars()
{
	vCreateConVar(g_cvASSLockdownCountdown, "asslockdown_countdown", "60", "The starting door's lockdown will end after X second(s).", _, true, 1.0, true, 99999.0);
	vCreateConVar(g_cvASSLockdownCountdown2, "asslockdown_countdown2", "60", "The ending door's lockdown will end after X second(s).", _, true, 1.0, true, 99999.0);
	vCreateConVar(g_cvASSLockdownDoorType, "asslockdown_doortype", "21", "Which type of saferoom door should be affected?\nCombine numbers in any order for different results.\nCharacter limit: 2\n(1: Starting saferoom doors only.)\n(2: Ending saferoom doors only.)");
	vCreateConVar(g_cvASSLockdownSpawnMobs, "asslockdown_spawnmobs", "1", "Spawn mobs of zombies during the lockdown.\n(0: OFF)\n(1: ON)", _, true, 0.0, true, 1.0);
	g_iLockdownCountdown = g_cvASSLockdownCountdown.IntValue;
	g_iLockdownCountdown2 = g_cvASSLockdownCountdown2.IntValue;
}

void vLockdownSettings()
{
	if (IsValidEntity(g_iDoorId))
	{
		g_bLockdownStarted = false;
		g_bLockdownStarts = false;
	}
	if (IsValidEntity(g_iDoorId2))
	{
		g_bLockdownStarted2 = false;
		g_bLockdownStarts2 = false;
	}
	g_bLockdownVoteMenu = false;
	g_bBFGKLVoteMenu = false;
	if (g_hLockdownTimer != null)
	{
		KillTimer(g_hLockdownTimer);
		g_hLockdownTimer = null;
	}
	if (g_hLockdownTimer2 != null)
	{
		KillTimer(g_hLockdownTimer2);
		g_hLockdownTimer2 = null;
	}
	g_iLockdownCountdown = g_cvASSLockdownCountdown.IntValue;
	g_iLockdownCountdown2 = g_cvASSLockdownCountdown2.IntValue;
}

void vLockdownOption(int client, int entity, bool type)
{
	if (bIsSystemValid(g_cvASSGameMode, g_cvASSEnabledGameModes, g_cvASSDisabledGameModes, g_cvASSGameModeTypes) && bIsSystemValid(g_cvASSGameMode, g_cvASSSaferoomEnabledGameModes, g_cvASSSaferoomDisabledGameModes, g_cvASSGameModeTypes))
	{
		if (!type)
		{
			if (!g_bLockdownStarts)
			{
				g_bLockdownStarts = true;
				if (g_hLockdownTimer == null)
				{
					g_hLockdownTimer = CreateTimer(1.0, tTimerLockdownStarts, EntIndexToEntRef(entity), TIMER_REPEAT);
				}
				CreateTimer(g_cvASSLockdownCountdown.FloatValue + 1.0, tTimerLockdownEnds, EntIndexToEntRef(entity), TIMER_FLAG_NO_MAPCHANGE);
			}
		}
		else
		{
			if (!g_bLockdownStarts2)
			{
				g_bLockdownStarts2 = true;
				CreateTimer(1.0, tTimerSpawnMob, GetEngineTime() + g_cvASSLockdownCountdown2.IntValue, TIMER_FLAG_NO_MAPCHANGE|TIMER_REPEAT);
				if (g_hLockdownTimer2 == null)
				{
					g_hLockdownTimer2 = CreateTimer(1.0, tTimerLockdownStarts2, EntIndexToEntRef(entity), TIMER_REPEAT);
				}
				CreateTimer(g_cvASSLockdownCountdown2.FloatValue + 1.0, tTimerLockdownEnds2, EntIndexToEntRef(entity), TIMER_FLAG_NO_MAPCHANGE);
			}
		}
		if (g_bLockdownStarts || g_bLockdownStarts2)
		{
			EmitSoundToAll("doors/latchlocked2.wav", entity);
			if (bIsHumanSurvivor(client))
			{
				bHasTranslationFile() ? PrintToChat(client, "%s %t", ASS_PREFIX01, "WaitLockdown") : PrintToChat(client, "%s Wait for the lockdown to end!", ASS_PREFIX01);
			}
		}
	}
}

void vLockdownCountdown(int countdown)
{
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		if (bIsHumanSurvivor(iPlayer))
		{
			bHasTranslationFile() ? PrintHintText(iPlayer, "%s %t", ASS_PREFIX, "LockdownCountdown", countdown) : PrintHintText(iPlayer, "%s Lockdown ends in %d.", ASS_PREFIX, countdown);
		}
	}
}

void vLockdownEnds()
{
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		if (bIsHumanSurvivor(iPlayer))
		{
			bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "LockdownEnds") : PrintToChat(iPlayer, "%s The lockdown has ended and the saferoom door has opened!", ASS_PREFIX01);
		}
	}
}

public Action tTimerSpawnMob(Handle timer, any data)
{
	if (data < GetEngineTime())
	{
		return Plugin_Stop;
	}
	if (!g_cvASSLockdownSpawnMobs.BoolValue)
	{
		return Plugin_Continue;
	}
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		if (bIsValidClient(iPlayer))
		{
			vCheatCommand(iPlayer, (bIsL4D2Game() ? "z_spawn_old" : "z_spawn"), "mob auto");
			break;
		}
	}
	return Plugin_Continue;
}

public Action tTimerLockdownStarts(Handle timer, any entity)
{
	if ((entity = EntRefToEntIndex(entity)) == INVALID_ENT_REFERENCE)
	{
		return Plugin_Stop;
	}
	EmitSoundToAll("ambient/alarms/klaxon1.wav", entity);
	g_iLockdownCountdown--;
	vLockdownCountdown(g_iLockdownCountdown);
	return Plugin_Continue;
}

public Action tTimerLockdownStarts2(Handle timer, any entity)
{
	if ((entity = EntRefToEntIndex(entity)) == INVALID_ENT_REFERENCE)
	{
		return Plugin_Stop;
	}
	EmitSoundToAll("ambient/alarms/klaxon1.wav", entity);
	g_iLockdownCountdown2--;
	vLockdownCountdown(g_iLockdownCountdown2);
	return Plugin_Continue;
}

public Action tTimerLockdownEnds(Handle timer, any entity)
{
	if ((entity = EntRefToEntIndex(entity)) == INVALID_ENT_REFERENCE)
	{
		return Plugin_Stop;
	}
	if (g_hLockdownTimer != null)
	{
		EmitSoundToAll("doors/door_squeek1.wav", entity);
		vSDoorControl(entity, false);
		vLockdownEnds();
		g_iLockdownCountdown = g_cvASSLockdownCountdown.IntValue;
		KillTimer(g_hLockdownTimer);
		g_hLockdownTimer = null;
	}
	return Plugin_Continue;
}

public Action tTimerLockdownEnds2(Handle timer, any entity)
{
	if ((entity = EntRefToEntIndex(entity)) == INVALID_ENT_REFERENCE)
	{
		return Plugin_Stop;
	}
	if (g_hLockdownTimer2 != null)
	{
		vEntryMode(entity);
		vLockdownEnds();
		g_iLockdownCountdown2 = g_cvASSLockdownCountdown2.IntValue;
		KillTimer(g_hLockdownTimer2);
		g_hLockdownTimer2 = null;
	}
	return Plugin_Continue;
}