// Menu System
char g_sInfo[32];
char g_sMenuBuffer[255];
char g_sMenuOption[64];
int g_iTotalVotes;
int g_iVotes;

public void vAcidMenu(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
	switch (action)
	{
		case TopMenuAction_DisplayOption: bHasTranslationFile() ? Format(buffer, maxlength, "%T", "Acid", param) : Format(buffer, maxlength, "Acidity");
		case TopMenuAction_SelectOption:
		{
			if (bIsL4D2Game())
			{
				g_bAcidMenu[param] = true;
				g_bAdminMenu[param] = true;
				vPlayerMenu(param, 0);
			}
			else
			{
				g_tmASSMenu.Display(param, TopMenuPosition_LastCategory);
				bHasTranslationFile() ? PrintToChat(param, "%s %t", ASS_PREFIX01, "NotL4D2") : PrintToChat(param, "%s Available in Left 4 Dead 2 only.", ASS_PREFIX01);
			}
		}
	}
}

public void vAmmoMenu(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
	switch (action)
	{
		case TopMenuAction_DisplayOption: bHasTranslationFile() ? Format(buffer, maxlength, "%T", "Ammo", param) : Format(buffer, maxlength, "Ammunition");
		case TopMenuAction_SelectOption:
		{
			g_bAmmoMenu[param] = true;
			g_bAdminMenu[param] = true;
			vPlayerMenu(param, 0);
		}
	}
}

public void vBlindMenu(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
	switch (action)
	{
		case TopMenuAction_DisplayOption: bHasTranslationFile() ? Format(buffer, maxlength, "%T", "Blind", param) : Format(buffer, maxlength, "Blindness");
		case TopMenuAction_SelectOption:
		{
			g_bBlindMenu[param] = true;
			g_bAdminMenu[param] = true;
			vPlayerMenu(param, 0);
		}
	}
}

public void vChargeMenu(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
	switch (action)
	{
		case TopMenuAction_DisplayOption: bHasTranslationFile() ? Format(buffer, maxlength, "%T", "Charge", param) : Format(buffer, maxlength, "Charge");
		case TopMenuAction_SelectOption:
		{
			if (bIsL4D2Game())
			{
				g_bChargeMenu[param] = true;
				g_bAdminMenu[param] = true;
				vPlayerMenu(param, 0);
			}
			else
			{
				g_tmASSMenu.Display(param, TopMenuPosition_LastCategory);
				bHasTranslationFile() ? PrintToChat(param, "%s %t", ASS_PREFIX01, "NotL4D2") : PrintToChat(param, "%s Available in Left 4 Dead 2 only.", ASS_PREFIX01);
			}
		}
	}
}

public void vChaseMenu(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
	switch (action)
	{
		case TopMenuAction_DisplayOption: bHasTranslationFile() ? Format(buffer, maxlength, "%T", "Chase", param) : Format(buffer, maxlength, "Chase");
		case TopMenuAction_SelectOption:
		{
			g_bChaseMenu[param] = true;
			g_bAdminMenu[param] = true;
			vPlayerMenu(param, 0);
		}
	}
}

public void vCheckMenu(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
	switch (action)
	{
		case TopMenuAction_DisplayOption: bHasTranslationFile() ? Format(buffer, maxlength, "%T", "Check", param) : Format(buffer, maxlength, "Check");
		case TopMenuAction_SelectOption:
		{
			g_bCheckMenu[param] = true;
			g_bAdminMenu[param] = true;
			vPlayerMenu(param, 0);
		}
	}
}

public void vConfigMenu(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
	switch (action)
	{
		case TopMenuAction_DisplayOption: bHasTranslationFile() ? Format(buffer, maxlength, "%T", "Config", param) : Format(buffer, maxlength, "Configuration");
		case TopMenuAction_SelectOption:
		{
			g_bAdminMenu[param] = true;
			vConfigsMenu(param, 0);
		}
	}
}

public void vDisarmMenu(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
	switch (action)
	{
		case TopMenuAction_DisplayOption: bHasTranslationFile() ? Format(buffer, maxlength, "%T", "Disarm", param) : Format(buffer, maxlength, "Disarmament");
		case TopMenuAction_SelectOption:
		{
			g_bDisarmMenu[param] = true;
			g_bAdminMenu[param] = true;
			vPlayerMenu(param, 0);
		}
	}
}

public void vDoorMenu(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
	switch (action)
	{
		case TopMenuAction_DisplayOption: bHasTranslationFile() ? Format(buffer, maxlength, "%T", "Door", param) : Format(buffer, maxlength, "Door");
		case TopMenuAction_SelectOption:
		{
			g_bAdminMenu[param] = true;
			vDoorTypeMenu(param, 0);
		}
	}
}

public void vDrugMenu(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
	switch (action)
	{
		case TopMenuAction_DisplayOption: bHasTranslationFile() ? Format(buffer, maxlength, "%T", "Drug", param) : Format(buffer, maxlength, "Drug");
		case TopMenuAction_SelectOption:
		{
			g_bDrugMenu[param] = true;
			g_bAdminMenu[param] = true;
			vPlayerMenu(param, 0);
		}
	}
}

public void vEntryMenu(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
	switch (action)
	{
		case TopMenuAction_DisplayOption: bHasTranslationFile() ? Format(buffer, maxlength, "%T", "Entry", param) : Format(buffer, maxlength, "Entry");
		case TopMenuAction_SelectOption:
		{
			vEntry(param);
			ShowActivity2(param, ASS_PREFIX2, "Used \"ass_entry\".");
		}
	}
}

public void vExileMenu(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
	switch (action)
	{
		case TopMenuAction_DisplayOption: bHasTranslationFile() ? Format(buffer, maxlength, "%T", "Exile", param) : Format(buffer, maxlength, "Exile");
		case TopMenuAction_SelectOption:
		{
			g_bExileMenu[param] = true;
			g_bAdminMenu[param] = true;
			vExileModeMenu(param, 0);
		}
	}
}

public void vExplodeMenu(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
	switch (action)
	{
		case TopMenuAction_DisplayOption: bHasTranslationFile() ? Format(buffer, maxlength, "%T", "Explode", param) : Format(buffer, maxlength, "Explosion");
		case TopMenuAction_SelectOption:
		{
			g_bExplodeMenu[param] = true;
			g_bAdminMenu[param] = true;
			vPlayerMenu(param, 0);
		}
	}
}

public void vFireMenu(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
	switch (action)
	{
		case TopMenuAction_DisplayOption: bHasTranslationFile() ? Format(buffer, maxlength, "%T", "Fire", param) : Format(buffer, maxlength, "Fire");
		case TopMenuAction_SelectOption:
		{
			g_bFireMenu[param] = true;
			g_bAdminMenu[param] = true;
			vPlayerMenu(param, 0);
		}
	}
}

public void vFreezeMenu(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
	switch (action)
	{
		case TopMenuAction_DisplayOption: bHasTranslationFile() ? Format(buffer, maxlength, "%T", "Freeze", param) : Format(buffer, maxlength, "Freeze");
		case TopMenuAction_SelectOption:
		{
			g_bFreezeMenu[param] = true;
			g_bAdminMenu[param] = true;
			vPlayerMenu(param, 0);
		}
	}
}

public void vHealMenu(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
	switch (action)
	{
		case TopMenuAction_DisplayOption: bHasTranslationFile() ? Format(buffer, maxlength, "%T", "Heal", param) : Format(buffer, maxlength, "Health");
		case TopMenuAction_SelectOption:
		{
			g_bHealMenu[param] = true;
			g_bAdminMenu[param] = true;
			vPlayerMenu(param, 0);
		}
	}
}

public void vHurtMenu(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
	switch (action)
	{
		case TopMenuAction_DisplayOption: bHasTranslationFile() ? Format(buffer, maxlength, "%T", "Hurt", param) : Format(buffer, maxlength, "Hurt");
		case TopMenuAction_SelectOption:
		{
			g_bHurtMenu[param] = true;
			g_bAdminMenu[param] = true;
			vPlayerMenu(param, 0);
		}
	}
}

public void vIdleMenu(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
	switch (action)
	{
		case TopMenuAction_DisplayOption: bHasTranslationFile() ? Format(buffer, maxlength, "%T", "Idle", param) : Format(buffer, maxlength, "Idle");
		case TopMenuAction_SelectOption:
		{
			g_bIdleMenu[param] = true;
			g_bAdminMenu[param] = true;
			vPlayerMenu(param, 0);
		}
	}
}

public void vIncapMenu(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
	switch (action)
	{
		case TopMenuAction_DisplayOption: bHasTranslationFile() ? Format(buffer, maxlength, "%T", "Incap", param) : Format(buffer, maxlength, "Incapacitation");
		case TopMenuAction_SelectOption:
		{
			g_bIncapMenu[param] = true;
			g_bAdminMenu[param] = true;
			vPlayerMenu(param, 0);
		}
	}
}

public void vInvertMenu(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
	switch (action)
	{
		case TopMenuAction_DisplayOption: bHasTranslationFile() ? Format(buffer, maxlength, "%T", "Invert", param) : Format(buffer, maxlength, "Inversion");
		case TopMenuAction_SelectOption:
		{
			g_bInvertMenu[param] = true;
			g_bAdminMenu[param] = true;
			vPlayerMenu(param, 0);
		}
	}
}

public void vKeymanMenu(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
	switch (action)
	{
		case TopMenuAction_DisplayOption: bHasTranslationFile() ? Format(buffer, maxlength, "%T", "Keyman", param) : Format(buffer, maxlength, "Keyman");
		case TopMenuAction_SelectOption:
		{
			g_bKeymanMenu[param] = true;
			g_bAdminMenu[param] = true;
			vPlayerMenu(param, 0);
		}
	}
}

public void vMirrorMenu(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
	switch (action)
	{
		case TopMenuAction_DisplayOption: bHasTranslationFile() ? Format(buffer, maxlength, "%T", "Mirror", param) : Format(buffer, maxlength, "Mirror");
		case TopMenuAction_SelectOption:
		{
			g_bMirrorMenu[param] = true;
			g_bAdminMenu[param] = true;
			vPlayerMenu(param, 0);
		}
	}
}

