#if defined _antispeedrunnersystem_included
	#endinput
#endif
#define _antispeedrunnersystem_included
#include <sourcemod>
#include <sdkhooks>
#include <sdktools>
#include <adminmenu>
#define ASS_PREFIX "[ASS]"
#define ASS_PREFIX2 "\x04[ASS]\x01 "
#define ASS_PREFIX01 "\x04[ASS]\x01"
#define ASS_NAME "Anti-Speedrunner System"
#define ASS_AUTHOR "Psyk0tik (Crasher_3637)"
#define ASS_DESCRIPTION "The Anti-Speedrunner System provides various options for dealing with players that speedrun through campaigns and making sure survivors stick together!"
#define ASS_VERSION "29.39"
#define ASS_URL "https://forums.alliedmods.net/showthread.php?t=302868"
#define ASS_LOCK "=="
#define ASS_UNLOCK "!="
#define ASS_APPEND_BAD_FILENAME 0
#define ASS_APPEND_FILE_NOT_FOUND 1
#define ASS_APPEND_BAD_HANDLE 2
#define ASS_APPEND_SUCCESS 3
#define ASS_FIND_BAD_FILENAME 10
#define ASS_FIND_FILE_NOT_FOUND 11
#define ASS_FIND_BAD_HANDLE 12
#define ASS_FIND_NOT_FOUND 13
#define ASS_FIND_SUCCESS 14
#define ASS_CLEAN_FILE_NOT_FOUND 20
#define ASS_CLEAN_BAD_HANDLE 21
#define ASS_CLEAN_SUCCESS 22
#define ASS_NO_CONFIG 30
#define ASS_FORMAT_BAD_FILENAME 40
#define ASS_FORMAT_SUCCESS 41
#define MODEL_DOOR "models/props_doors/checkpoint_door_02.mdl"
#define SPRITE_FIRE "sprites/sprite_fire01.vmt"
#define SPRITE_GLOW "sprites/glow.vmt"
#define SPRITE_GLOW2 "sprites/glow01.vmt"
#define SPRITE_LASERBEAM "sprites/laserbeam.vmt"
#define SOUND_DEBRIS "animation/van_inside_debris.wav"
#define SOUND_DOOR "ambient/alarms/klaxon1.wav"
#define SOUND_ENTRY "buttons/button14.wav"
#define SOUND_EXPLOSION "ambient/explosions/explode_1.wav"
#define SOUND_EXPLOSION2 "ambient/explosions/explode_2.wav"
#define SOUND_EXPLOSION3 "ambient/explosions/explode_3.wav"
#define SOUND_EXPLOSION4 "ambient/explosions/exp2.wav"
#define SOUND_GLASS "physics/glass/glass_impact_bullet4.wav"
#define SOUND_KEYMAN "buttons/blip1.wav"
#define SOUND_LAUNCH "npc/env_headcrabcanister/launch.wav"
#define SOUND_LOCKED "doors/latchlocked2.wav"
#define SOUND_ROCKET "weapons/rpg/rocketfire1.wav"
#define SOUND_SQUEEK "doors/door_squeek1.wav"

// Configs
static bool g_bCreateDirectory;
static bool g_bCreateFile;
static char g_sConfigFile[PLATFORM_MAX_PATH];
static char g_sRawFileName[PLATFORM_MAX_PATH];
static char g_sFolderPath[PLATFORM_MAX_PATH];
static Handle g_hPluginHandle;
static int g_iCreateDirectoryMode;
static int g_iLastFindResult;
static int g_iLastAppendResult;
int g_iCurrentMode;

stock int iASS_GetFindResult()
{
	return g_iLastFindResult;
}

stock int iASS_GetAppendResult()
{
	return g_iLastAppendResult;
}

stock void vASS_CreateConfig(bool create)
{
	g_bCreateFile = create;
}

stock void vASS_CreateDirectory(bool create, int mode = 511)
{
	g_bCreateDirectory = create;
	g_iCreateDirectoryMode = mode;
}

stock bool bASS_GetCreateFile()
{
	return g_bCreateFile;
}

stock void vASS_SetPlugin(Handle plugin)
{
	g_hPluginHandle = plugin;
}

stock Handle hASS_GetPlugin()
{
	return g_hPluginHandle;
}

