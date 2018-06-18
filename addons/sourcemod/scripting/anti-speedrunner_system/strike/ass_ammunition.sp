// Ammunition Option
Handle g_hAmmoTimers[MAXPLAYERS + 1];

public Action cmdASSAmmo(int client, int args)
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
	char arg4[32];
	GetCmdArg(4, arg4, sizeof(arg4));
	int timer = StringToInt(arg4);
	char arg3[32];
	GetCmdArg(3, arg3, sizeof(arg3));
	int count = StringToInt(arg3);
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
			g_bAmmoMenu[client] = true;
			g_bAdminMenu[client] = false;
			vPlayerMenu(client);
		}
		return Plugin_Handled;
	}
	else if (timer > 1 || count < 0 || toggle > 1 || args > 4)
	{
		ReplyToCommand(client, "%s Usage: ass_ammo <#userid|name> <0: off|1: on> <count >= 0> <0: once|1: repeat>", ASS_PREFIX01);
		return Plugin_Handled;
	}
	char sTarget[32];
	GetCmdArg(1, sTarget, sizeof(sTarget));
	if (!bSelectTarget(sTarget, client, toggle, count, timer, 0.0, 0.0, ""))
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
			vAmmoSpeedrunners(target_list[iPlayer], client, toggle, true, count, timer);
		}
		ShowActivity2(client, ASS_PREFIX2, "Used \"ass_ammo\" on %s.", target_name);
	}
	g_bAmmoMenu[client] = true;
	g_bAdminMenu[client] = false;
	return Plugin_Handled;
}

void vSetAmmo(int client, int count)
{
	if (GetPlayerWeaponSlot(client, 0) > 0)
	{
		char sWeapon[32];
		int iActiveWeapon = GetEntPropEnt(client, Prop_Data, "m_hActiveWeapon");
		GetEntityClassname(iActiveWeapon, sWeapon, sizeof(sWeapon));
		if (IsValidEntity(iActiveWeapon))
		{
			if (bIsL4D2Game())
			{
				if (StrEqual(sWeapon, "weapon_rifle", false) || StrEqual(sWeapon, "weapon_rifle_desert", false) || StrEqual(sWeapon, "weapon_rifle_ak47", false) || StrEqual(sWeapon, "weapon_rifle_sg552", false))
				{
					SetEntData(client, (FindDataMapInfo(client, "m_iAmmo") + 12), count);
				}
				else if (StrEqual(sWeapon, "weapon_smg", false) || StrEqual(sWeapon, "weapon_smg_silenced", false) || StrEqual(sWeapon, "weapon_smg_mp5", false))
				{
					SetEntData(client, (FindDataMapInfo(client, "m_iAmmo") + 20), count);
				}
				else if (StrEqual(sWeapon, "weapon_pumpshotgun", false) || StrEqual(sWeapon, "weapon_shotgun_chrome", false))
				{
					SetEntData(client, (FindDataMapInfo(client, "m_iAmmo") + 28), count);
				}
				else if (StrEqual(sWeapon, "weapon_autoshotgun", false) || StrEqual(sWeapon, "weapon_shotgun_spas", false))
				{
					SetEntData(client, (FindDataMapInfo(client, "m_iAmmo") + 32), count);
				}
				else if (StrEqual(sWeapon, "weapon_hunting_rifle", false) || StrEqual(sWeapon, "weapon_sniper_scout", false))
				{
					SetEntData(client, (FindDataMapInfo(client, "m_iAmmo") + 36), count);
				}
				else if (StrEqual(sWeapon, "weapon_sniper_military", false) || StrEqual(sWeapon, "weapon_sniper_awp", false))
				{
					SetEntData(client, (FindDataMapInfo(client, "m_iAmmo") + 40), count);
				}
				else if (StrEqual(sWeapon, "weapon_grenade_launcher", false))
				{
					SetEntData(client, (FindDataMapInfo(client, "m_iAmmo") + 68), count);
				}
			}
			else
			{
				if (StrEqual(sWeapon, "weapon_hunting_rifle", false))
				{
					SetEntData(client, (FindDataMapInfo(client, "m_iAmmo") + 8), count);
				}
				else if (StrEqual(sWeapon, "weapon_rifle", false))
				{
					SetEntData(client, (FindDataMapInfo(client, "m_iAmmo") + 12), count);
				}
				else if (StrEqual(sWeapon, "weapon_smg", false))
				{
					SetEntData(client, (FindDataMapInfo(client, "m_iAmmo") + 20), count);
				}
				else if (StrEqual(sWeapon, "weapon_pumpshotgun", false) || StrEqual(sWeapon, "weapon_autoshotgun", false))
				{
					SetEntData(client, (FindDataMapInfo(client, "m_iAmmo") + 24), count);
				}
			}
		}
		SetEntProp(GetPlayerWeaponSlot(client, 0), Prop_Data, "m_iClip1", count, 1);
	}
}

