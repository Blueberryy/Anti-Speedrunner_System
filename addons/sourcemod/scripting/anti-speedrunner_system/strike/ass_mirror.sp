// Mirror Option
public Action cmdASSMirror(int client, int args)
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
	if (!bIsSystemValid(g_cvASSGameMode, g_cvASSEnabledGameModes, g_cvASSDisabledGameModes, g_cvASSGameModeTypes))
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "MapModeNotSupported") : ReplyToCommand(client, "%s Map or game mode not supported.", ASS_PREFIX01);
		return Plugin_Handled;
	}
	if (!bIsHumanSurvivor(client))
	{
		bHasTranslationFile() ? ReplyToCommand(client, "%s %t", ASS_PREFIX01, "WrongTeam") : ReplyToCommand(client, "%s You must be on the survivor team to use this command.", ASS_PREFIX01);
		return Plugin_Handled;
	}
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
			g_bMirrorMenu[client] = true;
			g_bAdminMenu[client] = false;
			vPlayerMenu(client, 0);
		}
		return Plugin_Handled;
	}
	else if (toggle > 1 || args > 2)
	{
		ReplyToCommand(client, "%s Usage: ass_mirror <#userid|name> <0: off|1: on>", ASS_PREFIX01);
		return Plugin_Handled;
	}
	char sTarget[32];
	GetCmdArg(1, sTarget, sizeof(sTarget));
	if (!bSelectTarget(sTarget, client, toggle, 0, 0, 0.0, 0.0, ""))
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
			vMirrorSpeedrunners(target_list[iPlayer], client, toggle);
		}
		ShowActivity2(client, ASS_PREFIX2, "Used \"ass_mirror\" on %s.", target_name);
	}
	g_bMirrorMenu[client] = true;
	g_bAdminMenu[client] = false;
	return Plugin_Handled;
}

void vMirrorSpeedrunners(int target, int client, int toggle, bool log = true)
{
	if (bIsInfected(target))
	{
		return;
	}
	if (bIsHumanSurvivor(target))
	{
		switch (toggle)
		{
			case 0:
			{
				g_bMirror[target] = false;
				if (bIsHumanSurvivor(target) && log)
				{
					bHasTranslationFile() ? PrintHintText(target, "%s %t", ASS_PREFIX, "MirrorNoInform") : PrintHintText(target, "%s Your damage is not mirrored anymore!", ASS_PREFIX);
				}
				for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
				{
					if (bIsHumanSurvivor(iPlayer) && log)
					{
						bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "MirrorNoAnnounce", target) : PrintToChat(iPlayer, "%s %N's damage is not mirrored anymore!", ASS_PREFIX01, target);
					}
				}
			}
			case 1:
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
					if (!g_bMirror[target])
					{
						g_bMirror[target] = true;
						if (bIsHumanSurvivor(target) && log)
						{
							bHasTranslationFile() ? PrintHintText(target, "%s %t", ASS_PREFIX, "MirrorInform") : PrintHintText(target, "%s Your damage is mirrored!", ASS_PREFIX);
						}
						for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
						{
							if (bIsHumanSurvivor(iPlayer) && log)
							{
								bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "MirrorAnnounce", target) : PrintToChat(iPlayer, "%s %N's damage is mirrored!", ASS_PREFIX01, target);
							}
						}
					}
				}
			}
		}
		if (g_cvASSLogCommands.BoolValue && log)
		{
			LogAction(client, target, "%s \"%L\" used \"ass_mirror\" on \"%L\".", ASS_PREFIX, client, target);
		}
	}
}

public Action TraceAttack(int victim, int &attacker, int &inflictor, float &damage, int &damagetype, int &ammotype, int hitbox, int hitgroup)
{
	if (bIsSurvivor(attacker))
	{
		if (g_bMirror[attacker] && attacker != victim)
		{
			int iDamage = RoundFloat(damage);
			if (!IsClientConnected(attacker))
			{
				iDamage = 0;
				return Plugin_Changed;
			}
			int iHealth = GetClientHealth(attacker);
			if (iHealth > 0 && iHealth > iDamage)
			{
				SetEntityHealth(attacker, iHealth - iDamage);
				iDamage = 0;
				return Plugin_Changed;
			}
			else
			{
				GetEntityClassname(inflictor, g_sWeapon, sizeof(g_sWeapon));
				if (StrContains(g_sWeapon, "_projectile") > 0)
				{
					ReplaceString(g_sWeapon, sizeof(g_sWeapon), "_projectile", "", false);
					SetEntityHealth(attacker, 1);
					iDamage = 0;
					return Plugin_Changed;
				}
				else
				{
					GetClientWeapon(attacker, g_sWeapon, sizeof(g_sWeapon));
					ReplaceString(g_sWeapon, sizeof(g_sWeapon), "weapon_", "", false);
					hitgroup == 1 ? (g_bHeadshot[attacker] = true) : (g_bHeadshot[attacker] = false);
					SetEntityHealth(attacker, 1);
					iDamage = 0;
					return Plugin_Changed;
				}
			}
		}
	}
	return Plugin_Continue;
}