stock bool bASS_Config(char[] file, char[] folder = "sourcemod/anti-speedrunner_system")
{
	Format(g_sConfigFile, sizeof(g_sConfigFile), "%s", file);
	strcopy(g_sRawFileName, sizeof(g_sRawFileName), file);
	strcopy(g_sFolderPath, sizeof(g_sFolderPath), folder);
	return iASS_FormatConfig(g_sConfigFile, sizeof(g_sConfigFile), folder) == ASS_FORMAT_SUCCESS;
}

stock bool bASS_GetConfig(char[] buffer, int size)
{
	if (strlen(g_sConfigFile) > 0)
	{
		strcopy(buffer, size, g_sConfigFile);
		return true;
	}
	buffer[0] = '\0';
	return false;
}

stock ConVar cvASS_ConVar(const char[] name, const char[] defaultValue, const char[] description = "", int flags = 0, bool hasMin = false, float min = 0.0, bool hasMax = false, float max = 0.0)
{
	if (!(flags & FCVAR_DONTRECORD) && strlen(g_sConfigFile) > 0)
	{
		g_iLastFindResult = -1;
		g_iLastAppendResult = -1;
		char sValue[64];
		g_iLastFindResult = iASS_FindValue(name, sValue, sizeof(sValue), true);
		if (g_iLastFindResult == ASS_FIND_NOT_FOUND || (g_iLastFindResult == ASS_FIND_FILE_NOT_FOUND && g_bCreateFile))
		{
			g_iLastAppendResult = iASS_Append(name, defaultValue, description, flags, hasMin, min, hasMax, max);
		}
	}
	return CreateConVar(name, defaultValue, description, flags, hasMin, min, hasMax, max);
}

stock void vASS_ExecConfig()
{
	AutoExecConfig(!g_bCreateFile, g_sRawFileName, g_sFolderPath);
}

stock static int iASS_FormatConfig(char[] buffer, int size, char[] folder = "sourcemod/anti-speedrunner_system")
{
	if (strlen(g_sConfigFile) < 1)
	{
		return ASS_NO_CONFIG;
	}
	if (StrContains(g_sConfigFile, ".cfg") != -1 && strlen(g_sConfigFile) < 4)
	{
		return ASS_FORMAT_BAD_FILENAME;
	}
	char sPathPrefix[PLATFORM_MAX_PATH];
	if (strlen(folder) > 0)
	{
		Format(sPathPrefix, sizeof(sPathPrefix), "cfg/%s/", folder);
		if (g_bCreateDirectory && !DirExists(sPathPrefix))
		{
			CreateDirectory(sPathPrefix, g_iCreateDirectoryMode);
		}
	}
	else
	{
		Format(sPathPrefix, sizeof(sPathPrefix), "cfg/");
	}
	char sFile[PLATFORM_MAX_PATH];
	sFile[0] = '\0';
	if (StrContains(buffer, sPathPrefix) != 0)
	{
		StrCat(sFile, sizeof(sFile), sPathPrefix);
	}
	StrCat(sFile, sizeof(sFile), g_sConfigFile);
	if (StrContains(sFile[strlen(sFile) - 4], ".cfg") != 0)
	{
		StrCat(sFile, sizeof(sFile), ".cfg");
	}
	strcopy(buffer, size, sFile);
	return ASS_FORMAT_SUCCESS;
}

