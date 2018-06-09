// Configuration System
char g_sConfigOption[6];
ConVar g_cvASSConfigCreate;
ConVar g_cvASSConfigEnable;
ConVar g_cvASSConfigExecute;
ConVar g_cvASSConfigTimeOffset;
ConVar g_cvASSGameDifficulty;
ConVar g_cvASSGameType;

void vConfigCvars()
{
	vCreateConVar(g_cvASSConfigCreate, "assconfig_createtype", "31425", "Which type of custom config should the Anti-Speedrunner System create?\nCombine numbers in any order for different results.\nCharacter limit: 5\n(1: Difficulties)\n(2: Maps)\n(3: Game modes)\n(4: Days)\n(5: Player count)");
	vCreateConVar(g_cvASSConfigEnable, "assconfig_enablesystem", "0", "Enable the Configuration system?\n(0: OFF)\n(1: ON)");
	vCreateConVar(g_cvASSConfigExecute, "assconfig_executetype", "1", "Which type of custom config should the Anti-Speedrunner System execute?\nCombine numbers in any order for different results.\nCharacter limit: 5\n(1: Difficulties)\n(2: Maps)\n(3: Game modes)\n(4: Days)\n(5: Player count)");
	vCreateConVar(g_cvASSConfigTimeOffset, "assconfig_timeoffset", "", "What is the time offset of the server?\n(Used for daily configs.)");
	g_cvASSGameDifficulty = FindConVar("z_difficulty");
	g_cvASSGameType = FindConVar("sv_gametypes");
}

void vHookConfigCvars()
{
	g_cvASSGameDifficulty.AddChangeHook(vASSGameDifficultyCvar);
}

