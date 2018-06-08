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
	g_cvASSLockdownCountdown = ASS_ConVar("asslockdown_countdown", "60", "The starting door's lockdown will end after X second(s).");
	g_cvASSLockdownCountdown2 = ASS_ConVar("asslockdown_countdown2", "60", "The ending door's lockdown will end after X second(s).");
	g_cvASSLockdownDoorType = ASS_ConVar("asslockdown_doortype", "21", "Which type of saferoom door should be affected?\nCombine numbers in any order for different results.\nCharacter limit: 2\n(1: Starting saferoom doors only.)\n(2: Ending saferoom doors only.)");
	g_cvASSLockdownSpawnMobs = ASS_ConVar("asslockdown_spawnmobs", "1", "Spawn mobs of zombies during the lockdown.\n(0: OFF)\n(1: ON)");
	g_iLockdownCountdown = g_cvASSLockdownCountdown.IntValue;
	g_iLockdownCountdown2 = g_cvASSLockdownCountdown2.IntValue;
}

void vLockdownSettings()
{
	if (IsValidEntity(g_iIdGoal))
	{
		g_bLockdownStarted = false;
		g_bLockdownStarts = false;
	}
	if (IsValidEntity(g_iIdGoal2))
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

void vLockdownOption(int client, int entity, int type)
{
	if (bIsSystemValid(g_cvASSGameMode, g_cvASSEnabledGameModes, g_cvASSDisabledGameModes) && bIsSystemValid(g_cvASSGameMode, g_cvASSSaferoomEnabledGameModes, g_cvASSSaferoomDisabledGameModes))
	{
		switch (type)
		{
			case 0:
			{
				if (!g_bLockdownStarts)
				{
					g_bLockdownStarts = true;
					CreateTimer(1.0, tTimerSpawnMob, GetEngineTime() + g_cvASSLockdownCountdown.IntValue, TIMER_FLAG_NO_MAPCHANGE|TIMER_REPEAT);
					if (g_hLockdownTimer == null)
					{
						g_hLockdownTimer = CreateTimer(1.0, tTimerLockdownStarts, entity, TIMER_REPEAT);
					}
					CreateTimer(g_cvASSLockdownCountdown.FloatValue + 1.0, tTimerLockdownEnds, entity, TIMER_FLAG_NO_MAPCHANGE);
				}
			}
			case 1:
			{
				if (!g_bLockdownStarts2)
				{
					g_bLockdownStarts2 = true;
					CreateTimer(1.0, tTimerSpawnMob, GetEngineTime() + g_cvASSLockdownCountdown2.IntValue, TIMER_FLAG_NO_MAPCHANGE|TIMER_REPEAT);
					if (g_hLockdownTimer2 == null)
					{
						g_hLockdownTimer2 = CreateTimer(1.0, tTimerLockdownStarts2, entity, TIMER_REPEAT);
					}
					CreateTimer(g_cvASSLockdownCountdown2.FloatValue + 1.0, tTimerLockdownEnds2, entity);
				}
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
	EmitSoundToAll("ambient/alarms/klaxon1.wav", entity);
	g_iLockdownCountdown--;
	vLockdownCountdown(g_iLockdownCountdown);
	return Plugin_Continue;
}

public Action tTimerLockdownStarts2(Handle timer, any entity)
{
	EmitSoundToAll("ambient/alarms/klaxon1.wav", entity);
	g_iLockdownCountdown2--;
	vLockdownCountdown(g_iLockdownCountdown2);
	return Plugin_Continue;
}

public Action tTimerLockdownEnds(Handle timer, any entity)
{
	if (g_hLockdownTimer != null)
	{
		EmitSoundToAll("doors/door_squeek1.wav", entity);
		vSDoorControl(entity, false);
		vLockdownEnds();
		g_iLockdownCountdown = g_cvASSLockdownCountdown.IntValue;
		KillTimer(g_hLockdownTimer);
		g_hLockdownTimer = null;
	}
}

public Action tTimerLockdownEnds2(Handle timer, any entity)
{
	if (g_hLockdownTimer2 != null)
	{
		vEntryMode(entity);
		vLockdownEnds();
		g_iLockdownCountdown2 = g_cvASSLockdownCountdown2.IntValue;
		KillTimer(g_hLockdownTimer2);
		g_hLockdownTimer2 = null;
	}
}