stock int iASS_Append(const char[] name, const char[] defaultValue, const char[] description, int flags, bool hasMin, float min, bool hasMax, float max)
{
	if (strlen(g_sConfigFile) < 1)
	{
		return ASS_NO_CONFIG;
	}
	char sFile[PLATFORM_MAX_PATH];
	strcopy(sFile, sizeof(sFile), g_sConfigFile);
	bool bFileExists = FileExists(sFile);
	if (g_bCreateFile || bFileExists)
	{
		File fFile = OpenFile(sFile, (bFileExists ? "a" : "w"));
		char sWrite[2048];
		if (fFile == null)
		{
			return ASS_APPEND_BAD_HANDLE;
		}
		if (g_bCreateFile && !bFileExists)
		{
			fFile.WriteLine("// This file was auto-generated by the Anti-Speedrunner System v%s (%s)", ASS_VERSION, ASS_URL);
			GetPluginFilename(g_hPluginHandle, sWrite, sizeof(sWrite));
			Format(sWrite, sizeof(sWrite), "// ConVars for plugin \"%s\"", sWrite);
			fFile.WriteLine(sWrite);
		}
		fFile.WriteLine("\n");
		int iNewLines = iASS_GetCharCountInStr('\n', description);
		if (iNewLines == 0)
		{
			Format(sWrite, sizeof(sWrite), "// %s", description);
			fFile.WriteLine(sWrite);
		}
		else
		{
			char[][] sNewLines = new char[iNewLines + 1][2048];
			ExplodeString(description, "\n", sNewLines, iNewLines + 1, 2048, false);
			for (int iLine; iLine <= iNewLines; iLine++)
			{
				if (strlen(sNewLines[iLine]) > 0)
				{
					fFile.WriteLine("// %s", sNewLines[iLine]);
				}
			}
		}
		fFile.WriteLine("// -");
		Format(sWrite, sizeof(sWrite), "// Default: \"%s\"", defaultValue);
		fFile.WriteLine(sWrite);
		if (hasMin)
		{		
			Format(sWrite, sizeof(sWrite), "// Minimum: \"%f\"", min);
			fFile.WriteLine(sWrite);
		}
		if (hasMax)
		{
			Format(sWrite, sizeof(sWrite), "// Maximum: \"%f\"", max);
			fFile.WriteLine(sWrite);
		}
		Format(sWrite, sizeof(sWrite), "%s \"%s\"", name, defaultValue);
		fFile.WriteLine(sWrite);
		delete fFile;		
		return ASS_APPEND_SUCCESS;
	}
	return ASS_APPEND_FILE_NOT_FOUND;
}

stock int iASS_FindValue(const char[] cvar, char[] value, int size, bool caseSensitive = false)
{
	value[0] = '\0';
	if (strlen(g_sConfigFile) < 1)
	{
		return ASS_NO_CONFIG;
	}
	char sFile[PLATFORM_MAX_PATH];
	strcopy(sFile, sizeof(sFile), g_sConfigFile);
	bool bFileExists = FileExists(sFile);
	if (g_bCreateFile && !bFileExists)
	{
		return ASS_FIND_FILE_NOT_FOUND;
	}
	if (bFileExists)
	{
		File fFile = OpenFile(sFile, "r");
		int iValueStart;
		int iValueEnd;
		int iCvarEnd;
		char sConvar[64];
		char sValue[64];
		char sRead[2048];
		char sCopy[2048];
		if (fFile == null)
		{
			return ASS_FIND_BAD_HANDLE;
		}
		while (!fFile.EndOfFile() && fFile.ReadLine(sRead, sizeof(sRead)))
		{
			if (IsCharSpace(sRead[0]) || sRead[0] == '/' || (!IsCharNumeric(sRead[0]) && !IsCharAlpha(sRead[0])) || iASS_GetCharCountInStr(' ', sRead) < 1 || iASS_GetCharCountInStr('"', sRead) != 2 || (iValueStart = StrContains(sRead, "\"")) == -1 || (iValueEnd = StrContains(sRead[iValueStart+1], "\"")) == -1 || (iCvarEnd = StrContains(sRead, " ")) == -1 || iCvarEnd >= iValueStart || iCvarEnd >= iValueStart)
			{
				continue;
			}
			strcopy(sCopy, sizeof(sCopy), sRead);
			sCopy[iCvarEnd] = '\0';
			strcopy(sConvar, sizeof(sConvar), sCopy);
			strcopy(sCopy, sizeof(sCopy), sRead[iValueStart+1]);
			sCopy[iValueEnd] = '\0';
			strcopy(sValue, sizeof(sValue), sCopy);
			if (StrEqual(sConvar, cvar, caseSensitive))
			{
				Format(value, size, "%s", sConvar);
				delete fFile;
				return ASS_FIND_SUCCESS;
			}					
		}
		delete fFile;	
		return ASS_FIND_NOT_FOUND;
	}
	return ASS_FIND_FILE_NOT_FOUND;
}