public void vNullMenu(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
	switch (action)
	{
		case TopMenuAction_DisplayOption: bHasTranslationFile() ? Format(buffer, maxlength, "%T", "Null", param) : Format(buffer, maxlength, "Null");
		case TopMenuAction_SelectOption:
		{
			g_bNullMenu[param] = true;
			g_bAdminMenu[param] = true;
			vPlayerMenu(param, 0);
		}
	}
}

public void vPukeMenu(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
	switch (action)
	{
		case TopMenuAction_DisplayOption: bHasTranslationFile() ? Format(buffer, maxlength, "%T", "Puke", param) : Format(buffer, maxlength, "Puke");
		case TopMenuAction_SelectOption:
		{
			g_bPukeMenu[param] = true;
			g_bAdminMenu[param] = true;
			vPlayerMenu(param, 0);
		}
	}
}

public void vRestartMenu(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
	switch (action)
	{
		case TopMenuAction_DisplayOption: bHasTranslationFile() ? Format(buffer, maxlength, "%T", "Restart", param) : Format(buffer, maxlength, "Restart");
		case TopMenuAction_SelectOption:
		{
			g_bRestartMenu[param] = true;
			g_bAdminMenu[param] = true;
			vPlayerMenu(param, 0);
		}
	}
}

public void vRocketMenu(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
	switch (action)
	{
		case TopMenuAction_DisplayOption: bHasTranslationFile() ? Format(buffer, maxlength, "%T", "Rocket", param) : Format(buffer, maxlength, "Rocket");
		case TopMenuAction_SelectOption:
		{
			g_bRocketMenu[param] = true;
			g_bAdminMenu[param] = true;
			vPlayerMenu(param, 0);
		}
	}
}

public void vSaferoomMenu(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
	switch (action)
	{
		case TopMenuAction_DisplayOption: bHasTranslationFile() ? Format(buffer, maxlength, "%T", "Saferoom", param) : Format(buffer, maxlength, "Saferoom");
		case TopMenuAction_SelectOption:
		{
			g_bAdminMenu[param] = true;
			vSaferoomOptionMenu(param, 0);
		}
	}
}

public void vShakeMenu(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
	switch (action)
	{
		case TopMenuAction_DisplayOption: bHasTranslationFile() ? Format(buffer, maxlength, "%T", "Shake", param) : Format(buffer, maxlength, "Shake");
		case TopMenuAction_SelectOption:
		{
			g_bShakeMenu[param] = true;
			g_bAdminMenu[param] = true;
			vPlayerMenu(param, 0);
		}
	}
}

public void vShockMenu(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
	switch (action)
	{
		case TopMenuAction_DisplayOption: bHasTranslationFile() ? Format(buffer, maxlength, "%T", "Shock", param) : Format(buffer, maxlength, "Shock");
		case TopMenuAction_SelectOption:
		{
			g_bShockMenu[param] = true;
			g_bAdminMenu[param] = true;
			vPlayerMenu(param, 0);
		}
	}
}

public void vShoveMenu(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
	switch (action)
	{
		case TopMenuAction_DisplayOption: bHasTranslationFile() ? Format(buffer, maxlength, "%T", "Shove", param) : Format(buffer, maxlength, "Shove");
		case TopMenuAction_SelectOption:
		{
			g_bShoveMenu[param] = true;
			g_bAdminMenu[param] = true;
			vPlayerMenu(param, 0);
		}
	}
}

public void vSlowMenu(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
	switch (action)
	{
		case TopMenuAction_DisplayOption: bHasTranslationFile() ? Format(buffer, maxlength, "%T", "Slow", param) : Format(buffer, maxlength, "Slow");
		case TopMenuAction_SelectOption:
		{
			g_bSlowMenu[param] = true;
			g_bAdminMenu[param] = true;
			vPlayerMenu(param, 0);
		}
	}
}

public void vStrikeMenu(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
	switch (action)
	{
		case TopMenuAction_DisplayOption: bHasTranslationFile() ? Format(buffer, maxlength, "%T", "Strike", param) : Format(buffer, maxlength, "Strike");
		case TopMenuAction_SelectOption:
		{
			g_bStrikeMenu[param] = true;
			g_bAdminMenu[param] = true;
			vPlayerMenu(param, 0);
		}
	}
}

public void vVisionMenu(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
	switch (action)
	{
		case TopMenuAction_DisplayOption: bHasTranslationFile() ? Format(buffer, maxlength, "%T", "Vision", param) : Format(buffer, maxlength, "Vision");
		case TopMenuAction_SelectOption:
		{
			g_bVisionMenu[param] = true;
			g_bAdminMenu[param] = true;
			vPlayerMenu(param, 0);
		}
	}
}

public void vWarpMenu(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
	switch (action)
	{
		case TopMenuAction_DisplayOption: bHasTranslationFile() ? Format(buffer, maxlength, "%T", "Warp", param) : Format(buffer, maxlength, "Warp");
		case TopMenuAction_SelectOption:
		{
			g_bWarpMenu[param] = true;
			g_bAdminMenu[param] = true;
			vPlayerMenu(param, 0);
		}
	}
}

void vConfigsMenu(int client, int item)
{
	Menu mConfigMenu = new Menu(iConfigsMenuHandler, MENU_ACTIONS_DEFAULT|MenuAction_Display|MenuAction_DisplayItem);
	mConfigMenu.SetTitle("Choose a configuration mode:");
	g_bAdminMenu[client] ? (mConfigMenu.ExitBackButton = true) : (mConfigMenu.ExitBackButton = false);
	mConfigMenu.AddItem("Create", "Create");
	mConfigMenu.AddItem("Execute", "Execute");
	mConfigMenu.DisplayAt(client, item, MENU_TIME_FOREVER);
}

public int iConfigsMenuHandler(Menu menu, MenuAction action, int param1, int param2)
{
	switch (action)
	{
		case MenuAction_End: delete menu;
		case MenuAction_Cancel:
		{
			if (g_bAdminMenu[param1])
			{
				g_bAdminMenu[param1] = false;
				if (param2 == MenuCancel_ExitBack && g_tmASSMenu)
				{
					g_tmASSMenu.Display(param1, TopMenuPosition_LastCategory);
				}
			}
		}
		case MenuAction_Select:
		{
			switch (param2)
			{
				case 0: g_bConfigMode[param1] = false;
				case 1: g_bConfigMode[param1] = true;
			}
			if (IsClientInGame(param1) && !IsClientInKickQueue(param1))
			{
				vConfigsMenu2(param1, menu.Selection);
			}
		}
		case MenuAction_Display:
		{
			if (bHasTranslationFile())
			{
				Panel panel = view_as<Panel>(param2);
				Format(g_sMenuBuffer, sizeof(g_sMenuBuffer), "%T", "ChooseConfigMode", param1);
				panel.SetTitle(g_sMenuBuffer);
			}
		}
		case MenuAction_DisplayItem:
		{
			if (bHasTranslationFile())
			{
				menu.GetItem(param2, g_sInfo, sizeof(g_sInfo));
				if (StrEqual(g_sInfo, "Create"))
				{
					Format(g_sMenuOption, sizeof(g_sMenuOption), "%T", "Create", param1);
					return RedrawMenuItem(g_sMenuOption);
				}
				if (StrEqual(g_sInfo, "Execute"))
				{
					Format(g_sMenuOption, sizeof(g_sMenuOption), "%T", "Execute", param1);
					return RedrawMenuItem(g_sMenuOption);
				}
			}
		}
	}
	return 0;
}

void vConfigsMenu2(int client, int item)
{
	Menu mConfigMenu2 = new Menu(iConfigsMenuHandler2, MENU_ACTIONS_DEFAULT|MenuAction_Display|MenuAction_DisplayItem);
	mConfigMenu2.SetTitle("Choose a configuration type:");
	mConfigMenu2.ExitBackButton = true;
	mConfigMenu2.AddItem("Difficulty", "Difficulty");
	mConfigMenu2.AddItem("Map", "Map");
	mConfigMenu2.AddItem("Game mode", "GameMode");
	mConfigMenu2.AddItem("Daily", "Daily");
	mConfigMenu2.AddItem("Player count", "PlayerCount");
	mConfigMenu2.DisplayAt(client, item, MENU_TIME_FOREVER);
}

public int iConfigsMenuHandler2(Menu menu, MenuAction action, int param1, int param2)
{
	switch (action)
	{
		case MenuAction_End: delete menu;
		case MenuAction_Cancel: vConfigsMenu(param1, 0);
		case MenuAction_Select:
		{
			menu.GetItem(param2, g_sInfo, sizeof(g_sInfo));
			if (StrEqual(g_sInfo, "Difficulty"))
			{
				g_bConfigMode[param1] ? vManualConfig(param1, 1, 0) : vManualConfig(param1, 0, 0);
				ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_config\".");
			}
			else if (StrEqual(g_sInfo, "Map"))
			{
				g_bConfigMode[param1] ? vManualConfig(param1, 1, 1) : vManualConfig(param1, 0, 1);
				ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_config\".");
			}
			else if (StrEqual(g_sInfo, "Game mode"))
			{
				g_bConfigMode[param1] ? vManualConfig(param1, 1, 2) : vManualConfig(param1, 0, 2);
				ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_config\".");
			}
			else if (StrEqual(g_sInfo, "Daily"))
			{
				g_bConfigMode[param1] ? vManualConfig(param1, 1, 3) : vManualConfig(param1, 0, 3);
				ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_config\".");
			}
			else if (StrEqual(g_sInfo, "Player count"))
			{
				g_bConfigMode[param1] ? vManualConfig(param1, 1, 4) : vManualConfig(param1, 0, 4);
				ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_config\".");
			}
			if (IsClientInGame(param1) && !IsClientInKickQueue(param1))
			{
				vConfigsMenu(param1, menu.Selection);
			}
		}
		case MenuAction_Display:
		{
			if (bHasTranslationFile())
			{
				Panel panel = view_as<Panel>(param2);
				Format(g_sMenuBuffer, sizeof(g_sMenuBuffer), "%T", "ChooseConfigType", param1);
				panel.SetTitle(g_sMenuBuffer);
			}
		}
		case MenuAction_DisplayItem:
		{
			if (bHasTranslationFile())
			{
				menu.GetItem(param2, g_sInfo, sizeof(g_sInfo));
				if (StrEqual(g_sInfo, "Difficulty"))
				{
					Format(g_sMenuOption, sizeof(g_sMenuOption), "%T", "Difficulty", param1);
					return RedrawMenuItem(g_sMenuOption);
				}
				if (StrEqual(g_sInfo, "Map"))
				{
					Format(g_sMenuOption, sizeof(g_sMenuOption), "%T", "Map", param1);
					return RedrawMenuItem(g_sMenuOption);
				}
				if (StrEqual(g_sInfo, "Game mode"))
				{
					Format(g_sMenuOption, sizeof(g_sMenuOption), "%T", "GameMode", param1);
					return RedrawMenuItem(g_sMenuOption);
				}
				if (StrEqual(g_sInfo, "Daily"))
				{
					Format(g_sMenuOption, sizeof(g_sMenuOption), "%T", "Daily", param1);
					return RedrawMenuItem(g_sMenuOption);
				}
				if (StrEqual(g_sInfo, "Player count"))
				{
					Format(g_sMenuOption, sizeof(g_sMenuOption), "%T", "PlayerCount", param1);
					return RedrawMenuItem(g_sMenuOption);
				}
			}
		}
	}
	return 0;
}

