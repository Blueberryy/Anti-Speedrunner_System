// Group Option
bool g_bGroupStarted;
ConVar g_cvASSGroupDistance;
ConVar g_cvASSGroupSurvivorCount;
float g_flPlayerAloneStartTime[MAXPLAYERS + 1];
float g_flPlayerSpawnTime[MAXPLAYERS + 1];
float g_flPlayerSpawnInterval[MAXPLAYERS + 1];
int g_iClosestGroup[MAXPLAYERS + 1];
int g_iPlayerIndex = 0;
int g_iSurvivorBotCount = 0;
int g_iSurvivorHumanCount = 0;

void vGroupCvars()
{
	vCreateConVar(g_cvASSGroupDistance, "assgroup_groupdistance", "500.0", "Nearby survivors must be this close to ending saferoom doors.", _, true, 1.0, true, 99999.0);
	vCreateConVar(g_cvASSGroupSurvivorCount, "assgroup_survivorcount", "3", "Amount of nearby survivors needed to operate ending saferom doors.", _, true, 1.0, true, 66.0);
}

void vGroupStart()
{
	vResetGroupCounts();
	CreateTimer(0.1, tTimerGroupUpdate, _, TIMER_FLAG_NO_MAPCHANGE|TIMER_REPEAT);
}

void vGroupSettings()
{
	g_bGroupStarted = false;
	g_bBFGKLVoteMenu = false;
}

void vGroupOption(int client, int entity)
{
	if (bIsSystemValid(g_cvASSGameMode, g_cvASSEnabledGameModes, g_cvASSDisabledGameModes, g_cvASSGameModeTypes) && bIsSystemValid(g_cvASSGameMode, g_cvASSSaferoomEnabledGameModes, g_cvASSSaferoomDisabledGameModes, g_cvASSGameModeTypes))
	{
		int iGroup = g_iClosestGroup[client];
		int iGroupCount = g_cvASSGroupSurvivorCount.IntValue;
		int iSurvivorCount;
		g_cvASSCountBots.BoolValue ? (iSurvivorCount = g_iSurvivorBotCount + g_iSurvivorHumanCount) : (iSurvivorCount = g_iSurvivorHumanCount);
		if (iGroupCount > iSurvivorCount)
		{
			iGroupCount = iSurvivorCount;
		}
		if (iGroup < iGroupCount)
		{
			EmitSoundToAll("doors/latchlocked2.wav", entity);
			if (bIsHumanSurvivor(client))
			{
				bHasTranslationFile() ? PrintToChat(client, "%s %t", ASS_PREFIX01, "GroupRequired", iGroupCount) : PrintToChat(client, "%s We need at least %d nearby survivors to operate the saferoom door!", ASS_PREFIX01, iGroupCount);
			}
		}
		else
		{
			vEntryMode(entity);
			for (int iToucher = 1; iToucher <= MaxClients; iToucher++)
			{
				if (bIsHumanSurvivor(iToucher))
				{
					bHasTranslationFile() ? PrintToChat(iToucher, "%s %t", ASS_PREFIX01, "GroupEnough") : PrintToChat(iToucher, "%s The power of friendship opened the saferoom door!", ASS_PREFIX01);
				}
			}
		}
	}
}

void vResetGroupCounts()
{
	g_iPlayerIndex = 0;
	g_iSurvivorHumanCount = 0;
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		g_flPlayerAloneStartTime[iPlayer] = GetEngineTime();
		g_flPlayerSpawnInterval[iPlayer] = 0.0;
		g_flPlayerSpawnTime[iPlayer] = GetEngineTime();
		g_iClosestGroup[iPlayer] = 1;
	}
}

bool bIsNotConsole()
{
	bool bFind = false;
	for (int iPlayer = g_iPlayerIndex + 1; iPlayer <= MaxClients; iPlayer++)
	{
		if (bIsSurvivor(iPlayer))
		{
			bFind = true;
			g_iPlayerIndex = iPlayer;
			break;
		}
	}
	if (!bFind)
	{
		g_iPlayerIndex = 0;
	}
	return bFind;
}

public Action tTimerGroupUpdate(Handle timer)
{
	g_cvASSSaferoomSystemOptions.GetString(g_sSaferoomOption, sizeof(g_sSaferoomOption));
	if (!g_cvASSEnable.BoolValue || !g_cvASSSaferoomEnable.BoolValue || StrContains(g_sSaferoomOption, "g", false) == -1 || !bIsNotConsole())
	{
		return Plugin_Continue;
	}
	float flPlayerPos[3];
	float flPos[3];
	GetClientEyePosition(g_iPlayerIndex, flPlayerPos);
	int iPlayerCount = 0;
	int iBotCount = 0;
	int iClosestCount = 1;
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		if (bIsSurvivor(iPlayer))
		{
			bIsBotSurvivor(iPlayer) ? iBotCount++ : iPlayerCount++;
			if (iPlayer == g_iPlayerIndex)
			{
				continue;
			}
			GetClientEyePosition(iPlayer, flPos);				 
			if (GetVectorDistance(flPos, flPlayerPos) <= g_cvASSGroupDistance.IntValue)
			{
				iClosestCount++;
			}
		} 
	}
	g_iClosestGroup[g_iPlayerIndex] = iClosestCount;
	g_iSurvivorBotCount = iBotCount;
	g_iSurvivorHumanCount = iPlayerCount;
	return Plugin_Continue;
}