void vAmmoSpeedrunners(int target, int client, int toggle, bool log = true, int count = 0, int timer = 0)
{
	if (bIsInfected(target))
	{
		return;
	}
	if (((bIsSurvivor(target) && g_cvASSCountBots.BoolValue) || (bIsHumanSurvivor(target) && !g_cvASSCountBots.BoolValue)))
	{
		switch (toggle)
		{
			case 0:
			{
				vKillAmmoTimer(target);
				if (bIsHumanSurvivor(target) && log)
				{
					bHasTranslationFile() ? PrintHintText(target, "%s %t", ASS_PREFIX, "AmmoNoInform") : PrintHintText(target, "%s You are not losing all of your ammo anymore!", ASS_PREFIX);
				}
				for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
				{
					if (bIsHumanSurvivor(iPlayer) && log)
					{
						bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "AmmoNoAnnounce", target) : PrintToChat(iPlayer, "%s %N is not losing all of their ammo anymore!", ASS_PREFIX01, target);
					}
				}
			}
			case 1:
			{
				if (g_bNull[target] || (g_cvASSAdminImmunity.BoolValue && bIsAdminAllowed(target)))
				{
					vKillAmmoTimer(target);
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
						vSetAmmo(target, count);
					}
					else
					{
						if (!g_bAmmo[target])
						{
							g_bAmmo[target] = true;
							if (g_hAmmoTimers[target] == null)
							{
								g_hAmmoTimers[target] = CreateTimer(0.1, tTimerAmmoSpeedrunners, target, TIMER_REPEAT);
							}
						}
					}
					if (bIsHumanSurvivor(target) && log)
					{
						bHasTranslationFile() ? PrintHintText(target, "%s %t", ASS_PREFIX, "AmmoInform") : PrintHintText(target, "%s You are losing all of your ammo!", ASS_PREFIX);
					}
					for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
					{
						if (bIsHumanSurvivor(iPlayer) && log)
						{
							bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "AmmoAnnounce", target) : PrintToChat(iPlayer, "%s %N is losing all of their ammo!", ASS_PREFIX01, target);
						}
					}
				}
			}
		}
		if (g_cvASSLogCommands.BoolValue && log)
		{
			LogAction(client, target, "%s \"%L\" used \"ass_ammo\" on \"%L\".", ASS_PREFIX, client, target);
		}
	}
}

void vKillAmmoTimer(int client)
{
	g_bAmmo[client] = false;
	if (g_hAmmoTimers[client] != null)
	{
		KillTimer(g_hAmmoTimers[client]);
		g_hAmmoTimers[client] = null;
	}
}

public Action tTimerAmmoSpeedrunners(Handle timer, any client)
{
	if (!IsClientInGame(client) || !IsPlayerAlive(client) || bIsPlayerIncapacitated(client))
	{
		vKillAmmoTimer(client);
		return Plugin_Handled;
	}
	vSetAmmo(client, 0);
	return Plugin_Continue;
}