void vExileModeMenu(int client, int item)
{
	Menu mExileMenu = new Menu(iExileMenuHandler, MENU_ACTIONS_DEFAULT|MenuAction_Display|MenuAction_DisplayItem);
	mExileMenu.SetTitle("Choose an exile mode:");
	g_bAdminMenu[client] ? (mExileMenu.ExitBackButton = true) : (mExileMenu.ExitBackButton = false);
	mExileMenu.AddItem("Kick", "Kick");
	mExileMenu.AddItem("Banishment", "Ban");
	mExileMenu.DisplayAt(client, item, MENU_TIME_FOREVER);
}

public int iExileMenuHandler(Menu menu, MenuAction action, int param1, int param2)
{
	switch (action)
	{
		case MenuAction_End: delete menu;
		case MenuAction_Cancel:
		{
			if (g_bAdminMenu[param1])
			{
				g_bAdminMenu[param1] = false;
				if (param2 == MenuCancel_ExitBack && g_tmASSMenu)
				{
					g_tmASSMenu.Display(param1, TopMenuPosition_LastCategory);
				}
			}
		}
		case MenuAction_Select:
		{
			switch (param2)
			{
				case 0: g_bExileMode[param1] = false;
				case 1: g_bExileMode[param1] = true;
			}
			if (IsClientInGame(param1) && !IsClientInKickQueue(param1))
			{
				vPlayerMenu(param1, menu.Selection);
			}
		}
		case MenuAction_Display:
		{
			if (bHasTranslationFile())
			{
				Panel panel = view_as<Panel>(param2);
				Format(g_sMenuBuffer, sizeof(g_sMenuBuffer), "%T", "ChooseExileMode", param1);
				panel.SetTitle(g_sMenuBuffer);
			}
		}
		case MenuAction_DisplayItem:
		{
			if (bHasTranslationFile())
			{
				menu.GetItem(param2, g_sInfo, sizeof(g_sInfo));
				if (StrEqual(g_sInfo, "Kick"))
				{
					Format(g_sMenuOption, sizeof(g_sMenuOption), "%T", "Kick", param1);
					return RedrawMenuItem(g_sMenuOption);
				}
				if (StrEqual(g_sInfo, "Banishment"))
				{
					Format(g_sMenuOption, sizeof(g_sMenuOption), "%T", "Ban", param1);
					return RedrawMenuItem(g_sMenuOption);
				}
			}
		}
	}
	return 0;
}

void vPlayerMenu(int client, int item)
{
	Menu mPlayerMenu = new Menu(iPlayerMenuHandler, MENU_ACTIONS_DEFAULT|MenuAction_Display|MenuAction_DrawItem);
	mPlayerMenu.SetTitle("Choose a player:");
	g_bAdminMenu[client] ? (mPlayerMenu.ExitBackButton = true) : (mPlayerMenu.ExitBackButton = false);
	AddTargetsToMenu(mPlayerMenu, client, true, true);
	mPlayerMenu.DisplayAt(client, item, MENU_TIME_FOREVER);
}

public int iPlayerMenuHandler(Menu menu, MenuAction action, int param1, int param2)
{
	switch (action)
	{
		case MenuAction_End: delete menu;
		case MenuAction_Cancel:
		{
			vResetPlayerMenu(param1);
			if (g_bAdminMenu[param1])
			{
				g_bAdminMenu[param1] = false;
				if (param2 == MenuCancel_ExitBack && g_tmASSMenu)
				{
					g_tmASSMenu.Display(param1, TopMenuPosition_LastCategory);
				}
			}
		}
		case MenuAction_DrawItem:
		{
			char sInfo[10];
			int iStyle;
			menu.GetItem(param2, sInfo, sizeof(sInfo), iStyle);
			int iTarget = GetClientOfUserId(StringToInt(sInfo));
			if ((g_cvASSCountBots.BoolValue && !bIsSurvivor(iTarget)) || (!g_cvASSCountBots.BoolValue && !bIsHumanSurvivor(iTarget)))
			{
				return ITEMDRAW_IGNORE;
			}
			return iStyle;
		}
		case MenuAction_Select:
		{
			char sInfo[32];
			menu.GetItem(param2, sInfo, sizeof(sInfo));
			int iTarget = GetClientOfUserId(StringToInt(sInfo));
			if (iTarget == 0)
			{
				PrintToChat(param1, "%s %t", ASS_PREFIX01, "Player no longer available");
			}
			else if (!CanUserTarget(param1, iTarget))
			{
				PrintToChat(param1, "%s %t", ASS_PREFIX01, "Unable to target");
			}
			else if (!IsPlayerAlive(iTarget))
			{
				PrintToChat(param1, "%s %t", ASS_PREFIX01, "Player has since died");
			}
			else
			{
				if (g_bAcidMenu[param1])
				{
					!g_bAcid[iTarget] ? vAcidSpeedrunners(iTarget, param1, 1, true, 1) : vAcidSpeedrunners(iTarget, param1, 0);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_acid\" on %N.", iTarget);
				}
				if (g_bAmmoMenu[param1])
				{
					!g_bAmmo[iTarget] ? vAmmoSpeedrunners(iTarget, param1, 1, true, 1) : vAmmoSpeedrunners(iTarget, param1, 0);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_ammo\" on %N.", iTarget);
				}
				if (g_bBlindMenu[param1])
				{
					!g_bBlind[iTarget] ? vBlindSpeedrunners(iTarget, param1, 1) : vBlindSpeedrunners(iTarget, param1, 0);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_blind\" on %N.", iTarget);
				}
				if (g_bChargeMenu[param1])
				{
					!g_bCharge[iTarget] ? vChargeSpeedrunners(iTarget, param1, 1, true, 1) : vChargeSpeedrunners(iTarget, param1, 0);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_charge\" on %N.", iTarget);
				}
				if (g_bChaseMenu[param1])
				{
					vChaseSpeedrunners(iTarget, param1);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_chase\" on %N.", iTarget);
				}
				if (g_bCheckMenu[param1])
				{
					!g_bCheck[iTarget] ? vCheckSpeedrunners(iTarget, param1, 1, true, 1) : vCheckSpeedrunners(iTarget, param1, 0);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_check\" on %N.", iTarget);
				}
				if (g_bDisarmMenu[param1])
				{
					!g_bDisarm[iTarget] ? vDisarmSpeedrunners(iTarget, param1, 1, true, g_iWeaponSlot[iTarget], 1) : vDisarmSpeedrunners(iTarget, param1, 0);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_disarm\" on %N.", iTarget);
				}
				if (g_bDrugMenu[param1])
				{
					!g_bDrug[iTarget] ? vDrugSpeedrunners(iTarget, param1, 1) : vDrugSpeedrunners(iTarget, param1, 0);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_drug\" on %N.", iTarget);
				}
				if (g_bExileMenu[param1])
				{
					!g_bExileMode[param1] ? vExileSpeedrunners(iTarget, param1, 0) : vExileSpeedrunners(iTarget, param1, 1);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_exile\" on %N.", iTarget);
				}
				if (g_bExplodeMenu[param1])
				{
					vExplodeSpeedrunners(iTarget, param1);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_explode\" on %N.", iTarget);
				}
				if (g_bFireMenu[param1])
				{
					!g_bFire[iTarget] ? vFireSpeedrunners(iTarget, param1, 1, true, 1) : vFireSpeedrunners(iTarget, param1, 0);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_fire\" on %N.", iTarget);
				}
				if (g_bFreezeMenu[param1])
				{
					!g_bFreeze[iTarget] ? vFreezeSpeedrunners(iTarget, param1, 1) : vFreezeSpeedrunners(iTarget, param1, 0);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_freeze\" on %N.", iTarget);
				}
				if (g_bHealMenu[param1])
				{
					vHealSpeedrunners(iTarget, param1);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_heal\" on %N.", iTarget);
				}
				if (g_bHurtMenu[param1])
				{
					!g_bHurt[iTarget] ? vHurtSpeedrunners(iTarget, param1, 1, true, g_cvASSHurtDamageAmount.IntValue, 1) : vHurtSpeedrunners(iTarget, param1, 0);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_hurt\" on %N.", iTarget);
				}
				if (g_bIdleMenu[param1])
				{
					vIdleSpeedrunners(iTarget, param1);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_idle\" on %N.", iTarget);
				}
				if (g_bIncapMenu[param1])
				{
					!g_bIncap[iTarget] ? vIncapSpeedrunners(iTarget, param1, 1, true, 1) : vIncapSpeedrunners(iTarget, param1, 0);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_incap\" on %N.", iTarget);
				}
				if (g_bInvertMenu[param1])
				{
					!g_bInvert[iTarget] ? vInvertSpeedrunners(iTarget, param1, 1) : vInvertSpeedrunners(iTarget, param1, 0);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_invert\" on %N.", iTarget);
				}
				if (g_bKeymanMenu[param1])
				{
					!g_bKeyman[iTarget] ? vSelectKeyman(iTarget, param1, 1) : vSelectKeyman(iTarget, param1, 0);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_key\" on %N.", iTarget);
				}
				if (g_bMirrorMenu[param1])
				{
					!g_bMirror[iTarget] ? vMirrorSpeedrunners(iTarget, param1, 1) : vMirrorSpeedrunners(iTarget, param1, 0);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_mirror\" on %N.", iTarget);
				}
				if (g_bNullMenu[param1])
				{
					!g_bNull[iTarget] ? vNullSpeedrunners(iTarget, param1, 1) : vNullSpeedrunners(iTarget, param1, 0);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_null\" on %N.", iTarget);
				}
				if (g_bPukeMenu[param1])
				{
					!g_bPuke[iTarget] ? vPukeSpeedrunners(iTarget, param1, 1, true, 1) : vPukeSpeedrunners(iTarget, param1, 0);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_puke\" on %N.", iTarget);
				}
				if (g_bRestartMenu[param1])
				{
					vRestartSpeedrunners(iTarget, param1);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_restart\" on %N.", iTarget);
				}
				if (g_bRocketMenu[param1])
				{
					vRocketSpeedrunners(iTarget, param1);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_rocket\" on %N.", iTarget);
				}
				if (g_bShakeMenu[param1])
				{
					!g_bShake[iTarget] ? vShakeSpeedrunners(iTarget, param1, 1, true, 1) : vShakeSpeedrunners(iTarget, param1, 0);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_shake\" on %N.", iTarget);
				}
				if (g_bShockMenu[param1])
				{
					vShockSpeedrunners(iTarget, param1);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_shock\" on %N.", iTarget);
				}
				if (g_bShoveMenu[param1])
				{
					!g_bShove[iTarget] ? vShoveSpeedrunners(iTarget, param1, 1, true, 1) : vShoveSpeedrunners(iTarget, param1, 0);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_shove\" on %N.", iTarget);
				}
				if (g_bSlowMenu[param1])
				{
					!g_bSlow[iTarget] ? vSlowSpeedrunners(iTarget, param1, 1) : vSlowSpeedrunners(iTarget, param1, 0);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_slow\" on %N.", iTarget);
				}
				if (g_bStrikeMenu[param1])
				{
					vStrikeSpeedrunners(iTarget, param1);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_strike\" on %N.", iTarget);
				}
				if (g_bVisionMenu[param1])
				{
					!g_bVision[iTarget] ? vVisionSpeedrunners(iTarget, param1, 1, true, 160, 1) : vVisionSpeedrunners(iTarget, param1, 0);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_vision\" on %N.", iTarget);
				}
				if (g_bWarpMenu[param1])
				{
					vWarpSpeedrunners(iTarget, param1);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_warp\" on %N.", iTarget);
				}
			}
			if (IsClientInGame(param1) && !IsClientInKickQueue(param1))
			{
				vPlayerMenu(param1, menu.Selection);
			}
		}
		case MenuAction_Display:
		{
			if (bHasTranslationFile())
			{
				Panel panel = view_as<Panel>(param2);
				Format(g_sMenuBuffer, sizeof(g_sMenuBuffer), "%T", "ChoosePlayer", param1);
				panel.SetTitle(g_sMenuBuffer);
			}
		}
	}
	return 0;
}