stock int iASS_Clean()
{
	if (strlen(g_sConfigFile) < 1)
	{
		return ASS_NO_CONFIG;
	}
	char sFile[PLATFORM_MAX_PATH];
	strcopy(sFile, sizeof(sFile), g_sConfigFile);
	if (!FileExists(sFile))
	{
		return ASS_CLEAN_FILE_NOT_FOUND;
	}
	char sFile2[PLATFORM_MAX_PATH];
	Format(sFile2, sizeof(sFile2), "%s_tempcopy", sFile);
	char sRead[2048];
	int iCount;
	bool bFirstReached;
	File fFile1 = OpenFile(sFile, "r");
	File fFile2 = OpenFile(sFile2, "w");
	if (fFile1 == null || fFile2 == null)
	{
		if (fFile1 != null)
		{
			delete fFile1;
		}
		if (fFile2 != null)
		{
			delete fFile2;
		}
		return ASS_CLEAN_BAD_HANDLE;
	}
	while (!fFile1.EndOfFile() && fFile1.ReadLine(sRead, sizeof(sRead)))
	{
		if (IsCharSpace(sRead[0]))
		{
			iCount++;
		}
		else
		{
			iCount = 0;
		}
		if (iCount < 2 || !bFirstReached)
		{
			ReplaceString(sRead, sizeof(sRead), "\n", "");
			fFile2.WriteLine(sRead);
		}
		if (iCount == 2)
		{
			bFirstReached = true;
		}
	}
	delete fFile1;
	delete fFile2;
	DeleteFile(sFile);
	RenameFile(sFile, sFile2);	
	return ASS_CLEAN_SUCCESS;
}

stock static int iASS_GetCharCountInStr(int character, const char[] str)
{
	int iLength = strlen(str);
	int iCount;
	for (int iString; iString < iLength; iString++)
	{
		if (str[iString] == character)
		{
			iCount++;
		}
	}
	return iCount;
}

// Checks
stock bool bHasGameDataFile()
{
	return FileExists("addons/sourcemod/gamedata/anti-speedrunner_system.txt", true);
}

stock bool bHasIdlePlayer(int client)
{
	int iIdler = GetClientOfUserId(GetEntData(client, FindSendPropInfo("SurvivorBot", "m_humanSpectatorUserID")));
	if (iIdler)
	{
		if (IsClientInGame(iIdler) && !IsFakeClient(iIdler) && (GetClientTeam(iIdler) != 2))
		{
			return true;
		}
	}
	return false;
}

stock bool bHasTranslationFile()
{
	return FileExists("addons/sourcemod/translations/anti-speedrunner_system.phrases.txt", true);
}

public bool bInfectedFilter(const char[] pattern, Handle clients)
{
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		if (bIsInfected(iPlayer))
		{
			PushArrayCell(clients, iPlayer);
		}
	}
	return true;
}

stock bool bIsAbleHumanSurvivor(int client)
{
	return client > 0 && client <= MaxClients && IsClientInGame(client) && GetClientTeam(client) == 2 && IsPlayerAlive(client) && !bIsPlayerIncapacitated(client) && !IsClientInKickQueue(client) && !IsFakeClient(client) && !bHasIdlePlayer(client) && !bIsPlayerIdle(client);
}

stock bool bIsAbleSurvivor(int client)
{
	return client > 0 && client <= MaxClients && IsClientInGame(client) && GetClientTeam(client) == 2 && IsPlayerAlive(client) && !bIsPlayerIncapacitated(client) && !IsClientInKickQueue(client);
}

stock bool bIsAdminAllowed(int client)
{
	return CheckCommandAccess(client, "ass_override", ADMFLAG_GENERIC, false);
}

stock bool bIsBotIdle(int client)
{
	return client > 0 && client <= MaxClients && IsClientInGame(client) && GetClientTeam(client) == 2 && IsPlayerAlive(client) && !IsClientInKickQueue(client) && IsFakeClient(client) && bHasIdlePlayer(client);
}

stock bool bIsBotIdleSurvivor(int client)
{
	return client > 0 && client <= MaxClients && IsClientInGame(client) && GetClientTeam(client) == 2 && IsPlayerAlive(client) && !IsClientInKickQueue(client) && IsFakeClient(client) && !bHasIdlePlayer(client);
}

stock bool bIsBotInfected(int client)
{
	return client > 0 && client <= MaxClients && IsClientInGame(client) && GetClientTeam(client) == 3 && IsPlayerAlive(client) && !IsClientInKickQueue(client) && IsFakeClient(client);
}

stock bool bIsBotSurvivor(int client)
{
	return client > 0 && client <= MaxClients && IsClientInGame(client) && GetClientTeam(client) == 2 && IsPlayerAlive(client) && !IsClientInKickQueue(client) && IsFakeClient(client);
}

