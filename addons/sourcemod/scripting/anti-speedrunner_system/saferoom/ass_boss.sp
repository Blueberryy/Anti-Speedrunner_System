// Boss Option
bool g_bBossDefeated;
bool g_bBossSpawned;
bool g_bBossStarted;

void vBossSettings()
{
	g_bBossDefeated = false;
	g_bBossSpawned = false;
	g_bBossStarted = false;
	g_bBFGKLVoteMenu = false;
}

void vBossOption(int client, int entity)
{
	if (bIsSystemValid(g_cvASSGameMode, g_cvASSEnabledGameModes, g_cvASSDisabledGameModes) && bIsSystemValid(g_cvASSGameMode, g_cvASSSaferoomEnabledGameModes, g_cvASSSaferoomDisabledGameModes))
	{
		if (!g_bBossSpawned)
		{
			g_bBossSpawned = true;
			float flHitPosition[3];
			float flPosition[3];
			float flAngle[3];
			float flVector[3];
			GetClientEyePosition(client, flPosition);
			GetClientEyeAngles(client, flAngle);
			flAngle[0] = -25.0;
			GetAngleVectors(flAngle, flAngle, NULL_VECTOR, NULL_VECTOR);
			NormalizeVector(flAngle, flAngle);
			ScaleVector(flAngle, -1.0);
			vCopyVector(flAngle, flVector);
			GetVectorAngles(flAngle, flAngle);
			Handle hTrace = TR_TraceRayFilterEx(flPosition, flAngle, MASK_SOLID, RayType_Infinite, bTraceRayDontHitSelf, client);
			if (TR_DidHit(hTrace))
			{
				TR_GetEndPosition(flHitPosition, hTrace);
				NormalizeVector(flVector, flVector);
				ScaleVector(flVector, -40.0);
				AddVectors(flHitPosition, flVector, flHitPosition);
				if (GetVectorDistance(flHitPosition, flPosition) < 200.0 && GetVectorDistance(flHitPosition, flPosition) > 40.0)
				{
					vBossSpawner(flHitPosition);
				}
			}
			delete hTrace;
		}
		else
		{
			vCountTanks();
			g_iTankCount > 0 ? (g_bBossDefeated = false) : (g_bBossDefeated = true);
		}
		if (!g_bBossDefeated)
		{
			EmitSoundToAll("doors/latchlocked2.wav", entity);
			if (bIsHumanSurvivor(client))
			{
				bHasTranslationFile() ? PrintToChat(client, "%s %t", ASS_PREFIX01, "BossRequired") : PrintToChat(client, "%s We need to defeat the boss!", ASS_PREFIX01);
			}
		}
		else
		{
			vEntryMode(entity);
			for (int iToucher = 1; iToucher <= MaxClients; iToucher++)
			{
				if (bIsHumanSurvivor(iToucher))
				{
					bHasTranslationFile() ? PrintToChat(iToucher, "%s %t", ASS_PREFIX01, "BossDefeated") : PrintToChat(iToucher, "%s The boss has been defeated!", ASS_PREFIX01);
				}
			}
		}
	}
}

void vBossSpawner(float pos[3])
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
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		if (bIsValidClient(iPlayer))
		{
			vCheatCommand(iPlayer, (bIsL4D2Game() ? "z_spawn_old" : "z_spawn"), "tank");
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