void vDoorTypeMenu(int client, int item)
{
	Menu mTypeMenu = new Menu(iTypeMenuHandler, MENU_ACTIONS_DEFAULT|MenuAction_Display|MenuAction_DisplayItem);
	mTypeMenu.SetTitle("Door type");
	mTypeMenu.AddItem("Starting door", "StartDoor");
	mTypeMenu.AddItem("Ending door", "EndDoor");
	g_bAdminMenu[client] ? (mTypeMenu.ExitBackButton = true) : (mTypeMenu.ExitBackButton = false);
	mTypeMenu.DisplayAt(client, item, MENU_TIME_FOREVER);
}

public int iTypeMenuHandler(Menu menu, MenuAction action, int param1, int param2)
{
	switch (action)
	{
		case MenuAction_End: delete menu;
		case MenuAction_Cancel:
		{
			if (g_bAdminMenu[param1])
			{
				g_bAdminMenu[param1] = false;
				if (param2 == MenuCancel_ExitBack && g_tmASSMenu)
				{
					g_tmASSMenu.Display(param1, TopMenuPosition_LastCategory);
				}
			}
		}
		case MenuAction_Select:
		{
			switch (param2)
			{
				case 0: g_bDoorType[param1] = false;
				case 1: g_bDoorType[param1] = true;
			}
			vDoorControlMenu(param1, menu.Selection);
		}
		case MenuAction_Display:
		{
			if (bHasTranslationFile())
			{
				Panel panel = view_as<Panel>(param2);
				Format(g_sMenuBuffer, sizeof(g_sMenuBuffer), "%T", "DoorType", param1);
				panel.SetTitle(g_sMenuBuffer);
			}
		}
		case MenuAction_DisplayItem:
		{
			if (bHasTranslationFile())
			{
				menu.GetItem(param2, g_sInfo, sizeof(g_sInfo));
				if (StrEqual(g_sInfo, "Starting door"))
				{
					Format(g_sMenuOption, sizeof(g_sMenuOption), "%T", "StartDoor", param1);
					return RedrawMenuItem(g_sMenuOption);
				}
				if (StrEqual(g_sInfo, "Ending door"))
				{
					Format(g_sMenuOption, sizeof(g_sMenuOption), "%T", "EndDoor", param1);
					return RedrawMenuItem(g_sMenuOption);
				}
			}
		}
	}
	return 0;
}

void vDoorControlMenu(int client, int item)
{
	Menu mDoorMenu = new Menu(iDoorMenuHandler, MENU_ACTIONS_DEFAULT|MenuAction_Display|MenuAction_DisplayItem);
	mDoorMenu.SetTitle("Lock/Unlock");
	mDoorMenu.AddItem("Lock", "Lock");
	mDoorMenu.AddItem("Unlock", "Unlock");
	mDoorMenu.ExitBackButton = true;
	mDoorMenu.DisplayAt(client, item, MENU_TIME_FOREVER);
}

public int iDoorMenuHandler(Menu menu, MenuAction action, int param1, int param2)
{
	switch (action)
	{
		case MenuAction_End: delete menu;
		case MenuAction_Cancel: vDoorTypeMenu(param1, 0);
		case MenuAction_Select:
		{
			menu.GetItem(param2, g_sInfo, sizeof(g_sInfo));
			if (StrEqual(g_sInfo, "Lock"))
			{
				bHasTranslationFile() ? PrintToChat(param1, "%s %t", ASS_PREFIX01, "Locked") : PrintToChat(param1, "%s Ending saferoom door forcefully locked.", ASS_PREFIX01);
				if (g_bDoorType[param1])
				{
					vEDoorControl(g_iDoorId2, true);
					vResetVoteMenus();
				}
				else
				{
					vSDoorControl(g_iDoorId, true);
				}
				ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_door\".");
			}
			else if (StrEqual(g_sInfo, "Unlock"))
			{
				bHasTranslationFile() ? PrintToChat(param1, "%s %t", ASS_PREFIX01, "Unlocked") : PrintToChat(param1, "%s Ending saferoom door forcefully unlocked.", ASS_PREFIX01);
				if (g_bDoorType[param1])
				{
					vEDoorControl(g_iDoorId2, false);
					vResetVoteMenus();
				}
				else
				{
					vSDoorControl(g_iDoorId, false);
				}
				ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_door\".");
			}
			if (IsClientInGame(param1) && !IsClientInKickQueue(param1))
			{
				vDoorTypeMenu(param1, menu.Selection);
			}
		}
		case MenuAction_Display:
		{
			if (bHasTranslationFile())
			{
				Panel panel = view_as<Panel>(param2);
				Format(g_sMenuBuffer, sizeof(g_sMenuBuffer), "%T", "ControlDoor", param1);
				panel.SetTitle(g_sMenuBuffer);
			}
		}
		case MenuAction_DisplayItem:
		{
			if (bHasTranslationFile())
			{
				menu.GetItem(param2, g_sInfo, sizeof(g_sInfo));
				if (StrEqual(g_sInfo, "Lock"))
				{
					Format(g_sMenuOption, sizeof(g_sMenuOption), "%T", "Lock", param1);
					return RedrawMenuItem(g_sMenuOption);
				}
				if (StrEqual(g_sInfo, "Unlock"))
				{
					Format(g_sMenuOption, sizeof(g_sMenuOption), "%T", "Unlock", param1);
					return RedrawMenuItem(g_sMenuOption);
				}
			}
		}
	}
	return 0;
}

void vSaferoomOptionMenu(int client, int item)
{
	Menu mSaferoomMenu = new Menu(iSaferoomMenuHandler, MENU_ACTIONS_DEFAULT|MenuAction_Display|MenuAction_DisplayItem);
	mSaferoomMenu.SetTitle("Which method of entry do you prefer?");
	mSaferoomMenu.AddItem("Boss", "Boss");
	mSaferoomMenu.AddItem("Filter", "Filter");
	mSaferoomMenu.AddItem("Group", "Group");
	mSaferoomMenu.AddItem("Keyman", "Keyman");
	mSaferoomMenu.AddItem("Lockdown", "Lockdown");
	mSaferoomMenu.AddItem("None", "None");
	g_bAdminMenu[client] ? (mSaferoomMenu.ExitBackButton = true) : (mSaferoomMenu.ExitBackButton = false);
	mSaferoomMenu.DisplayAt(client, item, MENU_TIME_FOREVER);
}