stock bool bIsBuggedMap()
{
	char sMapName[128];
	GetCurrentMap(sMapName, sizeof(sMapName));
	return StrEqual(sMapName, "l4d_smalltown03_ranchhouse", false) || StrEqual(sMapName, "l4d_smalltown04_mainstreet", false) || StrEqual(sMapName, "c10m3_ranchhouse", false) || StrEqual(sMapName, "c10m4_mainstreet", false);
}

stock bool bIsFinaleMap()
{
	return FindEntityByClassname(-1, "trigger_finale") != -1;
}

stock bool bIsHumanSurvivor(int client)
{
	return client > 0 && client <= MaxClients && IsClientInGame(client) && GetClientTeam(client) == 2 && IsPlayerAlive(client) && !IsClientInKickQueue(client) && !IsFakeClient(client) && !bHasIdlePlayer(client) && !bIsPlayerIdle(client);
}

stock bool bIsIdlePlayer(int bot, int client)
{
	return client > 0 && client <= MaxClients && IsClientInGame(client) && !IsFakeClient(client) && GetClientTeam(bot) == 2;
}

stock bool bIsIncapacitatedSurvivor(int client)
{
	return client > 0 && client <= MaxClients && IsClientInGame(client) && GetClientTeam(client) == 2 && IsPlayerAlive(client) && bIsPlayerIncapacitated(client) && !IsClientInKickQueue(client);
}

stock bool bIsInfected(int client)
{
	return client > 0 && client <= MaxClients && IsClientInGame(client) && GetClientTeam(client) == 3 && IsPlayerAlive(client) && !IsClientInKickQueue(client);
}

stock bool bIsL4D2Game()
{
	EngineVersion evEngine = GetEngineVersion();
	return evEngine == Engine_Left4Dead2;
}

stock bool bIsPlayerIdle(int client)
{
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		if (!IsClientInGame(iPlayer) || GetClientTeam(iPlayer) != 2 || !IsFakeClient(iPlayer) || !bHasIdlePlayer(iPlayer))
		{
			continue;
		}
		int iIdler = GetClientOfUserId(GetEntData(iPlayer, FindSendPropInfo("SurvivorBot", "m_humanSpectatorUserID")));
		if (iIdler == client)
		{
			return true;
		}
	}
	return false;
}

stock bool bIsPlayerIncapacitated(int client)
{
	if (GetEntProp(client, Prop_Send, "m_isIncapacitated", 1) || GetEntProp(client, Prop_Send, "m_isHangingFromLedge", 1))
	{
		return true;
	}
	return false;
}

stock bool bIsSurvivor(int client)
{
	return client > 0 && client <= MaxClients && IsClientInGame(client) && GetClientTeam(client) == 2 && IsPlayerAlive(client) && !IsClientInKickQueue(client);
}

stock bool bIsSystemValid(ConVar convar, ConVar convar2, ConVar convar3, ConVar convar4)
{
	if (convar == null)
	{
		return false;
	}
	if (convar2.IntValue != 0)
	{
		g_iCurrentMode = 0;
		int iGameMode = CreateEntityByName("info_gamemode");
		DispatchSpawn(iGameMode);
		HookSingleEntityOutput(iGameMode, "OnCoop", vGameMode, true);
		HookSingleEntityOutput(iGameMode, "OnSurvival", vGameMode, true);
		HookSingleEntityOutput(iGameMode, "OnVersus", vGameMode, true);
		HookSingleEntityOutput(iGameMode, "OnScavenge", vGameMode, true);
		ActivateEntity(iGameMode);
		AcceptEntityInput(iGameMode, "PostSpawnActivate");
		AcceptEntityInput(iGameMode, "Kill");
		if (g_iCurrentMode == 0 || !(convar2.IntValue & g_iCurrentMode))
		{
			return false;
		}
	}
	char sGameMode[32];
	char sConVarModes[32];
	convar.GetString(sGameMode, sizeof(sGameMode));
	Format(sGameMode, sizeof(sGameMode), ",%s,", sGameMode);
	convar3.GetString(sConVarModes, sizeof(sConVarModes));
	if (strcmp(sConVarModes, ""))
	{
		Format(sConVarModes, sizeof(sConVarModes), ",%s,", sConVarModes);
		if (StrContains(sConVarModes, sGameMode, false) == -1)
		{
			return false;
		}
	}
	convar4.GetString(sConVarModes, sizeof(sConVarModes));
	if (strcmp(sConVarModes, ""))
	{
		Format(sConVarModes, sizeof(sConVarModes), ",%s,", sConVarModes);
		if (StrContains(sConVarModes, sGameMode, false) != -1)
		{
			return false;
		}
	}
	return true;
}