void vExecuteConfigs()
{
	g_cvASSConfigExecute.GetString(g_sConfigOption, sizeof(g_sConfigOption));
	if (StrContains(g_sConfigOption, "1", false) != -1 && g_cvASSGameDifficulty != null)
	{
		char sDifficultyConfig[512];
		g_cvASSGameDifficulty.GetString(sDifficultyConfig, sizeof(sDifficultyConfig));
		Format(sDifficultyConfig, sizeof(sDifficultyConfig), "cfg/sourcemod/anti-speedrunner_system/difficulty_configs/%s.cfg", sDifficultyConfig);
		if (FileExists(sDifficultyConfig, true))
		{
			strcopy(sDifficultyConfig, sizeof(sDifficultyConfig), sDifficultyConfig[4]);
			ServerCommand("exec \"%s\"", sDifficultyConfig);
		}
		else if (!FileExists(sDifficultyConfig, true) && g_cvASSConfigEnable.BoolValue)
		{
			vCreateConfigFile("cfg/sourcemod/anti-speedrunner_system/", "difficulty_configs/", sDifficultyConfig, sDifficultyConfig);
		}
	}
	if (StrContains(g_sConfigOption, "2", false) != -1)
	{
		char sMapConfig[512];
		GetCurrentMap(sMapConfig, sizeof(sMapConfig));
		Format(sMapConfig, sizeof(sMapConfig), (bIsL4D2Game() ? "cfg/sourcemod/anti-speedrunner_system/l4d2_map_configs/%s.cfg" : "cfg/sourcemod/anti-speedrunner_system/l4d_map_configs/%s.cfg"), sMapConfig);
		if (FileExists(sMapConfig, true))
		{
			strcopy(sMapConfig, sizeof(sMapConfig), sMapConfig[4]);
			ServerCommand("exec \"%s\"", sMapConfig);
		}
		else if (!FileExists(sMapConfig, true) && g_cvASSConfigEnable.BoolValue)
		{
			vCreateConfigFile("cfg/sourcemod/anti-speedrunner_system/", (bIsL4D2Game() ? "l4d2_map_configs/" : "l4d_map_configs/"), sMapConfig, sMapConfig);
		}
	}
	if (StrContains(g_sConfigOption, "3", false) != -1)
	{
		char sModeConfig[512];
		g_cvASSGameMode.GetString(sModeConfig, sizeof(sModeConfig));
		Format(sModeConfig, sizeof(sModeConfig), (bIsL4D2Game() ? "cfg/sourcemod/anti-speedrunner_system/l4d2_gamemode_configs/%s.cfg" : "cfg/sourcemod/anti-speedrunner_system/l4d_gamemode_configs/%s.cfg"), sModeConfig);
		if (FileExists(sModeConfig, true))
		{
			strcopy(sModeConfig, sizeof(sModeConfig), sModeConfig[4]);
			ServerCommand("exec \"%s\"", sModeConfig);
		}
		else if (!FileExists(sModeConfig, true) && g_cvASSConfigEnable.BoolValue)
		{
			vCreateConfigFile("cfg/sourcemod/anti-speedrunner_system/", (bIsL4D2Game() ? "l4d2_gamemode_configs/" : "l4d_gamemode_configs/"), sModeConfig, sModeConfig);
		}
	}
	if (StrContains(g_sConfigOption, "4", false) != -1)
	{
		char sDayConfig[512];
		char sDay[2];
		FormatTime(sDay, sizeof(sDay), "%w", iGetAccurateTime(true));
		int iDayNum = StringToInt(sDay);
		switch (iDayNum)
		{
			case 6: sDayConfig = "saturday";
			case 5: sDayConfig = "friday";
			case 4: sDayConfig = "thursday";
			case 3: sDayConfig = "wednesday";
			case 2: sDayConfig = "tuesday";
			case 1: sDayConfig = "monday";
			default: sDayConfig = "sunday";
		}
		Format(sDayConfig, sizeof(sDayConfig), "cfg/sourcemod/anti-speedrunner_system/daily_configs/%s.cfg", sDayConfig);
		if (FileExists(sDayConfig, true))
		{
			strcopy(sDayConfig, sizeof(sDayConfig), sDayConfig[4]);
			ServerCommand("exec \"%s\"", sDayConfig);
		}
		else if (!FileExists(sDayConfig, true) && g_cvASSConfigEnable.BoolValue)
		{
			vCreateConfigFile("cfg/sourcemod/anti-speedrunner_system/", "daily_configs/", sDayConfig, sDayConfig);
		}
	}
	if (StrContains(g_sConfigOption, "5", false) != -1)
	{
		char sCountConfig[512];
		Format(sCountConfig, sizeof(sCountConfig), "cfg/sourcemod/anti-speedrunner_system/playercount_configs/%d.cfg", iGetPlayerCount());
		if (FileExists(sCountConfig, true))
		{
			strcopy(sCountConfig, sizeof(sCountConfig), sCountConfig[4]);
			ServerCommand("exec \"%s\"", sCountConfig);
		}
		else if (!FileExists(sCountConfig, true) && g_cvASSConfigEnable.BoolValue)
		{
			vCreateConfigFile("cfg/sourcemod/anti-speedrunner_system/", "playercount_configs/", sCountConfig, sCountConfig);
		}
	}
}

public Action cmdASSConfig(int client, int args)
{
	if (!g_cvASSEnable.BoolValue)
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "ASSOff") : ReplyToCommand(client, "%s The Anti-Speedrunner System is disabled.", ASS_PREFIX01);
		return Plugin_Handled;
	}
	if (!bIsValidClient(client))
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX, "InGame") : ReplyToCommand(client, "%s This command is to be used only in-game.", ASS_PREFIX);
		return Plugin_Handled;
	}
	char filename[128];
	GetCmdArg(3, filename, sizeof(filename));
	char arg2[32];
	GetCmdArg(2, arg2, sizeof(arg2));
	int type = StringToInt(arg2);
	char arg[32];
	GetCmdArg(1, arg, sizeof(arg));
	int mode = StringToInt(arg);
	if (args <= 1)
	{
		if (IsVoteInProgress())
		{
			ReplyToCommand(client, "%s %t", ASS_PREFIX01, "Vote in Progress");
		}
		else
		{
			vConfigsMenu(client);
		}
		return Plugin_Handled;
	}
	else if (mode > 1 || type > 4 || args > 3)
	{
		ReplyToCommand(client, "Usage: ass_config <0: create|1: execute> <0: difficulty|1: map|2: game mode|3: day|4: player count> \"filename\"");
		return Plugin_Handled;
	}
	vManualConfig(client, mode, type, filename);
	ShowActivity2(client, ASS_PREFIX2, "Used \"ass_config\".");
	return Plugin_Handled;
}