public int iSaferoomMenuHandler(Menu menu, MenuAction action, int param1, int param2)
{
	switch (action)
	{
		case MenuAction_End: delete menu;
		case MenuAction_Cancel:
		{
			if (g_bAdminMenu[param1])
			{
				g_bAdminMenu[param1] = false;
				if (param2 == MenuCancel_ExitBack && g_tmASSMenu)
				{
					g_tmASSMenu.Display(param1, TopMenuPosition_LastCategory);
				}
			}
		}
		case MenuAction_Select:
		{
			g_cvASSSaferoomSystemOptions.GetString(g_sSaferoomOption, sizeof(g_sSaferoomOption));
			g_cvASSLockdownDoorType.GetString(g_sLockdownType, sizeof(g_sLockdownType));
			menu.GetItem(param2, g_sInfo, sizeof(g_sInfo));
			if (StrEqual(g_sInfo, "Boss"))
			{
				if (StrContains(g_sSaferoomOption, "b", false) != -1)
				{
					g_bBossStarted = true;
					vEDoorControl(g_iDoorId2, true);
				}
				else
				{
					bHasTranslationFile() ? PrintToChat(param1, "%s %t", ASS_PREFIX01, "BossOff") : PrintToChat(param1, "%s Boss disabled.", ASS_PREFIX01);
				}
				vFilterSettings();
				vGroupSettings();
				vKeymanSettings();
				vLockdownSettings();
				vEntryModeSettings();
				ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_room\".");
			}
			else if (StrEqual(g_sInfo, "Filter"))
			{
				if (StrContains(g_sSaferoomOption, "f", false) != -1)
				{
					g_bFilterStarted = true;
					vEDoorControl(g_iDoorId2, true);
				}
				else
				{
					bHasTranslationFile() ? PrintToChat(param1, "%s %t", ASS_PREFIX01, "FilterOff") : PrintToChat(param1, "%s Filter disabled.", ASS_PREFIX01);
				}
				vBossSettings();
				vGroupSettings();
				vKeymanSettings();
				vLockdownSettings();
				vEntryModeSettings();
				ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_room\".");
			}
			else if (StrEqual(g_sInfo, "Group"))
			{
				if (StrContains(g_sSaferoomOption, "g", false) != -1)
				{
					g_bGroupStarted = true;
					vEDoorControl(g_iDoorId2, true);
				}
				else
				{
					bHasTranslationFile() ? PrintToChat(param1, "%s %t", ASS_PREFIX01, "GroupOff") : PrintToChat(param1, "%s Group disabled.", ASS_PREFIX01);
				}
				vBossSettings();
				vFilterSettings();
				vKeymanSettings();
				vLockdownSettings();
				vEntryModeSettings();
				ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_room\".");
			}
			else if (StrEqual(g_sInfo, "Keyman"))
			{
				if (StrContains(g_sSaferoomOption, "k", false) != -1)
				{
					g_bKeymanStarted = true;
					vEDoorControl(g_iDoorId2, true);
				}
				else
				{
					bHasTranslationFile() ? PrintToChat(param1, "%s %t", ASS_PREFIX01, "KeymanOff") : PrintToChat(param1, "%s Keyman disabled.", ASS_PREFIX01);
				}
				vBossSettings();
				vFilterSettings();
				vGroupSettings();
				vLockdownSettings();
				vEntryModeSettings();
				ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_room\".");
			}
			else if (StrEqual(g_sInfo, "Lockdown"))
			{
				if (StrContains(g_sSaferoomOption, "l", false) != -1 && StrContains(g_sLockdownType, "2", false) != -1)
				{
					g_bLockdownStarted2 = true;
					vEDoorControl(g_iDoorId2, true);
				}
				else
				{
					bHasTranslationFile() ? PrintToChat(param1, "%s %t", ASS_PREFIX01, "LockdownOff") : PrintToChat(param1, "%s Lockdown disabled.", ASS_PREFIX01);
				}
				vBossSettings();
				vFilterSettings();
				vGroupSettings();
				vKeymanSettings();
				vEntryModeSettings();
				ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_room\".");
			}
			else if (StrEqual(g_sInfo, "None"))
			{
				vEDoorControl(g_iDoorId2, false);
				vBossSettings();
				vFilterSettings();
				vGroupSettings();
				vKeymanSettings();
				vEntryModeSettings();
				ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_room\".");
			}
			if (IsClientInGame(param1) && !IsClientInKickQueue(param1))
			{
				vSaferoomOptionMenu(param1, menu.Selection);
			}
		}
		case MenuAction_Display:
		{
			if (bHasTranslationFile())
			{
				Panel panel = view_as<Panel>(param2);
				Format(g_sMenuBuffer, sizeof(g_sMenuBuffer), "%T", "ChooseOption", param1);
				panel.SetTitle(g_sMenuBuffer);
			}
		}
		case MenuAction_DisplayItem:
		{
			if (bHasTranslationFile())
			{
				menu.GetItem(param2, g_sInfo, sizeof(g_sInfo));
				if (StrEqual(g_sInfo, "Boss"))
				{
					Format(g_sMenuOption, sizeof(g_sMenuOption), "%T", "Boss", param1);
					return RedrawMenuItem(g_sMenuOption);
				}
				if (StrEqual(g_sInfo, "Filter"))
				{
					Format(g_sMenuOption, sizeof(g_sMenuOption), "%T", "Filter", param1);
					return RedrawMenuItem(g_sMenuOption);
				}
				if (StrEqual(g_sInfo, "Group"))
				{
					Format(g_sMenuOption, sizeof(g_sMenuOption), "%T", "Group", param1);
					return RedrawMenuItem(g_sMenuOption);
				}
				if (StrEqual(g_sInfo, "Keyman"))
				{
					Format(g_sMenuOption, sizeof(g_sMenuOption), "%T", "Keyman", param1);
					return RedrawMenuItem(g_sMenuOption);
				}
				if (StrEqual(g_sInfo, "Lockdown"))
				{
					Format(g_sMenuOption, sizeof(g_sMenuOption), "%T", "Lockdown", param1);
					return RedrawMenuItem(g_sMenuOption);
				}
				if (StrEqual(g_sInfo, "None"))
				{
					Format(g_sMenuOption, sizeof(g_sMenuOption), "%T", "None", param1);
					return RedrawMenuItem(g_sMenuOption);
				}
			}
		}
	}
	return 0;
}

void vBFGKLVoteMenu()
{
	int iBFGKLHumanSurvivors[MAXPLAYERS + 1];
	int iBFGKLTotalHumans;
	for (int iVoter = 1; iVoter <= MaxClients; iVoter++)
	{
		if (!bIsHumanSurvivor(iVoter))
		{
			continue;
		}
		iBFGKLHumanSurvivors[iBFGKLTotalHumans++] = iVoter;
	}
	vResetVoteCounts();
	Menu mBFGKLVoteMenu = new Menu(iBFGKLVoteMenuHandler, MENU_ACTIONS_DEFAULT|MenuAction_Display|MenuAction_DisplayItem|MenuAction_VoteEnd);
	mBFGKLVoteMenu.SetTitle("Which method of entry do you prefer?");
	mBFGKLVoteMenu.AddItem("Boss", "Boss");
	mBFGKLVoteMenu.AddItem("Filter", "Filter");
	mBFGKLVoteMenu.AddItem("Group", "Group");
	mBFGKLVoteMenu.AddItem("Keyman", "Keyman");
	mBFGKLVoteMenu.AddItem("Lockdown", "Lockdown");
	mBFGKLVoteMenu.AddItem("None", "None");
	mBFGKLVoteMenu.ExitButton = false;
	mBFGKLVoteMenu.DisplayVote(iBFGKLHumanSurvivors, iBFGKLTotalHumans, 10);
}