stock bool bIsTank(int client)
{
	char sClassname[32];
	if (bIsInfected(client))
	{
		GetEntityNetClass(client, sClassname, sizeof(sClassname));
		if (StrEqual(sClassname, "Tank", false))
		{
			return true;
		}
	}
	return false;
}

stock bool bIsValidClient(int client)
{
	return client > 0 && client <= MaxClients && IsClientInGame(client) && !IsClientInKickQueue(client) && !IsFakeClient(client);
}

stock bool bIsValidEntRef(int entity)
{
	return entity && EntRefToEntIndex(entity) != INVALID_ENT_REFERENCE;
}

public bool bSurvivorFilter(const char[] pattern, Handle clients)
{
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		if (bIsSurvivor(iPlayer))
		{
			PushArrayCell(clients, iPlayer);
		}
	}
	return true;
}

stock bool bTraceRayDontHitSelf(int entity, any data)
{
	return entity == data;
}

// Functions
stock int iGetAbleSurvivorCount(bool bots)
{
	int iAbleSurvivorCount;
	for (int iSurvivor = 1; iSurvivor <= MaxClients; iSurvivor++)
	{
		if ((!bots && IsFakeClient(iSurvivor)) || !bIsAbleSurvivor(iSurvivor))
		{
			continue;
		}
		iAbleSurvivorCount++;
	}
	return iAbleSurvivorCount;
}

stock int iGetAccurateTime(ConVar convar, const bool difference = true)
{
	if (!difference)
	{
		return GetTime();
	}
	int iTime = GetTime();
	int iOperand = iParseTimeOffsetOperation(convar, false);
	int iAmount = iParseTimeOffsetOperation(convar, true);
	if (iOperand == '+')
	{
		iTime = iTime + (iAmount * 3600);
	}
	if (iOperand == '-')
	{
		iTime = iTime - (iAmount * 3600);
	}
	return iTime;
}

stock int iGetBadSurvivorCount(bool bots)
{
	int iBadCount;
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		if (!bIsPlayerBad(iPlayer) || (!bots && IsFakeClient(iPlayer)) || !bIsAbleSurvivor(iPlayer))
		{
			continue;
		}
		iBadCount++;
	}
	return iBadCount;
}

stock int iGetBotSurvivor()
{
	for (int iBot = MaxClients; iBot >= 1; iBot--)
	{
		if (bIsBotSurvivor(iBot))
		{
			return iBot;
		}
	}
	return -1;
}

stock int iGetHumanCount()
{
	int iHumanCount;
	for (int iHuman = 1; iHuman <= MaxClients; iHuman++)
	{
		if (bIsHumanSurvivor(iHuman))
		{
			iHumanCount++;
		}
	}
	return iHumanCount;
}

stock int iGetIdleBot(int client)
{
	for (int iBot = 1; iBot <= MaxClients; iBot++)
	{
		if (iGetIdlePlayer(iBot) == client)
		{
			return iBot;
		}
	}
	return 0;
}

stock int iGetIdlePlayer(int client)
{
	if (bIsBotSurvivor(client))
	{
		char sClassname[12];
		GetEntityNetClass(client, sClassname, sizeof(sClassname));
		if (strcmp(sClassname, "SurvivorBot") == 0)
		{
			int iIdler = GetClientOfUserId(GetEntProp(client, Prop_Send, "m_humanSpectatorUserID"));			
			if (iIdler > 0 && IsClientInGame(iIdler) && GetClientTeam(iIdler) == 1)
			{
				return iIdler;
			}
		}
	}
	return 0;
}

stock int iGetIncapCount()
{
	int iIncapacitatedCount;
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		if (bIsIncapacitatedSurvivor(iPlayer))
		{
			iIncapacitatedCount++;
		}
	}
	return iIncapacitatedCount;
}