void vManualConfig(int client, int mode, int type, char[] filename = "")
{
	bool bNoFilename;
	switch (type)
	{
		case 0:
		{
			if (g_cvASSGameDifficulty != null)
			{
				char sDifficultyConfig[128];
				g_cvASSGameDifficulty.GetString(sDifficultyConfig, sizeof(sDifficultyConfig));
				filename[0] == '\0' ? (bNoFilename = true) : (bNoFilename = false);
				filename[0] == '\0' ? vManualDifficulty(client, mode, sDifficultyConfig) : vManualDifficulty(client, mode, filename);
				if (g_cvASSLogCommands.BoolValue)
				{
					LogAction(client, -1, "%s \"%L\" created/executed \"%s.cfg\" in difficulty_configs.", ASS_PREFIX, client, (bNoFilename ? sDifficultyConfig : filename));
				}
			}
			else
			{
				bHasTranslationFile() ? PrintToChat(client, "%s %t", ASS_PREFIX01, "NoDifficulty") : PrintToChat(client, "%s No \"z_difficulty\" convar found.", ASS_PREFIX01);
			}
		}
		case 1:
		{
			char sMapConfig[128];
			GetCurrentMap(sMapConfig, sizeof(sMapConfig));
			filename[0] == '\0' ? (bNoFilename = true) : (bNoFilename = false);
			filename[0] == '\0' ? vManualMap(client, mode, sMapConfig) : vManualMap(client, mode, filename);
			if (g_cvASSLogCommands.BoolValue)
			{
				LogAction(client, -1, "%s \"%L\" created/executed \"%s.cfg\" in %s.", ASS_PREFIX, client, (bNoFilename ? sMapConfig : filename), (bIsL4D2Game() ? "l4d2_map_configs" : "l4d_map_configs"));
			}
		}
		case 2:
		{
			char sModeConfig[128];
			g_cvASSGameMode.GetString(sModeConfig, sizeof(sModeConfig));
			filename[0] == '\0' ? (bNoFilename = true) : (bNoFilename = false);
			filename[0] == '\0' ? vManualMode(client, mode, sModeConfig) : vManualMode(client, mode, filename);
			if (g_cvASSLogCommands.BoolValue)
			{
				LogAction(client, -1, "%s \"%L\" created/executed \"%s.cfg\" in %s.", ASS_PREFIX, client, (bNoFilename ? sModeConfig : filename), (bIsL4D2Game() ? "l4d2_gamemode_configs" : "l4d_gamemode_configs"));
			}
		}
		case 3:
		{
			char sDayConfig[128];
			char sDay[2];
			FormatTime(sDay, sizeof(sDay), "%w", iGetAccurateTime(true));
			int iDayNum = StringToInt(sDay);
			switch (iDayNum)
			{
				case 6: sDayConfig = "saturday";
				case 5: sDayConfig = "friday";
				case 4: sDayConfig = "thursday";
				case 3: sDayConfig = "wednesday";
				case 2: sDayConfig = "tuesday";
				case 1: sDayConfig = "monday";
				default: sDayConfig = "sunday";
			}
			filename[0] == '\0' ? (bNoFilename = true) : (bNoFilename = false);
			filename[0] == '\0' ? vManualDay(client, mode, sDayConfig) : vManualDay(client, mode, filename);
			if (g_cvASSLogCommands.BoolValue)
			{
				LogAction(client, -1, "%s \"%L\" created/executed \"%s.cfg\" in daily_configs.", ASS_PREFIX, client, (bNoFilename ? sDayConfig : filename));
			}
		}
		case 4:
		{
			char sCountConfig[128];
			Format(sCountConfig, sizeof(sCountConfig), "%d", iGetPlayerCount());
			filename[0] == '\0' ? (bNoFilename = true) : (bNoFilename = false);
			filename[0] == '\0' ? vManualCount(client, mode, sCountConfig) : vManualCount(client, mode, filename);
			if (g_cvASSLogCommands.BoolValue)
			{
				LogAction(client, -1, "%s \"%L\" created/executed \"%s.cfg\" in playercount_configs.", ASS_PREFIX, client, (bNoFilename ? sCountConfig : filename));
			}
		}
	}
}