public int iBFGKLVoteMenuHandler(Menu menu, MenuAction action, int param1, int param2)
{
	switch (action)
	{
		case MenuAction_End:
		{
			delete menu;
			if (!g_bBFGKLVoted)
			{
				vNobodyVoted(g_iVotes, g_iTotalVotes);
				g_cvASSSaferoomEntryMode.BoolValue ? vNoneOption(g_iDoorId2, true) : vEntryCommand();
			}
		}
		case MenuAction_VoteEnd:
		{
			g_cvASSSaferoomSystemOptions.GetString(g_sSaferoomOption, sizeof(g_sSaferoomOption));
			g_cvASSLockdownDoorType.GetString(g_sLockdownType, sizeof(g_sLockdownType));
			GetMenuVoteInfo(param2, g_iVotes, g_iTotalVotes);
			if (g_iTotalVotes != iGetHumanCount())
			{
				for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
				{
					if (bIsHumanSurvivor(iPlayer))
					{
						bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "NoVotes", g_iTotalVotes, iGetHumanCount()) : PrintToChat(iPlayer, "%s Only %d/%d players voted.", ASS_PREFIX01, g_iTotalVotes, iGetHumanCount());
					}
				}
			}
			menu.GetItem(param1, g_sInfo, sizeof(g_sInfo));
			if (StrEqual(g_sInfo, "Boss"))
			{
				g_bBFGKLVoted = true;
				if (StrContains(g_sSaferoomOption, "b", false) != -1)
				{
					g_bBossStarted = true;
				}
				else
				{
					for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
					{
						if (bIsHumanSurvivor(iPlayer))
						{
							bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "BossOff") : PrintToChat(iPlayer, "%s Boss disabled.", ASS_PREFIX01);
						}
					}
					g_cvASSSaferoomEntryMode.BoolValue ? vNoneOption(g_iDoorId2, true) : vEntryCommand();
				}
				for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
				{
					if (bIsHumanSurvivor(iPlayer))
					{
						bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "VotedBoss", g_iVotes, g_iTotalVotes) : PrintToChat(iPlayer, "%s %d/%d voted for Boss.", ASS_PREFIX01, g_iVotes, g_iTotalVotes);
					}
				}
			}
			else if (StrEqual(g_sInfo, "Filter"))
			{
				g_bBFGKLVoted = true;
				if (StrContains(g_sSaferoomOption, "f", false) != -1)
				{
					g_bFilterStarted = true;
				}
				else
				{
					for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
					{
						if (bIsHumanSurvivor(iPlayer))
						{
							bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "FilterOff") : PrintToChat(iPlayer, "%s Filter disabled.", ASS_PREFIX01);
						}
					}
					g_cvASSSaferoomEntryMode.BoolValue ? vNoneOption(g_iDoorId2, true) : vEntryCommand();
				}
				for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
				{
					if (bIsHumanSurvivor(iPlayer))
					{
						bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "VotedFilter", g_iVotes, g_iTotalVotes) : PrintToChat(iPlayer, "%s %d/%d voted for Filter.", ASS_PREFIX01, g_iVotes, g_iTotalVotes);
					}
				}
			}
			else if (StrEqual(g_sInfo, "Group"))
			{
				g_bBFGKLVoted = true;
				if (StrContains(g_sSaferoomOption, "g", false) != -1)
				{
					g_bGroupStarted = true;
				}
				else
				{
					for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
					{
						if (bIsHumanSurvivor(iPlayer))
						{
							bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "GroupOff") : PrintToChat(iPlayer, "%s Group disabled.", ASS_PREFIX01);
						}
					}
					g_cvASSSaferoomEntryMode.BoolValue ? vNoneOption(g_iDoorId2, true) : vEntryCommand();
				}
				for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
				{
					if (bIsHumanSurvivor(iPlayer))
					{
						bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "VotedGroup", g_iVotes, g_iTotalVotes) : PrintToChat(iPlayer, "%s %d/%d voted for Group.", ASS_PREFIX01, g_iVotes, g_iTotalVotes);
					}
				}
			}
			else if (StrEqual(g_sInfo, "Keyman"))
			{
				g_bBFGKLVoted = true;
				if (StrContains(g_sSaferoomOption, "k", false) != -1)
				{
					g_bKeymanStarted = true;
				}
				else
				{
					for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
					{
						if (bIsHumanSurvivor(iPlayer))
						{
							bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "KeymanOff") : PrintToChat(iPlayer, "%s Keyman disabled.", ASS_PREFIX01);
						}
					}
					g_cvASSSaferoomEntryMode.BoolValue ? vNoneOption(g_iDoorId2, true) : vEntryCommand();
				}
				for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
				{
					if (bIsHumanSurvivor(iPlayer))
					{
						bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "VotedKeyman", g_iVotes, g_iTotalVotes) : PrintToChat(iPlayer, "%s %d/%d voted for Keyman.", ASS_PREFIX01, g_iVotes, g_iTotalVotes);
					}
				}
			}
			else if (StrEqual(g_sInfo, "Lockdown"))
			{
				g_bBFGKLVoted = true;
				if (StrContains(g_sSaferoomOption, "l", false) != -1 && StrContains(g_sLockdownType, "2", false) != -1)
				{
					g_bLockdownStarted2 = true;
				}
				else
				{
					for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
					{
						if (bIsHumanSurvivor(iPlayer))
						{
							bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "LockdownOff") : PrintToChat(iPlayer, "%s Lockdown disabled.", ASS_PREFIX01);
						}
					}
					g_cvASSSaferoomEntryMode.BoolValue ? vNoneOption(g_iDoorId2, true) : vEntryCommand();
				}
				for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
				{
					if (bIsHumanSurvivor(iPlayer))
					{
						bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "VotedLockdown", g_iVotes, g_iTotalVotes) : PrintToChat(iPlayer, "%s %d/%d voted for Lockdown.", ASS_PREFIX01, g_iVotes, g_iTotalVotes);
					}
				}
			}
			else if (StrEqual(g_sInfo, "None"))
			{
				g_bBFGKLVoted = true;
				g_cvASSSaferoomEntryMode.BoolValue ? vNoneOption(g_iDoorId2, true) : vEntryCommand();
				for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
				{
					if (bIsHumanSurvivor(iPlayer))
					{
						bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "VotedNone", g_iVotes, g_iTotalVotes) : PrintToChat(iPlayer, "%s %d/%d voted for None.", ASS_PREFIX01, g_iVotes, g_iTotalVotes);
					}
				}
			}
		}
		case MenuAction_Display:
		{
			if (bHasTranslationFile())
			{
				Panel panel = view_as<Panel>(param2);
				Format(g_sMenuBuffer, sizeof(g_sMenuBuffer), "%T", "ChooseOption", param1);
				panel.SetTitle(g_sMenuBuffer);
			}
		}
		case MenuAction_DisplayItem:
		{
			if (bHasTranslationFile())
			{
				menu.GetItem(param2, g_sInfo, sizeof(g_sInfo));
				if (StrEqual(g_sInfo, "Boss"))
				{
					Format(g_sMenuOption, sizeof(g_sMenuOption), "%T", "Boss", param1);
					return RedrawMenuItem(g_sMenuOption);
				}
				if (StrEqual(g_sInfo, "Filter"))
				{
					Format(g_sMenuOption, sizeof(g_sMenuOption), "%T", "Filter", param1);
					return RedrawMenuItem(g_sMenuOption);
				}
				if (StrEqual(g_sInfo, "Group"))
				{
					Format(g_sMenuOption, sizeof(g_sMenuOption), "%T", "Group", param1);
					return RedrawMenuItem(g_sMenuOption);
				}
				if (StrEqual(g_sInfo, "Keyman"))
				{
					Format(g_sMenuOption, sizeof(g_sMenuOption), "%T", "Keyman", param1);
					return RedrawMenuItem(g_sMenuOption);
				}
				if (StrEqual(g_sInfo, "Lockdown"))
				{
					Format(g_sMenuOption, sizeof(g_sMenuOption), "%T", "Lockdown", param1);
					return RedrawMenuItem(g_sMenuOption);
				}
				if (StrEqual(g_sInfo, "None"))
				{
					Format(g_sMenuOption, sizeof(g_sMenuOption), "%T", "None", param1);
					return RedrawMenuItem(g_sMenuOption);
				}
			}
		}
	}
	return 0;
}

void vLockdownVoteMenu()
{
	int iLockdownHumanSurvivors[MAXPLAYERS + 1];
	int iLockdownTotalHumans;
	for (int iVoter = 1; iVoter <= MaxClients; iVoter++)
	{
		if (!bIsHumanSurvivor(iVoter))
		{
			continue;
		}
		iLockdownHumanSurvivors[iLockdownTotalHumans++] = iVoter;
	}
	vResetVoteCounts();
	Menu mLockdownMenu = new Menu(iLockdownMenuHandler, MENU_ACTIONS_DEFAULT|MenuAction_Display|MenuAction_DisplayItem|MenuAction_VoteEnd);
	mLockdownMenu.SetTitle("Initiate a lockdown?");
	mLockdownMenu.AddItem("Yes", "Yes");
	mLockdownMenu.AddItem("No", "No");
	mLockdownMenu.ExitButton = false;
	mLockdownMenu.DisplayVote(iLockdownHumanSurvivors, iLockdownTotalHumans, 10);
}

public int iLockdownMenuHandler(Menu menu, MenuAction action, int param1, int param2)
{
	switch (action)
	{
		case MenuAction_End:
		{
			delete menu;
			if (!g_bLockdownVoted)
			{
				vNobodyVoted(g_iVotes, g_iTotalVotes);
				vNoneOption(g_iDoorId, false);
			}
		}
		case MenuAction_VoteEnd:
		{
			g_cvASSSaferoomSystemOptions.GetString(g_sSaferoomOption, sizeof(g_sSaferoomOption));
			g_cvASSLockdownDoorType.GetString(g_sLockdownType, sizeof(g_sLockdownType));
			GetMenuVoteInfo(param2, g_iVotes, g_iTotalVotes);
			if (g_iTotalVotes != iGetHumanCount())
			{
				for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
				{
					if (bIsHumanSurvivor(iPlayer))
					{
						bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "NoVotes", g_iTotalVotes, iGetHumanCount()) : PrintToChat(iPlayer, "%s Only %d/%d players voted.", ASS_PREFIX01, g_iTotalVotes, iGetHumanCount());
					}
				}
			}
			menu.GetItem(param1, g_sInfo, sizeof(g_sInfo));
			if (StrEqual(g_sInfo, "Yes"))
			{
				g_bLockdownVoted = true;
				if (StrContains(g_sSaferoomOption, "l", false) != -1 && StrContains(g_sLockdownType, "1", false) != -1)
				{
					g_bLockdownStarted = true;
				}
				else
				{
					for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
					{
						if (bIsHumanSurvivor(iPlayer))
						{
							bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "LockdownOff") : PrintToChat(iPlayer, "%s Lockdown disabled.", ASS_PREFIX01);
						}
					}
					vNoneOption(g_iDoorId, false);
				}
				for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
				{
					if (bIsHumanSurvivor(iPlayer))
					{
						bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "VotedYes", g_iVotes, g_iTotalVotes) : PrintToChat(iPlayer, "%s %d/%d voted Yes.", ASS_PREFIX01, g_iVotes, g_iTotalVotes);
					}
				}
			}
			else if (StrEqual(g_sInfo, "No"))
			{
				g_bLockdownVoted = true;
				for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
				{
					if (bIsHumanSurvivor(iPlayer))
					{
						bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "VotedNo", g_iVotes, g_iTotalVotes) : PrintToChat(iPlayer, "%s %d/%d voted No.", ASS_PREFIX01, g_iVotes, g_iTotalVotes);
					}
				}
				vNoneOption(g_iDoorId, false);
			}
		}
		case MenuAction_Display:
		{
			if (bHasTranslationFile())
			{
				Panel panel = view_as<Panel>(param2);
				Format(g_sMenuBuffer, sizeof(g_sMenuBuffer), "%T", "InitiateLockdown", param1);
				panel.SetTitle(g_sMenuBuffer);
			}
		}
		case MenuAction_DisplayItem:
		{
			menu.GetItem(param2, g_sInfo, sizeof(g_sInfo));
			if (StrEqual(g_sInfo, "Yes"))
			{
				Format(g_sMenuOption, sizeof(g_sMenuOption), "%T", "Yes", param1);
				return RedrawMenuItem(g_sMenuOption);
			}
			if (StrEqual(g_sInfo, "No"))
			{
				Format(g_sMenuOption, sizeof(g_sMenuOption), "%T", "No", param1);
				return RedrawMenuItem(g_sMenuOption);
			}
		}
	}
	return 0;
}