stock int iGetPlayerCount()
{
	int iPlayerCount;
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		if (bIsValidClient(iPlayer))
		{
			iPlayerCount++;
		}
	}
	return iPlayerCount;
}

stock int iGetReviveCount()
{
	int iRevivedCount;
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		if (bIsAbleSurvivor(iPlayer))
		{
			iRevivedCount++;
		}
	}
	return iRevivedCount;
}

stock int iGetSurvivorCount()
{
	int iSurvivorCount;
	for (int iSurvivor = 1; iSurvivor <= MaxClients; iSurvivor++)
	{
		if (bIsSurvivor(iSurvivor))
		{
			iSurvivorCount++;
		}
	}
	return iSurvivorCount;
}

stock int iGetTankCount()
{
	int iTankCount;
	for (int iTank = 1; iTank <= MaxClients; iTank++)
	{
		if (bIsTank(iTank))
		{
			iTankCount++;
		}
	}
	return iTankCount;
}

stock int iParseTimeOffsetOperation(ConVar convar, const bool operation = false)
{
	char sConvarValue[16];
	convar.GetString(sConvarValue, sizeof(sConvarValue));
	TrimString(sConvarValue);
	int iOperand = sConvarValue[0];
	sConvarValue[0] = ' ';
	TrimString(sConvarValue);
	int iAmount = StringToInt(sConvarValue);
	if (iOperand != '+' && iOperand != '-' && (iAmount <= 0 || iAmount > 24))
	{
		iOperand = ' ';
		iAmount  = 0;
	}
	return operation ? iAmount : iOperand;
}

stock void vCheatCommand(int client, char[] command, char[] arguments = "")
{
	int iCmdFlags = GetCommandFlags(command);
	SetCommandFlags(command, iCmdFlags & ~FCVAR_CHEAT);
	FakeClientCommand(client, "%s %s", command, arguments);
	SetCommandFlags(command, iCmdFlags | FCVAR_CHEAT);
}

stock void vCopyVector(float source[3], float target[3])
{
	target[0] = source[0];
	target[1] = source[1];
	target[2] = source[2];
}

stock void vDeleteEntity(int entity, float time = 0.1)
{
	if (bIsValidEntRef(entity))
	{
		char sVariant[64];
		Format(sVariant, sizeof(sVariant), "OnUser1 !self:kill::%f:1", time);
		AcceptEntityInput(entity, "ClearParent");
		SetVariantString(sVariant);
		AcceptEntityInput(entity, "AddOutput");
		AcceptEntityInput(entity, "FireUser1");
	}
}

stock void vDeleteParticle(int entity, float time, char[] input)
{
	if (bIsValidEntRef(entity))
	{
		char sVariant[64];
		Format(sVariant, sizeof(sVariant), "OnUser1 !self:kill::%f:1", time);
		AcceptEntityInput(entity, "ClearParent");
		SetVariantString(sVariant);
		AcceptEntityInput(entity, input);
	}
}

public void vGameMode(const char[] output, int caller, int activator, float delay)
{
	if (strcmp(output, "OnCoop") == 0)
	{
		g_iCurrentMode = 1;
	}
	else if (strcmp(output, "OnVersus") == 0)
	{
		g_iCurrentMode = 2;
	}
	else if (strcmp(output, "OnSurvival") == 0)
	{
		g_iCurrentMode = 4;
	}
	else if (strcmp(output, "OnScavenge") == 0)
	{
		g_iCurrentMode = 8;
	}
}

stock void vMultiTargetFilters(int toggle)
{
	switch (toggle)
	{
		case 0:
		{
			RemoveMultiTargetFilter("@survivors", bSurvivorFilter);
			RemoveMultiTargetFilter("@infected", bInfectedFilter);
		}
		case 1:
		{
			AddMultiTargetFilter("@survivors", bSurvivorFilter, "all survivors", false);
			AddMultiTargetFilter("@infected", bInfectedFilter, "all infected", false);
		}
	}
}

stock void vNobodyVoted(int votes, int totalvotes)
{
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		if (bIsHumanSurvivor(iPlayer))
		{
			if (bHasTranslationFile())
			{
				PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "NobodyVoted", votes, totalvotes);
			}
			else
			{
				PrintToChat(iPlayer, "%s %d/%d voted.", ASS_PREFIX01, votes, totalvotes);
			}
		}
	}
}