void vManualDifficulty(int client, int toggle, char[] difficulty)
{
	char sConfigFilename[512];
	Format(sConfigFilename, sizeof(sConfigFilename), "cfg/sourcemod/anti-speedrunner_system/difficulty_configs/%s.cfg", difficulty);
	switch (toggle)
	{
		case 0:
		{
			if (!FileExists(sConfigFilename, true))
			{
				CreateDirectory("cfg/sourcemod/anti-speedrunner_system/difficulty_configs/", 511);
				vCreateConfigFile("cfg/sourcemod/anti-speedrunner_system/", "difficulty_configs/", difficulty, difficulty);
				if (bIsValidClient(client))
				{
					bHasTranslationFile() ? PrintToChat(client, "%s %t", ASS_PREFIX01, "ConfigSaved", difficulty, "difficulty_configs") : PrintToChat(client, "%s Saved %s.cfg to %s.", ASS_PREFIX01, difficulty, "difficulty_configs");
				}
			}
			else
			{
				if (bIsValidClient(client))
				{
					bHasTranslationFile() ? PrintToChat(client, "%s %t", ASS_PREFIX01, "ConfigExists", difficulty, "difficulty_configs") : PrintToChat(client, "%s %s.cfg already found in %s.", ASS_PREFIX01, difficulty, "difficulty_configs");
				}
			}
		}
		case 1:
		{
			if (FileExists(sConfigFilename, true))
			{
				ServerCommand("exec sourcemod/anti-speedrunner_system/difficulty_configs/%s", difficulty);
				if (bIsValidClient(client))
				{
					bHasTranslationFile() ? PrintToChat(client, "%s %t", ASS_PREFIX01, "ConfigExecuted", difficulty, "difficulty_configs") : PrintToChat(client, "%s Executed %s.cfg from %s.", ASS_PREFIX01, difficulty, "difficulty_configs");
				}
			}
			else
			{
				if (bIsValidClient(client))
				{
					bHasTranslationFile() ? PrintToChat(client, "%s %t", ASS_PREFIX01, "ConfigNotFound", difficulty, "difficulty_configs") : PrintToChat(client, "%s %s.cfg not found in %s.", ASS_PREFIX01, difficulty, "difficulty_configs");
				}
			}
		}
	}	
}