void vSelectTargetMenu(int client, int item)
{
	Menu mSelectTargetMenu = new Menu(iSelectTargetHandler, MENU_ACTIONS_DEFAULT|MenuAction_Display);
	mSelectTargetMenu.SetTitle("Choose a player:");
	for (int iTarget = 0; iTarget < g_iTargetCount; iTarget++)
	{
		char sName[32];
		GetClientName(g_iTargets[iTarget], sName, sizeof(sName));
		char sInfo[32];
		Format(sInfo, sizeof(sInfo), "%i", GetClientUserId(g_iTargets[iTarget]));
		mSelectTargetMenu.AddItem(sInfo, sName);
	}
	mSelectTargetMenu.DisplayAt(client, item, MENU_TIME_FOREVER);
}

bool bSelectTarget(const char[] targetname, int client, int toggle = 0, int cell1 = 0, int cell2 = 0, float value1 = 0.0, float value2 = 0.0, char[] string = "")
{
	g_iTargetCount = 0;
	for (int iTarget = 1; iTarget <= MaxClients; iTarget++)
	{
		if (!bIsSurvivor(iTarget))
		{
			continue;
		}
		char sName[32];
		GetClientName(iTarget, sName, sizeof(sName));
		if (StrContains(sName, targetname, false) != -1)
		{
			if ((!g_cvASSCountBots.BoolValue && !bIsHumanSurvivor(iTarget)) || (g_cvASSAdminImmunity.BoolValue && bIsAdminAllowed(iTarget)) || !CanUserTarget(client, iTarget))
			{
				continue;
			}
			g_iTargets[g_iTargetCount++] = iTarget;
		}
	}
	if (g_iTargetCount == 0)
	{
		vResetPlayerMenu(client);
		return false;
	}
	else if (g_iTargetCount == 1)
	{
		if (g_bAcidMenu[client])
		{
			vAcidSpeedrunners(g_iTargets[0], client, toggle, true, cell1);
			ShowActivity2(client, ASS_PREFIX2, "Used \"ass_acid\" on %N.", g_iTargets[0]);
		}
		if (g_bAmmoMenu[client])
		{
			vAmmoSpeedrunners(g_iTargets[0], client, toggle, true, cell1, cell2);
			ShowActivity2(client, ASS_PREFIX2, "Used \"ass_ammo\" on %N.", g_iTargets[0]);
		}
		if (g_bBlindMenu[client])
		{
			vBlindSpeedrunners(g_iTargets[0], client, toggle);
			ShowActivity2(client, ASS_PREFIX2, "Used \"ass_blind\" on %N.", g_iTargets[0]);
		}
		if (g_bChargeMenu[client])
		{
			vChargeSpeedrunners(g_iTargets[0], client, toggle, true, cell1);
			ShowActivity2(client, ASS_PREFIX2, "Used \"ass_charge\" on %N.", g_iTargets[0]);
		}
		if (g_bChaseMenu[client])
		{
			vChaseSpeedrunners(g_iTargets[0], client, true, cell1);
			ShowActivity2(client, ASS_PREFIX2, "Used \"ass_chase\" on %N.", g_iTargets[0]);
		}
		if (g_bCheckMenu[client])
		{
			vCheckSpeedrunners(g_iTargets[0], client, toggle, true, cell1);
			ShowActivity2(client, ASS_PREFIX2, "Used \"ass_check\" on %N.", g_iTargets[0]);
		}
		if (g_bDisarmMenu[client])
		{
			vDisarmSpeedrunners(g_iTargets[0], client, toggle, true, cell1, cell2);
			ShowActivity2(client, ASS_PREFIX2, "Used \"ass_disarm\" on %N.", g_iTargets[0]);
		}
		if (g_bDrugMenu[client])
		{
			vDrugSpeedrunners(g_iTargets[0], client, toggle);
			ShowActivity2(client, ASS_PREFIX2, "Used \"ass_drug\" on %N.", g_iTargets[0]);
		}
		if (g_bExileMenu[client])
		{
			vExileSpeedrunners(g_iTargets[0], client, toggle, true, cell1);
			ShowActivity2(client, ASS_PREFIX2, "Used \"ass_exile\" on %N.", g_iTargets[0]);
		}
		if (g_bExplodeMenu[client])
		{
			vExplodeSpeedrunners(g_iTargets[0], client);
			ShowActivity2(client, ASS_PREFIX2, "Used \"ass_explode\" on %N.", g_iTargets[0]);
		}
		if (g_bFireMenu[client])
		{
			vFireSpeedrunners(g_iTargets[0], client, toggle, true, cell1);
			ShowActivity2(client, ASS_PREFIX2, "Used \"ass_fire\" on %N.", g_iTargets[0]);
		}
		if (g_bFreezeMenu[client])
		{
			vFreezeSpeedrunners(g_iTargets[0], client, toggle);
			ShowActivity2(client, ASS_PREFIX2, "Used \"ass_freeze\" on %N.", g_iTargets[0]);
		}
		if (g_bHealMenu[client])
		{
			vHealSpeedrunners(g_iTargets[0], client);
			ShowActivity2(client, ASS_PREFIX2, "Used \"ass_heal\" on %N.", g_iTargets[0]);
		}
		if (g_bHurtMenu[client])
		{
			vHurtSpeedrunners(g_iTargets[0], client, toggle, true, cell1, cell2);
			ShowActivity2(client, ASS_PREFIX2, "Used \"ass_hurt\" on %N.", g_iTargets[0]);
		}
		if (g_bIdleMenu[client])
		{
			vIdleSpeedrunners(g_iTargets[0], client);
			ShowActivity2(client, ASS_PREFIX2, "Used \"ass_idle\" on %N.", g_iTargets[0]);
		}
		if (g_bIncapMenu[client])
		{
			vIncapSpeedrunners(g_iTargets[0], client, toggle, true, cell1);
			ShowActivity2(client, ASS_PREFIX2, "Used \"ass_incap\" on %N.", g_iTargets[0]);
		}
		if (g_bInvertMenu[client])
		{
			vInvertSpeedrunners(g_iTargets[0], client, toggle, true, cell1);
			ShowActivity2(client, ASS_PREFIX2, "Used \"ass_invert\" on %N.", g_iTargets[0]);
		}
		if (g_bKeymanMenu[client])
		{
			vSelectKeyman(g_iTargets[0], client, toggle);
			ShowActivity2(client, ASS_PREFIX2, "Used \"ass_key\" on %N.", g_iTargets[0]);
		}
		if (g_bMirrorMenu[client])
		{
			vMirrorSpeedrunners(g_iTargets[0], client, toggle);
			ShowActivity2(client, ASS_PREFIX2, "Used \"ass_mirror\" on %N.", g_iTargets[0]);
		}
		if (g_bNullMenu[client])
		{
			vNullSpeedrunners(g_iTargets[0], client, toggle);
			ShowActivity2(client, ASS_PREFIX2, "Used \"ass_null\" on %N.", g_iTargets[0]);
		}
		if (g_bPukeMenu[client])
		{
			vPukeSpeedrunners(g_iTargets[0], client, toggle, true, cell1);
			ShowActivity2(client, ASS_PREFIX2, "Used \"ass_puke\" on %N.", g_iTargets[0]);
		}
		if (g_bRestartMenu[client])
		{
			vRestartSpeedrunners(g_iTargets[0], client, true, string);
			ShowActivity2(client, ASS_PREFIX2, "Used \"ass_restart\" on %N.", g_iTargets[0]);
		}
		if (g_bRocketMenu[client])
		{
			vRocketSpeedrunners(g_iTargets[0], client, true, value1, value2);
			ShowActivity2(client, ASS_PREFIX2, "Used \"ass_rocket\" on %N.", g_iTargets[0]);
		}
		if (g_bShakeMenu[client])
		{
			vShakeSpeedrunners(g_iTargets[0], client, toggle, true, cell1);
			ShowActivity2(client, ASS_PREFIX2, "Used \"ass_shake\" on %N.", g_iTargets[0]);
		}
		if (g_bShockMenu[client])
		{
			vShockSpeedrunners(g_iTargets[0], client);
			ShowActivity2(client, ASS_PREFIX2, "Used \"ass_shock\" on %N.", g_iTargets[0]);
		}
		if (g_bShoveMenu[client])
		{
			vShoveSpeedrunners(g_iTargets[0], client, toggle, true, cell1);
			ShowActivity2(client, ASS_PREFIX2, "Used \"ass_shove\" on %N.", g_iTargets[0]);
		}
		if (g_bSlowMenu[client])
		{
			vSlowSpeedrunners(g_iTargets[0], client, toggle, true, value1);
			ShowActivity2(client, ASS_PREFIX2, "Used \"ass_slow\" on %N.", g_iTargets[0]);
		}
		if (g_bStrikeMenu[client])
		{
			vStrikeSpeedrunners(g_iTargets[0], client, true, cell1);
			ShowActivity2(client, ASS_PREFIX2, "Used \"ass_strike\" on %N.", g_iTargets[0]);
		}
		if (g_bVisionMenu[client])
		{
			vVisionSpeedrunners(g_iTargets[0], client, toggle, true, cell1, cell2);
			ShowActivity2(client, ASS_PREFIX2, "Used \"ass_vision\" on %N.", g_iTargets[0]);
		}
		if (g_bWarpMenu[client])
		{
			vWarpSpeedrunners(g_iTargets[0], client);
			ShowActivity2(client, ASS_PREFIX2, "Used \"ass_warp\" on %N.", g_iTargets[0]);
		}
	}
	else
	{
		g_flFloat1[g_iTargets[0]] = value1;
		g_flFloat2[g_iTargets[0]] = value2;
		g_iCell1[g_iTargets[0]] = cell1;
		g_iCell2[g_iTargets[0]] = cell2;
		for (int iPosition = 0; iPosition < strlen(string); iPosition++)
		{
			g_sString[g_iTargets[0]][iPosition] = string[iPosition];
		}
		vSelectTargetMenu(client, 0);
	}
	return true;
}