void vManualMap(int client, int toggle, char[] map)
{
	char sConfigFilename[512];
	Format(sConfigFilename, sizeof(sConfigFilename), "cfg/sourcemod/anti-speedrunner_system/%s/%s.cfg", (bIsL4D2Game() ? "l4d2_map_configs" : "l4d_map_configs"), map);
	switch (toggle)
	{
		case 0:
		{
			if (!FileExists(sConfigFilename, true))
			{
				CreateDirectory((bIsL4D2Game() ? "cfg/sourcemod/anti-speedrunner_system/l4d2_map_configs/" : "cfg/sourcemod/anti-speedrunner_system/l4d_map_configs/"), 511);
				vCreateConfigFile("cfg/sourcemod/anti-speedrunner_system/", (bIsL4D2Game() ? "l4d2_map_configs/" : "l4d_map_configs/"), map, map);
				if (bIsValidClient(client))
				{
					bHasTranslationFile() ? PrintToChat(client, "%s %t", ASS_PREFIX01, "ConfigSaved", map, (bIsL4D2Game() ? "l4d2_map_configs" : "l4d_map_configs")) : PrintToChat(client, "%s Saved %s.cfg to %s.", ASS_PREFIX01, map, (bIsL4D2Game() ? "l4d2_map_configs" : "l4d_map_configs"));
				}
			}
			else
			{
				if (bIsValidClient(client))
				{
					bHasTranslationFile() ? PrintToChat(client, "%s %t", ASS_PREFIX01, "ConfigExists", map, (bIsL4D2Game() ? "l4d2_map_configs" : "l4d_map_configs")) : PrintToChat(client, "%s %s.cfg already found in %s.", ASS_PREFIX01, map, (bIsL4D2Game() ? "l4d2_map_configs" : "l4d_map_configs"));
				}
			}
		}
		case 1:
		{
			if (FileExists(sConfigFilename, true))
			{
				ServerCommand("exec sourcemod/anti-speedrunner_system/%s/%s", (bIsL4D2Game() ? "l4d2_map_configs" : "l4d_map_configs"), map);
				if (bIsValidClient(client))
				{
					bHasTranslationFile() ? PrintToChat(client, "%s %t", ASS_PREFIX01, "ConfigExecuted", map, (bIsL4D2Game() ? "l4d2_map_configs" : "l4d_map_configs")) : PrintToChat(client, "%s Executed %s.cfg from %s.", ASS_PREFIX01, map, (bIsL4D2Game() ? "l4d2_map_configs" : "l4d_map_configs"));
				}
			}
			else
			{
				if (bIsValidClient(client))
				{
					bHasTranslationFile() ? PrintToChat(client, "%s %t", ASS_PREFIX01, "ConfigNotFound", map, (bIsL4D2Game() ? "l4d2_map_configs" : "l4d_map_configs")) : PrintToChat(client, "%s %s.cfg not found in %s.", ASS_PREFIX01, map, (bIsL4D2Game() ? "l4d2_map_configs" : "l4d_map_configs"));
				}
			}
		}
	}
}

void vManualMode(int client, int toggle, char[] mode)
{
	char sConfigFilename[512];
	Format(sConfigFilename, sizeof(sConfigFilename), "cfg/sourcemod/anti-speedrunner_system/%s/%s.cfg", (bIsL4D2Game() ? "l4d2_gamemode_configs" : "l4d_gamemode_configs"), mode);
	switch (toggle)
	{
		case 0:
		{
			if (!FileExists(sConfigFilename, true))
			{
				CreateDirectory((bIsL4D2Game() ? "cfg/sourcemod/anti-speedrunner_system/l4d2_gamemode_configs/" : "cfg/sourcemod/anti-speedrunner_system/l4d_gamemode_configs/"), 511);
				vCreateConfigFile("cfg/sourcemod/anti-speedrunner_system/", (bIsL4D2Game() ? "l4d2_gamemode_configs/" : "l4d_gamemode_configs/"), mode, mode);
				if (bIsValidClient(client))
				{
					bHasTranslationFile() ? PrintToChat(client, "%s %t", ASS_PREFIX01, "ConfigSaved", mode, (bIsL4D2Game() ? "l4d2_gamemode_configs" : "l4d_gamemode_configs")) : PrintToChat(client, "%s Saved %s.cfg to %s.", ASS_PREFIX01, mode, (bIsL4D2Game() ? "l4d2_gamemode_configs" : "l4d_gamemode_configs"));
				}
			}
			else
			{
				if (bIsValidClient(client))
				{
					bHasTranslationFile() ? PrintToChat(client, "%s %t", ASS_PREFIX01, "ConfigExists", mode, (bIsL4D2Game() ? "l4d2_gamemode_configs" : "l4d_gamemode_configs")) : PrintToChat(client, "%s %s.cfg already found in %s.", ASS_PREFIX01, mode, (bIsL4D2Game() ? "l4d2_gamemode_configs" : "l4d_gamemode_configs"));
				}
			}
		}
		case 1:
		{
			if (FileExists(sConfigFilename, true))
			{
				ServerCommand("exec sourcemod/anti-speedrunner_system/%s/%s", (bIsL4D2Game() ? "l4d2_gamemode_configs" : "l4d_gamemode_configs"), mode);
				if (bIsValidClient(client))
				{
					bHasTranslationFile() ? PrintToChat(client, "%s %t", ASS_PREFIX01, "ConfigExecuted", mode, (bIsL4D2Game() ? "l4d2_gamemode_configs" : "l4d_gamemode_configs")) : PrintToChat(client, "%s Executed %s.cfg from %s.", ASS_PREFIX01, mode, (bIsL4D2Game() ? "l4d2_gamemode_configs" : "l4d_gamemode_configs"));
				}
			}
			else
			{
				if (bIsValidClient(client))
				{
					bHasTranslationFile() ? PrintToChat(client, "%s %t", ASS_PREFIX01, "ConfigNotFound", mode, (bIsL4D2Game() ? "l4d2_gamemode_configs" : "l4d_gamemode_configs")) : PrintToChat(client, "%s %s.cfg not found in %s.", ASS_PREFIX01, mode, (bIsL4D2Game() ? "l4d2_gamemode_configs" : "l4d_gamemode_configs"));
				}
			}
		}
	}
}