public int iSelectTargetHandler(Menu menu, MenuAction action, int param1, int param2)
{
	switch (action)
	{
		case MenuAction_End: delete menu;
		case MenuAction_Cancel: vResetPlayerMenu(param1);
		case MenuAction_Select:
		{
			char sUserIds[8];
			menu.GetItem(param2, sUserIds, sizeof(sUserIds));
			int iTarget = GetClientOfUserId(StringToInt(sUserIds));
			if (iTarget == 0)
			{
				PrintToChat(param1, "%s %t", ASS_PREFIX01, "Player no longer available");
			}
			else if (!CanUserTarget(param1, iTarget))
			{
				PrintToChat(param1, "%s %t", ASS_PREFIX01, "Unable to target");
			}
			else if (!IsPlayerAlive(iTarget))
			{
				PrintToChat(param1, "%s %t", ASS_PREFIX01, "Player has since died");
			}
			else
			{
				if (g_bAcidMenu[param1])
				{
					!g_bAcid[iTarget] ? vAcidSpeedrunners(iTarget, param1, 1, true, g_iCell1[iTarget]) : vAcidSpeedrunners(iTarget, param1, 0, true, g_iCell1[iTarget]);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_acid\" on %N.", iTarget);
				}
				if (g_bAmmoMenu[param1])
				{
					!g_bAmmo[iTarget] ? vAmmoSpeedrunners(iTarget, param1, 1, true, g_iCell1[iTarget], g_iCell2[iTarget]) : vAmmoSpeedrunners(iTarget, param1, 0, true, g_iCell1[iTarget], g_iCell2[iTarget]);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_ammo\" on %N.", iTarget);
				}
				if (g_bBlindMenu[param1])
				{
					!g_bBlind[iTarget] ? vBlindSpeedrunners(iTarget, param1, 1) : vBlindSpeedrunners(iTarget, param1, 0);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_blind\" on %N.", iTarget);
				}
				if (g_bChargeMenu[param1])
				{
					!g_bCharge[iTarget] ? vChargeSpeedrunners(iTarget, param1, 1, true, g_iCell1[iTarget]) : vChargeSpeedrunners(iTarget, param1, 0, true, g_iCell1[iTarget]);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_charge\" on %N.", iTarget);
				}
				if (g_bChaseMenu[param1])
				{
					vChaseSpeedrunners(iTarget, param1, true, g_iCell1[iTarget]);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_chase\" on %N.", iTarget);
				}
				if (g_bCheckMenu[param1])
				{
					!g_bCheck[iTarget] ? vCheckSpeedrunners(iTarget, param1, 1, true, g_iCell1[iTarget]) : vCheckSpeedrunners(iTarget, param1, 0, true, g_iCell1[iTarget]);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_check\" on %N.", iTarget);
				}
				if (g_bDisarmMenu[param1])
				{
					!g_bDisarm[iTarget] ? vDisarmSpeedrunners(iTarget, param1, 1, true, g_iCell1[iTarget], g_iCell2[iTarget]) : vDisarmSpeedrunners(iTarget, param1, 0, true, g_iCell1[iTarget], g_iCell2[iTarget]);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_disarm\" on %N.", iTarget);
				}
				if (g_bDrugMenu[param1])
				{
					!g_bDrug[iTarget] ? vDrugSpeedrunners(iTarget, param1, 1) : vDrugSpeedrunners(iTarget, param1, 0);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_drug\" on %N.", iTarget);
				}
				if (g_bExileMenu[param1])
				{
					!g_bExileMode[param1] ? vExileSpeedrunners(iTarget, param1, 0, true, g_iCell1[iTarget]) : vExileSpeedrunners(iTarget, param1, 1, true, g_iCell1[iTarget]);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_exile\" on %N.", iTarget);
				}
				if (g_bExplodeMenu[param1])
				{
					vExplodeSpeedrunners(iTarget, param1);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_explode\" on %N.", iTarget);
				}
				if (g_bFireMenu[param1])
				{
					!g_bFire[iTarget] ? vFireSpeedrunners(iTarget, param1, 1, true, g_iCell1[iTarget]) : vFireSpeedrunners(iTarget, param1, 0, true, g_iCell1[iTarget]);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_fire\" on %N.", iTarget);
				}
				if (g_bFreezeMenu[param1])
				{
					!g_bFreeze[iTarget] ? vFreezeSpeedrunners(iTarget, param1, 1) : vFreezeSpeedrunners(iTarget, param1, 0);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_freeze\" on %N.", iTarget);
				}
				if (g_bHealMenu[param1])
				{
					vHealSpeedrunners(iTarget, param1);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_heal\" on %N.", iTarget);
				}
				if (g_bHurtMenu[param1])
				{
					!g_bHurt[iTarget] ? vHurtSpeedrunners(iTarget, param1, 1, true, g_iCell1[iTarget], g_iCell2[iTarget]) : vHurtSpeedrunners(iTarget, param1, 0, true, g_iCell1[iTarget], g_iCell2[iTarget]);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_hurt\" on %N.", iTarget);
				}
				if (g_bIdleMenu[param1])
				{
					vIdleSpeedrunners(iTarget, param1);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_idle\" on %N.", iTarget);
				}
				if (g_bIncapMenu[param1])
				{
					!g_bIncap[iTarget] ? vIncapSpeedrunners(iTarget, param1, 1, true, g_iCell1[iTarget]) : vIncapSpeedrunners(iTarget, param1, 0, true, g_iCell1[iTarget]);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_incap\" on %N.", iTarget);
				}
				if (g_bInvertMenu[param1])
				{
					!g_bInvert[iTarget] ? vInvertSpeedrunners(iTarget, param1, 1, true, g_iCell1[iTarget]) : vInvertSpeedrunners(iTarget, param1, 0, true, g_iCell1[iTarget]);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_invert\" on %N.", iTarget);
				}
				if (g_bKeymanMenu[param1])
				{
					!g_bKeyman[iTarget] ? vSelectKeyman(iTarget, param1, 1) : vSelectKeyman(iTarget, param1, 0);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_key\" on %N.", iTarget);
				}
				if (g_bMirrorMenu[param1])
				{
					!g_bMirror[iTarget] ? vMirrorSpeedrunners(iTarget, param1, 1) : vMirrorSpeedrunners(iTarget, param1, 0);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_mirror\" on %N.", iTarget);
				}
				if (g_bNullMenu[param1])
				{
					!g_bNull[iTarget] ? vNullSpeedrunners(iTarget, param1, 1) : vNullSpeedrunners(iTarget, param1, 0);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_null\" on %N.", iTarget);
				}
				if (g_bPukeMenu[param1])
				{
					!g_bPuke[iTarget] ? vPukeSpeedrunners(iTarget, param1, 1, true, g_iCell1[iTarget]) : vPukeSpeedrunners(iTarget, param1, 0, true, g_iCell1[iTarget]);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_puke\" on %N.", iTarget);
				}
				if (g_bRestartMenu[param1])
				{
					vRestartSpeedrunners(iTarget, param1, true, g_sString[iTarget]);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_restart\" on %N.", iTarget);
				}
				if (g_bRocketMenu[param1])
				{
					vRocketSpeedrunners(iTarget, param1, true, g_flFloat1[iTarget], g_flFloat2[iTarget]);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_rocket\" on %N.", iTarget);
				}
				if (g_bShakeMenu[param1])
				{
					!g_bShake[iTarget] ? vShakeSpeedrunners(iTarget, param1, 1, true, g_iCell1[iTarget]) : vShakeSpeedrunners(iTarget, param1, 0, true, g_iCell1[iTarget]);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_shake\" on %N.", iTarget);
				}
				if (g_bShockMenu[param1])
				{
					vShockSpeedrunners(iTarget, param1);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_shock\" on %N.", iTarget);
				}
				if (g_bShoveMenu[param1])
				{
					!g_bShove[iTarget] ? vShoveSpeedrunners(iTarget, param1, 1, true, g_iCell1[iTarget]) : vShoveSpeedrunners(iTarget, param1, 0, true, g_iCell1[iTarget]);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_shove\" on %N.", iTarget);
				}
				if (g_bSlowMenu[param1])
				{
					!g_bSlow[iTarget] ? vSlowSpeedrunners(iTarget, param1, 1, true, g_flFloat1[iTarget]) : vSlowSpeedrunners(iTarget, param1, 0, true, g_flFloat1[iTarget]);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_slow\" on %N.", iTarget);
				}
				if (g_bStrikeMenu[param1])
				{
					vStrikeSpeedrunners(iTarget, param1, true, g_iCell1[iTarget]);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_strike\" on %N.", iTarget);
				}
				if (g_bVisionMenu[param1])
				{
					!g_bVision[iTarget] ? vVisionSpeedrunners(iTarget, param1, 1, true, g_iCell1[iTarget], g_iCell2[iTarget]) : vVisionSpeedrunners(iTarget, param1, 0, true, g_iCell1[iTarget], g_iCell2[iTarget]);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_vision\" on %N.", iTarget);
				}
				if (g_bWarpMenu[param1])
				{
					vWarpSpeedrunners(iTarget, param1);
					ShowActivity2(param1, ASS_PREFIX2, "Used \"ass_warp\" on %N.", iTarget);
				}
				if (IsClientInGame(param1) && !IsClientInKickQueue(param1))
				{
					vSelectTargetMenu(param1, menu.Selection);
				}
			}
		}
		case MenuAction_Display:
		{
			if (bHasTranslationFile())
			{
				Panel panel = view_as<Panel>(param2);
				Format(g_sMenuBuffer, sizeof(g_sMenuBuffer), "%T", "ChoosePlayer", param1);
				panel.SetTitle(g_sMenuBuffer);
			}
		}
	}
	return 0;
}