void vManualDay(int client, int toggle, char[] day)
{
	char sConfigFilename[512];
	Format(sConfigFilename, sizeof(sConfigFilename), "cfg/sourcemod/anti-speedrunner_system/daily_configs/%s.cfg", day);
	switch (toggle)
	{
		case 0:
		{
			if (!FileExists(sConfigFilename, true))
			{
				CreateDirectory("cfg/sourcemod/anti-speedrunner_system/daily_configs/", 511);
				vCreateConfigFile("cfg/sourcemod/anti-speedrunner_system/", "daily_configs/", day, day);
				if (bIsValidClient(client))
				{
					bHasTranslationFile() ? PrintToChat(client, "%s %t", ASS_PREFIX01, "ConfigSaved", day, "daily_configs") : PrintToChat(client, "%s Saved %s.cfg to %s.", ASS_PREFIX01, day, "daily_configs");
				}
			}
			else
			{
				if (bIsValidClient(client))
				{
					bHasTranslationFile() ? PrintToChat(client, "%s %t", ASS_PREFIX01, "ConfigExists", day, "daily_configs") : PrintToChat(client, "%s %s.cfg already found in %s.", ASS_PREFIX01, day, "daily_configs");
				}
			}
		}
		case 1:
		{
			if (FileExists(sConfigFilename, true))
			{
				ServerCommand("exec sourcemod/anti-speedrunner_system/daily_configs/%s", day);
				if (bIsValidClient(client))
				{
					bHasTranslationFile() ? PrintToChat(client, "%s %t", ASS_PREFIX01, "ConfigExecuted", day, "daily_configs") : PrintToChat(client, "%s Executed %s.cfg from %s.", ASS_PREFIX01, day, "daily_configs");
				}
			}
			else
			{
				if (bIsValidClient(client))
				{
					bHasTranslationFile() ? PrintToChat(client, "%s %t", ASS_PREFIX01, "ConfigNotFound", day, "daily_configs") : PrintToChat(client, "%s %s.cfg not found in %s.", ASS_PREFIX01, day, "daily_configs");
				}
			}
		}
	}	
}

void vManualCount(int client, int toggle, char[] playercount)
{
	char sConfigFilename[512];
	Format(sConfigFilename, sizeof(sConfigFilename), "cfg/sourcemod/anti-speedrunner_system/playercount_configs/%s.cfg", playercount);
	switch (toggle)
	{
		case 0:
		{
			if (!FileExists(sConfigFilename, true))
			{
				CreateDirectory("cfg/sourcemod/anti-speedrunner_system/playercount_configs/", 511);
				vCreateConfigFile("cfg/sourcemod/anti-speedrunner_system/", "playercount_configs/", playercount, playercount);
				if (bIsValidClient(client))
				{
					bHasTranslationFile() ? PrintToChat(client, "%s %t", ASS_PREFIX01, "ConfigSaved", playercount, "playercount_configs") : PrintToChat(client, "%s Saved %s.cfg to %s.", ASS_PREFIX01, playercount, "playercount_configs");
				}
			}
			else
			{
				if (bIsValidClient(client))
				{
					bHasTranslationFile() ? PrintToChat(client, "%s %t", ASS_PREFIX01, "ConfigExists", playercount, "playercount_configs") : PrintToChat(client, "%s %s.cfg already found in %s.", ASS_PREFIX01, playercount, "playercount_configs");
				}
			}
		}
		case 1:
		{
			if (FileExists(sConfigFilename, true))
			{
				ServerCommand("exec sourcemod/anti-speedrunner_system/playercount_configs/%s", playercount);
				if (bIsValidClient(client))
				{
					bHasTranslationFile() ? PrintToChat(client, "%s %t", ASS_PREFIX01, "ConfigExecuted", playercount, "playercount_configs") : PrintToChat(client, "%s Executed %s.cfg from %s.", ASS_PREFIX01, playercount, "playercount_configs");
				}
			}
			else
			{
				if (bIsValidClient(client))
				{
					bHasTranslationFile() ? PrintToChat(client, "%s %t", ASS_PREFIX01, "ConfigNotFound", playercount, "playercount_configs") : PrintToChat(client, "%s %s.cfg not found in %s.", ASS_PREFIX01, playercount, "playercount_configs");
				}
			}
		}
	}	
}

public void vASSGameDifficultyCvar(ConVar convar, const char[] oldValue, const char[] newValue)
{
	g_cvASSConfigExecute.GetString(g_sConfigOption, sizeof(g_sConfigOption));
	if (StrContains(g_sConfigOption, "1", false) != -1)
	{
		char sDifficultyConfig[512];
		g_cvASSGameDifficulty.GetString(sDifficultyConfig, sizeof(sDifficultyConfig));
		Format(sDifficultyConfig, sizeof(sDifficultyConfig), "cfg/sourcemod/anti-speedrunner_system/difficulty_configs/%s.cfg", sDifficultyConfig);
		if (FileExists(sDifficultyConfig, true))
		{
			strcopy(sDifficultyConfig, sizeof(sDifficultyConfig), sDifficultyConfig[4]);
			ServerCommand("exec \"%s\"", sDifficultyConfig);
		}
	}
}

void vCreateConfigFiles()
{
	if (!g_cvASSConfigEnable.BoolValue)
	{
		return;
	}
	g_cvASSConfigCreate.GetString(g_sConfigOption, sizeof(g_sConfigOption));
	if (StrContains(g_sConfigOption, "1", false) != -1)
	{
		CreateDirectory("cfg/sourcemod/anti-speedrunner_system/difficulty_configs/", 511);
		char sDifficulty[32];
		for (int iDifficulty = 0; iDifficulty <= 3; iDifficulty++)
		{
			switch (iDifficulty)
			{
				case 0: sDifficulty = "easy";
				case 1: sDifficulty = "normal";
				case 2: sDifficulty = "hard";
				case 3: sDifficulty = "impossible";
			}
			vCreateConfigFile("cfg/sourcemod/anti-speedrunner_system/", "difficulty_configs/", sDifficulty, sDifficulty);
		}
	}
	if (StrContains(g_sConfigOption, "2", false) != -1)
	{
		CreateDirectory((bIsL4D2Game() ? "cfg/sourcemod/anti-speedrunner_system/l4d2_map_configs/" : "cfg/sourcemod/anti-speedrunner_system/l4d_map_configs/"), 511);
		char sMapNames[128];
		Handle hADTMaps = CreateArray(16, 0);
		int iSerial = -1;
		ReadMapList(hADTMaps, iSerial, "default", MAPLIST_FLAG_MAPSFOLDER);
		ReadMapList(hADTMaps, iSerial, "allexistingmaps__", MAPLIST_FLAG_MAPSFOLDER|MAPLIST_FLAG_NO_DEFAULT);
		int iMapCount = GetArraySize(hADTMaps);
		if (iMapCount > 0)
		{
			for (int iMap = 0; iMap < iMapCount; iMap++)
			{
				GetArrayString(hADTMaps, iMap, sMapNames, sizeof(sMapNames));
				vCreateConfigFile("cfg/sourcemod/anti-speedrunner_system/", (bIsL4D2Game() ? "l4d2_map_configs/" : "l4d_map_configs/"), sMapNames, sMapNames);
			}
		}
	}
	if (StrContains(g_sConfigOption, "3", false) != -1)
	{
		CreateDirectory((bIsL4D2Game() ? "cfg/sourcemod/anti-speedrunner_system/l4d2_gamemode_configs/" : "cfg/sourcemod/anti-speedrunner_system/l4d_gamemode_configs/"), 511);
		char sGameType[2049];
		char sTypes[64][32];
		g_cvASSGameType.GetString(sGameType, sizeof(sGameType));
		ExplodeString(sGameType, ",", sTypes, sizeof(sTypes), sizeof(sTypes[]));
		for (int iMode = 0; iMode < sizeof(sTypes); iMode++)
		{
			if (StrContains(sGameType, sTypes[iMode], false) != -1 && sTypes[iMode][0] != '\0')
			{
				vCreateConfigFile("cfg/sourcemod/anti-speedrunner_system/", (bIsL4D2Game() ? "l4d2_gamemode_configs/" : "l4d_gamemode_configs/"), sTypes[iMode], sTypes[iMode]);
			}
		}
	}
	if (StrContains(g_sConfigOption, "4", false) != -1)
	{
		CreateDirectory("cfg/sourcemod/anti-speedrunner_system/daily_configs/", 511);
		char sWeekday[32];
		for (int iDay = 0; iDay <= 6; iDay++)
		{
			switch (iDay)
			{
				case 6: sWeekday = "saturday";
				case 5: sWeekday = "friday";
				case 4: sWeekday = "thursday";
				case 3: sWeekday = "wednesday";
				case 2: sWeekday = "tuesday";
				case 1: sWeekday = "monday";
				default: sWeekday = "sunday";
			}
			vCreateConfigFile("cfg/sourcemod/anti-speedrunner_system/", "daily_configs/", sWeekday, sWeekday);
		}
	}
	if (StrContains(g_sConfigOption, "5", false) != -1)
	{
		CreateDirectory("cfg/sourcemod/anti-speedrunner_system/playercount_configs/", 511);
		char sPlayerCount[32];
		for (int iCount = 0; iCount <= MAXPLAYERS + 1; iCount++)
		{
			IntToString(iCount, sPlayerCount, sizeof(sPlayerCount));
			vCreateConfigFile("cfg/sourcemod/anti-speedrunner_system/", "playercount_configs/", sPlayerCount, sPlayerCount);
		}
	}
}

void vCreateConfigFile(const char[] filepath, const char[] folder, const char[] filename, const char[] label = "")
{
	char sConfigFilename[128];
	char sConfigLabel[128];
	File fFilename;
	Format(sConfigFilename, sizeof(sConfigFilename), "%s%s%s.cfg", filepath, folder, filename);
	if (FileExists(sConfigFilename))
	{
		return;
	}
	fFilename = OpenFile(sConfigFilename, "w+");
	strlen(label) > 0 ? strcopy(sConfigLabel, sizeof(sConfigLabel), label) : strcopy(sConfigLabel, sizeof(sConfigLabel), sConfigFilename);
	if (fFilename != null)
	{
		bHasTranslationFile() ? fFilename.WriteLine("%t", "ConfigHeader", ASS_VERSION, ASS_URL) : fFilename.WriteLine("// This config file was auto-generated by the Anti-Speedrunner System v%s (%s)", ASS_VERSION, ASS_URL);
		fFilename.WriteLine("");
		fFilename.WriteLine("");
		delete fFilename;
	}
}

int iGetAccurateTime(const bool difference = true)
{
	if (!difference)
	{
		return GetTime();
	}
	int iTime = GetTime();
	int iOperand = iParseTimeOffsetOperation(false);
	int iAmount = iParseTimeOffsetOperation(true);
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

int iParseTimeOffsetOperation(const bool operation = false)
{
	char sConvarValue[16];
	g_cvASSConfigTimeOffset.GetString(sConvarValue, sizeof(sConvarValue));
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
