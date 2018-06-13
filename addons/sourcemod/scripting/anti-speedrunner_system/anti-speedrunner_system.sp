// Anti-Speedrunner System
#include <anti-speedrunner_system>
#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo =
{
	name = ASS_NAME,
	author = ASS_AUTHOR,
	description = ASS_DESCRIPTION,
	version = ASS_VERSION,
	url = ASS_URL
};

bool g_bAcid[MAXPLAYERS + 1];
bool g_bAFK[MAXPLAYERS + 1];
bool g_bAmmo[MAXPLAYERS + 1];
bool g_bBlind[MAXPLAYERS + 1];
bool g_bCharge[MAXPLAYERS + 1];
bool g_bCheck[MAXPLAYERS + 1];
bool g_bConfigMode[MAXPLAYERS + 1];
bool g_bDisarm[MAXPLAYERS + 1];
bool g_bDoorType[MAXPLAYERS + 1];
bool g_bDrug[MAXPLAYERS + 1];
bool g_bExileMode[MAXPLAYERS + 1];
bool g_bFire[MAXPLAYERS + 1];
bool g_bFreeze[MAXPLAYERS + 1];
bool g_bHeadshot[MAXPLAYERS + 1];
bool g_bHurt[MAXPLAYERS + 1];
bool g_bIdle[MAXPLAYERS + 1];
bool g_bIncap[MAXPLAYERS + 1];
bool g_bInvert[MAXPLAYERS + 1];
bool g_bKeyman[MAXPLAYERS + 1];
bool g_bMirror[MAXPLAYERS + 1];
bool g_bNull[MAXPLAYERS + 1];
bool g_bPuke[MAXPLAYERS + 1];
bool g_bRestart[MAXPLAYERS + 1];
bool g_bShake[MAXPLAYERS + 1];
bool g_bShove[MAXPLAYERS + 1];
bool g_bSlow[MAXPLAYERS + 1];
bool g_bVision[MAXPLAYERS + 1];
bool g_bWarp[MAXPLAYERS + 1];
bool g_bAdminMenu[MAXPLAYERS + 1];
bool g_bAcidMenu[MAXPLAYERS + 1];
bool g_bAmmoMenu[MAXPLAYERS + 1];
bool g_bBlindMenu[MAXPLAYERS + 1];
bool g_bChargeMenu[MAXPLAYERS + 1];
bool g_bChaseMenu[MAXPLAYERS + 1];
bool g_bCheckMenu[MAXPLAYERS + 1];
bool g_bDisarmMenu[MAXPLAYERS + 1];
bool g_bDrugMenu[MAXPLAYERS + 1];
bool g_bExileMenu[MAXPLAYERS + 1];
bool g_bExplodeMenu[MAXPLAYERS + 1];
bool g_bFireMenu[MAXPLAYERS + 1];
bool g_bFreezeMenu[MAXPLAYERS + 1];
bool g_bHealMenu[MAXPLAYERS + 1];
bool g_bHurtMenu[MAXPLAYERS + 1];
bool g_bIdleMenu[MAXPLAYERS + 1];
bool g_bIncapMenu[MAXPLAYERS + 1];
bool g_bInvertMenu[MAXPLAYERS + 1];
bool g_bKeymanMenu[MAXPLAYERS + 1];
bool g_bMirrorMenu[MAXPLAYERS + 1];
bool g_bNullMenu[MAXPLAYERS + 1];
bool g_bPukeMenu[MAXPLAYERS + 1];
bool g_bRestartMenu[MAXPLAYERS + 1];
bool g_bRocketMenu[MAXPLAYERS + 1];
bool g_bShakeMenu[MAXPLAYERS + 1];
bool g_bShockMenu[MAXPLAYERS + 1];
bool g_bShoveMenu[MAXPLAYERS + 1];
bool g_bSlowMenu[MAXPLAYERS + 1];
bool g_bStrikeMenu[MAXPLAYERS + 1];
bool g_bVisionMenu[MAXPLAYERS + 1];
bool g_bWarpMenu[MAXPLAYERS + 1];
bool g_bAutoCheck;
bool g_bDoorLocked[2048];
bool g_bDoorLocked2[2048];
bool g_bEntryStarted;
bool g_bLeftSaferoom;
bool g_bPlayerMoved;
bool g_bRestartValid;
bool g_bStarted[MAXPLAYERS + 1];
bool g_bBFGKLVoted;
bool g_bBFGKLVoteMenu;
bool g_bLockdownVoted;
bool g_bLockdownVoteMenu;
char g_sDoorType[3];
char g_sLockdownType[3];
char g_sPropName[64];
char g_sSaferoomOption[21];
char g_sStrikeOption[53];
char g_sString[MAXPLAYERS + 1][512];
char g_sWeapon[32];
ConVar g_cvASSAdminImmunity;
ConVar g_cvASSAutoMode;
ConVar g_cvASSCommandOverride;
ConVar g_cvASSCountBots;
ConVar g_cvASSDisabledGameModes;
ConVar g_cvASSEnabledGameModes;
ConVar g_cvASSEnable;
ConVar g_cvASSFailsafe;
ConVar g_cvASSIncapacitatedCount;
ConVar g_cvASSLockdownDoorType;
ConVar g_cvASSLogCommands;
ConVar g_cvASSNoFinales;
ConVar g_cvASSRevivedCount;
ConVar g_cvASSSaferoomDisabledGameModes;
ConVar g_cvASSSaferoomEnabledGameModes;
ConVar g_cvASSSaferoomEnable;
ConVar g_cvASSSaferoomEntryMode;
ConVar g_cvASSSaferoomSystemOptions;
ConVar g_cvASSSaferoomWarpCountdown;
ConVar g_cvASSStrikeEnable;
ConVar g_cvASSStrikeStrikeLimit;
ConVar g_cvASSStrikeSystemOptions;
ConVar g_cvASSTankAlive;
float g_flFloat1[MAXPLAYERS + 1];
float g_flFloat2[MAXPLAYERS + 1];
float g_flSpawnPosition[3];
Handle g_hGameData;
Handle g_hWarpTimer;
int g_iButtonType[MAXPLAYERS + 1];
int g_iCell1[MAXPLAYERS + 1];
int g_iCell2[MAXPLAYERS + 1];
int g_iDoorId = 0;
int g_iDoorId2 = 0;
int g_iStrikeCount[MAXPLAYERS + 1];
int g_iTargetCount;
int g_iTargets[MAXPLAYERS + 1];
int g_iWarpCountdown;
int g_iWeaponSlot[MAXPLAYERS + 1];
StringMap g_smConVars;
TopMenu g_tmASSMenu;
UserMsg g_umFadeUserMsgId;

#include "anti-speedrunner_system/saferoom/ass_boss.sp"
#include "anti-speedrunner_system/saferoom/ass_delay.sp"
#include "anti-speedrunner_system/saferoom/ass_filter.sp"
#include "anti-speedrunner_system/saferoom/ass_group.sp"
#include "anti-speedrunner_system/saferoom/ass_keyman.sp"
#include "anti-speedrunner_system/saferoom/ass_lockdown.sp"
#include "anti-speedrunner_system/strike/ass_acidity.sp"
#include "anti-speedrunner_system/strike/ass_ammunition.sp"
#include "anti-speedrunner_system/strike/ass_blindness.sp"
#include "anti-speedrunner_system/strike/ass_charge.sp"
#include "anti-speedrunner_system/strike/ass_chase.sp"
#include "anti-speedrunner_system/strike/ass_disarmament.sp"
#include "anti-speedrunner_system/strike/ass_drug.sp"
#include "anti-speedrunner_system/strike/ass_exile.sp"
#include "anti-speedrunner_system/strike/ass_explosion.sp"
#include "anti-speedrunner_system/strike/ass_fire.sp"
#include "anti-speedrunner_system/strike/ass_freeze.sp"
#include "anti-speedrunner_system/strike/ass_health.sp"
#include "anti-speedrunner_system/strike/ass_hurt.sp"
#include "anti-speedrunner_system/strike/ass_idle.sp"
#include "anti-speedrunner_system/strike/ass_incapacitation.sp"
#include "anti-speedrunner_system/strike/ass_inversion.sp"
#include "anti-speedrunner_system/strike/ass_mirror.sp"
#include "anti-speedrunner_system/strike/ass_puke.sp"
#include "anti-speedrunner_system/strike/ass_restart.sp"
#include "anti-speedrunner_system/strike/ass_rocket.sp"
#include "anti-speedrunner_system/strike/ass_shake.sp"
#include "anti-speedrunner_system/strike/ass_shock.sp"
#include "anti-speedrunner_system/strike/ass_shove.sp"
#include "anti-speedrunner_system/strike/ass_slow.sp"
#include "anti-speedrunner_system/strike/ass_vision.sp"
#include "anti-speedrunner_system/strike/ass_warp.sp"
#include "anti-speedrunner_system/ass_configuration_system.sp"
#include "anti-speedrunner_system/ass_menu_system.sp"
#include "anti-speedrunner_system/ass_saferoom_system.sp"
#include "anti-speedrunner_system/ass_strike_system.sp"

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
	char sGameName[64];
	GetGameFolderName(sGameName, sizeof(sGameName));
	if (!StrEqual(sGameName, "left4dead", false) && !StrEqual(sGameName, "left4dead2", false))
	{
		return APLRes_SilentFailure;
	}
	return APLRes_Success;
}

public void OnPluginStart()
{
	vMultiTargetFilters(1);
	LoadTranslations("common.phrases");
	if (bHasTranslationFile())
	{
		LoadTranslations("anti-speedrunner_system.phrases");
	}
	RegAdminCmd("ass_acid", cmdASSAcid, ADMFLAG_KICK, "Spawn an acid puddle under a player for speedrunning.");
	RegAdminCmd("ass_ammo", cmdASSAmmo, ADMFLAG_KICK, "Set a player's ammunition count for speedrunning.");
	RegAdminCmd("ass_blind", cmdASSBlind, ADMFLAG_KICK, "Blind a player for speedrunning.");
	RegAdminCmd("ass_charge", cmdASSCharge, ADMFLAG_KICK, "Charge at a player for speedrunning.");
	RegAdminCmd("ass_chase", cmdASSChase, ADMFLAG_KICK, "Spawn a special infected to chase a player for speedrunning.");
	RegAdminCmd("ass_check", cmdASSCheck, ADMFLAG_KICK, "Run a timer on a player to check for speedrunning.");
	RegAdminCmd("ass_config", cmdASSConfig, ADMFLAG_ROOT, "Create a custom config in-game.");
	RegAdminCmd("ass_disarm", cmdASSDisarm, ADMFLAG_KICK, "Disarm a player for speedrunning.");
	RegAdminCmd("ass_door", cmdASSDoor, ADMFLAG_KICK, "Manually lock/unlock saferoom doors.");
	RegAdminCmd("ass_drug", cmdASSDrug, ADMFLAG_KICK, "Drug a player for speedrunning.");
	RegAdminCmd("ass_entry", cmdASSEntry, ADMFLAG_ROOT, "Warp all survivors inside the saferoom.");
	RegAdminCmd("ass_exile", cmdASSExile, ADMFLAG_BAN, "Exile a player for speedrunning.");
	RegAdminCmd("ass_explode", cmdASSExplode, ADMFLAG_SLAY, "Cause an explosion on a player for speedrunning.");
	RegAdminCmd("ass_fire", cmdASSFire, ADMFLAG_KICK, "Set a player on fire for speedrunning.");
	RegAdminCmd("ass_freeze", cmdASSFreeze, ADMFLAG_KICK, "Freeze a player for speedrunning.");
	RegAdminCmd("ass_heal", cmdASSHeal, ADMFLAG_KICK, "Set a player to black and white with temporary health for speedrunning.");
	RegAdminCmd("ass_hurt", cmdASSHurt, ADMFLAG_KICK, "Hurt a player for speedrunning.");
	RegAdminCmd("ass_idle", cmdASSIdle, ADMFLAG_SLAY, "Force a player to go idle for speedrunning.");
	RegAdminCmd("ass_incap", cmdASSIncap, ADMFLAG_KICK, "Incapacitate a player for speedrunning.");
	RegAdminCmd("ass_invert", cmdASSInvert, ADMFLAG_KICK, "Invert a player's movement keys for speedrunning.");
	RegAdminCmd("ass_key", cmdASSKey, ADMFLAG_KICK, "Choose a new Keyman.");
	RegAdminCmd("ass_mirror", cmdASSMirror, ADMFLAG_KICK, "Mirror a player's damage for speedrunning.");
	RegAdminCmd("ass_null", cmdASSNull, ADMFLAG_ROOT, "Give a player immunity.");
	RegAdminCmd("ass_puke", cmdASSPuke, ADMFLAG_KICK, "Puke on a player for speedrunning.");
	RegAdminCmd("ass_restart", cmdASSRestart, ADMFLAG_KICK, "Cause a player to restart at the spawn area for speedrunning.");
	RegAdminCmd("ass_rocket", cmdASSRocket, ADMFLAG_SLAY, "Send a player into space for speedrunning.");
	RegAdminCmd("ass_room", cmdASSSaferoom, ADMFLAG_ROOT, "Manually set the entry method for ending saferoom doors.");
	RegAdminCmd("ass_shake", cmdASSShake, ADMFLAG_KICK, "Shake a player's screen for speedrunning.");
	RegAdminCmd("ass_shock", cmdASSShock, ADMFLAG_SLAY, "Shock a player for speedrunning.");
	RegAdminCmd("ass_shove", cmdASSShove, ADMFLAG_KICK, "Shove a player for speedrunning.");
	RegAdminCmd("ass_slow", cmdASSSlow, ADMFLAG_KICK, "Slow a player down for speedrunning.");
	RegAdminCmd("ass_strike", cmdASSStrike, ADMFLAG_ROOT, "Give a player a strike for speedrunning.");
	RegAdminCmd("ass_vision", cmdASSVision, ADMFLAG_KICK, "Change a player's vision for speedrunning.");
	RegAdminCmd("ass_warp", cmdASSWarp, ADMFLAG_KICK, "Warp a player to your position for speedrunning.");
	g_smConVars = new StringMap();
	vASS_CreateConfig(true);
	vASS_CreateDirectory(true);
	bASS_Config("anti-speedrunner_system");
	vCreateConVar(g_cvASSAdminImmunity, "ass_adminimmunity", "0", "Should admins with the generic flag or \"ass_override\" override command be immune to the Anti-Speedrunner System?\n(0: OFF)\n(1: ON)", _, true, 0.0, true, 1.0);
	vCreateConVar(g_cvASSAutoMode, "ass_automode", "1", "Enable the Anti-Speedrunner System's automatic mode?\n(0: OFF)\n(1: ON)", _, true, 0.0, true, 1.0);
	vCreateConVar(g_cvASSCommandOverride, "ass_commandoverride", "1", "Allow the use of admin commands during automatic mode?\n(0: OFF)\n(1: ON)", _, true, 0.0, true, 1.0);
	vCreateConVar(g_cvASSCountBots, "ass_countbots", "1", "Should the Anti-Speedrunner System count bots as players?\n(0: OFF)\n(1: ON)", _, true, 0.0, true, 1.0);
	vCreateConVar(g_cvASSDisabledGameModes, "ass_disabledgamemodes", "", "Disable the Anti-Speedrunner System in these game modes.\nSeparate game modes with commas.\nGame mode limit: 64\nCharacter limit for each game mode: 32\n(Empty: None)\n(Not empty: Disabled only in these game modes.)");
	vCreateConVar(g_cvASSEnabledGameModes, "ass_enabledgamemodes", "", "Enable the Anti-Speedrunner System in these game modes.\nSeparate game modes with commas.\nGame mode limit: 64\nCharacter limit for each game mode: 32\n(Empty: All)\n(Not empty: Enabled only in these game modes.)");
	vCreateConVar(g_cvASSEnable, "ass_enablesystem", "1", "Enable the Anti-Speedrunner System?\n(0: OFF)\n(1: ON)", _, true, 0.0, true, 1.0);
	vCreateConVar(g_cvASSFailsafe, "ass_failsafe", "1", "Disable/re-enable the Anti-Speedrunner System's functions after X survivors are incapacitated/revived?\n(0: OFF)\n(1: ON)", _, true, 0.0, true, 1.0);
	vCreateConVar(g_cvASSIncapacitatedCount, "ass_incapacitatedcount", "2", "Amount of incapacitated survivors needed to turn the Anti-Speedrunner System off.\n(0: OFF, keep the Anti-Speedrunner System enabled.)\n(X: ON, disable the Anti-Speedrunner System after X survivors are incapacitated.)", _, true, 1.0, true, 66.0);
	vCreateConVar(g_cvASSLogCommands, "ass_logcommands", "1", "Log command usage?\n(0: OFF)\n(1: ON)", _, true, 0.0, true, 1.0);
	vCreateConVar(g_cvASSNoFinales, "ass_nofinales", "0", "Automatically disable the Anti-Speedrunner system during finale maps?\n(0: OFF)\n(1: ON)", _, true, 0.0, true, 1.0);
	cvASS_ConVar("ass_pluginversion", ASS_VERSION, "Anti-Speedrunner System version", FCVAR_NOTIFY|FCVAR_DONTRECORD);
	vCreateConVar(g_cvASSRevivedCount, "ass_revivedcount", "2", "Amount of revived survivors needed to turn the Anti-Speedrunner System back on.\n(0: OFF, keep the Anti-Speedrunner System disabled.)\n(X: ON, re-enable the Anti-Speedrunner System after X survivors are revived.)", _, true, 1.0, true, 66.0);
	vCreateConVar(g_cvASSTankAlive, "ass_tankalive", "1", "Keep the Anti-Speedrunner System enabled when there is a Tank alive?\n(0: OFF)\n(1: ON)", _, true, 0.0, true, 1.0);
	vChaseCvars();
	vConfigCvars();
	vDelayCvars();
	vDisarmCvars();
	vExileCvars();
	vFilterCvars();
	vGroupCvars();
	vHurtCvars();
	vKeymanCvars();
	vLockdownCvars();
	vRestartCvars();
	vCreateConVar(g_cvASSSaferoomDisabledGameModes, "asssaferoom_disabledgamemodes", "versus,realismversus,scavenge,survival,mutation1", "Disable the Boss, Group, Keyman, and Lockdown systems in these game modes.\nSeparate game modes with commas.\nGame mode limit: 64\nCharacter limit for each game mode: 32\n(Empty: None)\n(Not empty: Disabled only in these game modes.)");
	vCreateConVar(g_cvASSSaferoomEnabledGameModes, "asssaferoom_enabledgamemodes", "coop,realism,mutation12", "Enable the Boss, Group, Keyman, and Lockdown systems in these game modes.\nSeparate game modes with commas.\nGame mode limit: 64\nCharacter limit for each game mode: 32\n(Empty: All)\n(Not empty: Enabled only in these game modes.)");
	vCreateConVar(g_cvASSSaferoomEnable, "asssaferoom_enablesystem", "1", "Enable the Saferoom system?\n(0: OFF)\n(1: ON)", _, true, 0.0, true, 1.0);
	vCreateConVar(g_cvASSSaferoomEntryMode, "asssaferoom_entrymode", "1", "Warp survivors inside or unlock the saferoom door?\n(0: Warp)\n(1: Unlock)", _, true, 0.0, true, 1.0);
	vCreateConVar(g_cvASSSaferoomSystemOptions, "asssaferoom_systemoptions", "KkKkLLllfFfFbbBBgGGg", "Which system options do you want to use to deal with speedrunners?\nCombine letters in any order for different results.\nRepeat the same letter to increase its chance of being chosen.\nCharacter limit: 20\n(B or b: Boss)\n(F or f: Filter)\n(G or g: Group)\n(K or k: Keyman)\n(L or l: Lockdown)");
	vCreateConVar(g_cvASSSaferoomWarpCountdown, "asssaferoom_warpcountdown", "5", "Survivors will be warped inside the saferoom after X second(s).", _, true, 1.0, true, 99999.0);
	g_iWarpCountdown = g_cvASSSaferoomWarpCountdown.IntValue;
	vSlowCvars();
	vCreateConVar(g_cvASSStrikeDelay, "assstrike_detectiondelay", "5.0", "How many seconds between each check for speedrunners?", _, true, 0.0, true, 99999.0);
	vCreateConVar(g_cvASSStrikeDistanceLimit, "assstrike_distancelimit", "2000", "Distance allowed before speedrunners are dealt with.", _, true, 1.0, true, 99999.0);
	vCreateConVar(g_cvASSStrikeDistanceWarning, "assstrike_distancewarning", "1000", "Distance allowed before speedrunners are warned to go back.", _, true, 1.0, true, 99999.0);
	vCreateConVar(g_cvASSStrikeEnable, "assstrike_enablesystem", "1", "Enable the Strike system?\n(0: OFF)\n(1: ON)", _, true, 0.0, true, 1.0);
	vCreateConVar(g_cvASSStrikePunishMode, "assstrike_punishmode", "1", "Combine punishment options or randomly pick one?\n(0: Combine)\n(1: Pick one)", _, true, 0.0, true, 1.0);
	vCreateConVar(g_cvASSStrikeStrikeLimit, "assstrike_strikelimit", "5", "Number of strikes needed to be punished for speedrunning.", _, true, 1.0, true, 99999.0);
	vCreateConVar(g_cvASSStrikeStrikeMode, "assstrike_strikemode", "1", "Give strikes first before punishing speedrunners?\n(0: OFF)\n(1: ON)", _, true, 0.0, true, 1.0);
	vCreateConVar(g_cvASSStrikeSystemOptions, "assstrike_systemoptions", "QqWweErRtTyYuUIiOopPAasSdDfFgGHhJjkKLlXxcCvVbBnNMm", "Which system options do you want to use to deal with speedrunners?\nCombine letters in any order for different results.\nRepeat the same letter to increase its chance of being chosen.\nCharacter limit: 52\n(A or a: Slow)\n(B or b: Drug)\n(C or c: Blindness)\n(D or d: Shove)\n(E or e: Shake)\n(F or f: Freeze)\n(G or g: Inversion)\n(H or h: Restart)\n(I or i: Warp)\n(J or j: Ammunition)\n(K or k: Disarmament)\n(L or l: Hurt)\n(M or m: Mirror)\n(N or n: Fire)\n(O or o: Health)\n(P or p: Vision)\n(Q or q: Incapacitation)\n(R or r: Rocket)\n(S or s: Shock)\n(T or t: Explosion)\n(U or u: Puke)\n(V or v: Chase)\n(W or w: Acidity, switches to Puke in L4D1.)\n(X or x: Charge, switches to Chase in L4D1.)\n(Y or y: Idle)\n(Z or z: Exile)");
	vASS_ExecConfig();
	iASS_Clean();
	g_cvASSAdminImmunity.AddChangeHook(vASSAdminImmunityCvar);
	g_cvASSAutoMode.AddChangeHook(vASSAutoModeCvar);
	g_cvASSEnable.AddChangeHook(vASSAdminImmunityCvar);
	g_cvASSEnable.AddChangeHook(vASSAutoModeCvar);
	g_cvASSEnable.AddChangeHook(vGameModeCvars);
	g_cvASSEnable.AddChangeHook(vSaferoomGameModeCvars);
	g_cvASSEnable.AddChangeHook(vASSBossEnableCvar);
	g_cvASSEnable.AddChangeHook(vASSFilterEnableCvar);
	g_cvASSEnable.AddChangeHook(vASSGroupEnableCvar);
	g_cvASSEnable.AddChangeHook(vASSKeymanEnableCvar);
	g_cvASSEnable.AddChangeHook(vASSLockdownEnableCvar);
	g_cvASSEnabledGameModes.AddChangeHook(vGameModeCvars);
	g_cvASSEnabledGameModes.AddChangeHook(vSaferoomGameModeCvars);
	g_cvASSEnabledGameModes.AddChangeHook(vSaferoomGameModeCvars);
	g_cvASSDisabledGameModes.AddChangeHook(vGameModeCvars);
	g_cvASSDisabledGameModes.AddChangeHook(vSaferoomGameModeCvars);
	g_cvASSDisabledGameModes.AddChangeHook(vSaferoomGameModeCvars);
	g_cvASSLockdownDoorType.AddChangeHook(vASSLockdownEnableCvar);
	g_cvASSSaferoomEnabledGameModes.AddChangeHook(vSaferoomGameModeCvars);
	g_cvASSSaferoomDisabledGameModes.AddChangeHook(vSaferoomGameModeCvars);
	g_cvASSSaferoomEnable.AddChangeHook(vSaferoomGameModeCvars);
	g_cvASSSaferoomEnable.AddChangeHook(vASSBossEnableCvar);
	g_cvASSSaferoomEnable.AddChangeHook(vASSFilterEnableCvar);
	g_cvASSSaferoomEnable.AddChangeHook(vASSGroupEnableCvar);
	g_cvASSSaferoomEnable.AddChangeHook(vASSKeymanEnableCvar);
	g_cvASSSaferoomEnable.AddChangeHook(vASSLockdownEnableCvar);
	g_cvASSSaferoomSystemOptions.AddChangeHook(vASSBossEnableCvar);
	g_cvASSSaferoomSystemOptions.AddChangeHook(vASSFilterEnableCvar);
	g_cvASSSaferoomSystemOptions.AddChangeHook(vASSGroupEnableCvar);
	g_cvASSSaferoomSystemOptions.AddChangeHook(vASSKeymanEnableCvar);
	g_cvASSSaferoomSystemOptions.AddChangeHook(vASSLockdownEnableCvar);
	g_cvASSStrikeDelay.AddChangeHook(vStrikeDelayCvar);
	vHookConfigCvars();
	HookEvent("player_afk", eEventPlayerAFK, EventHookMode_Pre);
	HookEvent("player_bot_replace", eEventPlayerBotReplace);
	HookEvent("player_incapacitated", eEventPlayerIncapacitated);
	HookEvent("player_ledge_grab", eEventPlayerIncapacitated);
	HookEvent("player_spawn", eEventPlayerSpawnDeath);
	HookEvent("player_death", eEventPlayerSpawnDeath);
	HookEvent("player_death", eEventPlayerDeath, EventHookMode_Pre);
	HookEvent("player_use", eEventSDPlayerUse);
	HookEvent("player_use", eEventEDPlayerUse);
	HookEvent("player_use", eEventSPlayerUse, EventHookMode_Pre);
	HookEvent("player_use", eEventEPlayerUse, EventHookMode_Pre);
	HookEvent("player_team", eEventJoinTeam, EventHookMode_Post);
	HookEvent("player_left_checkpoint", eEventLeftCheckpoint, EventHookMode_Post);
	HookEvent("round_start", eEventRoundStart, EventHookMode_Post);
	HookEvent("round_end", eEventServerEnd, EventHookMode_PostNoCopy);
	HookEvent("round_end", eEventRoundEnd);
	HookEvent("mission_lost", eEventServerEnd);
	HookEvent("mission_lost", eEventRoundEnd);
	HookEvent("map_transition", eEventServerEnd);
	HookEvent("map_transition", eEventRoundEnd);
	HookEvent("finale_win", eEventServerEnd);
	HookEvent("finale_win", eEventRoundEnd);
	HookEvent("finale_vehicle_ready", eEventServerEnd);
	HookEvent("finale_vehicle_leaving", eEventServerEnd);
	g_umFadeUserMsgId = GetUserMessageId("Fade");
	g_bLeftSaferoom = false;
	vSetStarted(false);
	if (bIsL4D2Game())
	{
		vAcidSDKCall();
		vChargeSDKCall();
	}
	vHealSDKCalls();
	vIdleSDKCalls();
	vPukeSDKCall();
	vRestartSDKCall();
	vShoveSDKCall();
	TopMenu tmAdminMenu;
	if (LibraryExists("adminmenu") && ((tmAdminMenu = GetAdminTopMenu()) != null))
	{
		OnAdminMenuReady(tmAdminMenu);
	}
}

public void OnMapStart()
{
	if (g_cvASSEnable.BoolValue && bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSEnabledGameModes, g_cvASSDisabledGameModes))
	{
		g_bRestartValid = false;
		vExplodeStart();
		vFreezeStart();
		vIncapStart();
		vRocketStart();
		vSaferoomStart();
		vShockStart();
		if (g_cvASSAutoMode.BoolValue && g_cvASSStrikeEnable.BoolValue)
		{
			vAutoCheckSpeedrunners(1);
		}
		CreateTimer(1.0, tTimerUpdateIncapCount, _, TIMER_FLAG_NO_MAPCHANGE|TIMER_REPEAT);
		CreateTimer(1.0, tTimerUpdatePlayerCount, _, TIMER_FLAG_NO_MAPCHANGE|TIMER_REPEAT);
	}
}

public void OnClientPostAdminCheck(int client)
{
	SDKHook(client, SDKHook_TraceAttack, aTraceAttack);
	vResetPlayerStats(client);
	g_bAdminMenu[client] = false;
	g_bAFK[client] = false;
	g_bHeadshot[client] = false;
	g_bNull[client] = false;
	g_iStrikeCount[client] = 0;
}

public void OnClientDisconnect(int client)
{
	vKillCheckTimer(client);
	vResetPlayerStats(client);
	g_bAdminMenu[client] = false;
	g_bAFK[client] = false;
	g_bHeadshot[client] = false;
	g_bNull[client] = false;
	g_iStrikeCount[client] = 0;
	if (g_cvASSEnable.BoolValue && bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSEnabledGameModes, g_cvASSDisabledGameModes))
	{
		g_cvASSSaferoomSystemOptions.GetString(g_sSaferoomOption, sizeof(g_sSaferoomOption));
		if (g_cvASSSaferoomEnable.BoolValue && bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSSaferoomEnabledGameModes, g_cvASSSaferoomDisabledGameModes) && StrContains(g_sSaferoomOption, "k", false) != -1 && bIsHumanSurvivor(client) && !bIsFinaleMap() && !bIsBuggedMap())
		{
			if (g_bKeyman[client])
			{
				vSelectKeyman(client, client, 0, false);
				for (int iAdmin = 1; iAdmin <= MaxClients; iAdmin++)
				{
					if (bIsHumanSurvivor(iAdmin) && bIsAdminAllowed(iAdmin))
					{
						bHasTranslationFile() ? PrintToChat(iAdmin, "%s %t", ASS_PREFIX01, "KeymanDisconnected") : PrintToChat(iAdmin, "%s A Keyman disconnected! Selecting new Keyman...", ASS_PREFIX01);
					}
				}
				CreateTimer(1.0, tTimerChooseKeyman);
			}
		}
	}
}

public void OnConfigsExecuted()
{
	g_bRestartValid = false;
	vCreateConfigFiles();
	vExecuteConfigs();
	g_cvASSSaferoomSystemOptions.GetString(g_sSaferoomOption, sizeof(g_sSaferoomOption));
	g_cvASSLockdownDoorType.GetString(g_sLockdownType, sizeof(g_sLockdownType));
	if (g_cvASSEnable.BoolValue && bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSEnabledGameModes, g_cvASSDisabledGameModes))
	{
		if (g_cvASSSaferoomEnable.BoolValue && bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSSaferoomEnabledGameModes, g_cvASSSaferoomDisabledGameModes) && !bIsFinaleMap() && !bIsBuggedMap())
		{
			if (StrContains(g_sSaferoomOption, "l", false) != -1 && StrContains(g_sLockdownType, "1", false) != -1)
			{
				vSInitializeDoor();
			}
			if (StrContains(g_sSaferoomOption, "b", false) != -1 || StrContains(g_sSaferoomOption, "f", false) != -1 || StrContains(g_sSaferoomOption, "g", false) != -1 || StrContains(g_sSaferoomOption, "k", false) != -1 || (StrContains(g_sSaferoomOption, "l", false) != -1 && StrContains(g_sLockdownType, "2", false) != -1))
			{
				vEInitializeDoor();
			}
		}
	}
}

public void OnMapEnd()
{
	vKillReset();
}

public void OnPluginEnd()
{
	vMultiTargetFilters(0);
	vEDoorControl(g_iDoorId2, false);
	vResetVoteMenus();
}

public void OnAdminMenuReady(Handle topmenu)
{
	TopMenu tmAdminMenu = TopMenu.FromHandle(topmenu);
	if (tmAdminMenu == g_tmASSMenu)
	{
		return;
	}
	g_tmASSMenu = tmAdminMenu;
	TopMenuObject ass_commands = g_tmASSMenu.AddCategory("Anti-SpeedrunnerSystem", iAdminMenuHandler);
	if (ass_commands != INVALID_TOPMENUOBJECT)
	{
		g_tmASSMenu.AddItem("ass_acid", vAcidMenu, ass_commands, "ass_acid", ADMFLAG_KICK);
		g_tmASSMenu.AddItem("ass_ammo", vAmmoMenu, ass_commands, "ass_ammo", ADMFLAG_KICK);
		g_tmASSMenu.AddItem("ass_blind", vBlindMenu, ass_commands, "ass_blind", ADMFLAG_KICK);
		g_tmASSMenu.AddItem("ass_charge", vChargeMenu, ass_commands, "ass_charge", ADMFLAG_KICK);
		g_tmASSMenu.AddItem("ass_chase", vChaseMenu, ass_commands, "ass_chase", ADMFLAG_KICK);
		g_tmASSMenu.AddItem("ass_check", vCheckMenu, ass_commands, "ass_check", ADMFLAG_KICK);
		g_tmASSMenu.AddItem("ass_config", vConfigMenu, ass_commands, "ass_config", ADMFLAG_ROOT);
		g_tmASSMenu.AddItem("ass_disarm", vDisarmMenu, ass_commands, "ass_disarm", ADMFLAG_KICK);
		g_tmASSMenu.AddItem("ass_door", vDoorMenu, ass_commands, "ass_door", ADMFLAG_KICK);
		g_tmASSMenu.AddItem("ass_drug", vDrugMenu, ass_commands, "ass_drug", ADMFLAG_KICK);
		g_tmASSMenu.AddItem("ass_entry", vEntryMenu, ass_commands, "ass_entry", ADMFLAG_ROOT);
		g_tmASSMenu.AddItem("ass_exile", vExileMenu, ass_commands, "ass_exile", ADMFLAG_BAN);
		g_tmASSMenu.AddItem("ass_explode", vExplodeMenu, ass_commands, "ass_explode", ADMFLAG_SLAY);
		g_tmASSMenu.AddItem("ass_fire", vFireMenu, ass_commands, "ass_fire", ADMFLAG_KICK);
		g_tmASSMenu.AddItem("ass_freeze", vFreezeMenu, ass_commands, "ass_freeze", ADMFLAG_KICK);
		g_tmASSMenu.AddItem("ass_heal", vHealMenu, ass_commands, "ass_heal", ADMFLAG_KICK);
		g_tmASSMenu.AddItem("ass_hurt", vHurtMenu, ass_commands, "ass_hurt", ADMFLAG_KICK);
		g_tmASSMenu.AddItem("ass_idle", vIdleMenu, ass_commands, "ass_idle", ADMFLAG_SLAY);
		g_tmASSMenu.AddItem("ass_incap", vIncapMenu, ass_commands, "ass_incap", ADMFLAG_KICK);
		g_tmASSMenu.AddItem("ass_invert", vInvertMenu, ass_commands, "ass_invert", ADMFLAG_KICK);
		g_tmASSMenu.AddItem("ass_key", vKeymanMenu, ass_commands, "ass_key", ADMFLAG_KICK);
		g_tmASSMenu.AddItem("ass_mirror", vMirrorMenu, ass_commands, "ass_mirror", ADMFLAG_KICK);
		g_tmASSMenu.AddItem("ass_null", vNullMenu, ass_commands, "ass_null", ADMFLAG_ROOT);
		g_tmASSMenu.AddItem("ass_puke", vPukeMenu, ass_commands, "ass_puke", ADMFLAG_KICK);
		g_tmASSMenu.AddItem("ass_restart", vRestartMenu, ass_commands, "ass_restart", ADMFLAG_KICK);
		g_tmASSMenu.AddItem("ass_rocket", vRocketMenu, ass_commands, "ass_rocket", ADMFLAG_SLAY);
		g_tmASSMenu.AddItem("ass_room", vSaferoomMenu, ass_commands, "ass_room", ADMFLAG_ROOT);
		g_tmASSMenu.AddItem("ass_shake", vShakeMenu, ass_commands, "ass_shake", ADMFLAG_KICK);
		g_tmASSMenu.AddItem("ass_shock", vShockMenu, ass_commands, "ass_shock", ADMFLAG_SLAY);
		g_tmASSMenu.AddItem("ass_shove", vShoveMenu, ass_commands, "ass_shove", ADMFLAG_KICK);
		g_tmASSMenu.AddItem("ass_slow", vSlowMenu, ass_commands, "ass_slow", ADMFLAG_KICK);
		g_tmASSMenu.AddItem("ass_strike", vStrikeMenu, ass_commands, "ass_strike", ADMFLAG_ROOT);
		g_tmASSMenu.AddItem("ass_vision", vVisionMenu, ass_commands, "ass_vision", ADMFLAG_KICK);
		g_tmASSMenu.AddItem("ass_warp", vWarpMenu, ass_commands, "ass_warp", ADMFLAG_KICK);
	}
}

public int iAdminMenuHandler(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
	switch (action)
	{
		case TopMenuAction_DisplayTitle, TopMenuAction_DisplayOption: Format(buffer, maxlength, "Anti-Speedrunner System");
	}
}

public void OnLibraryRemoved(const char[] name)
{
	if (StrEqual(name, "adminmenu", false))
	{
		g_tmASSMenu = null;
	}
}

public Action eEventPlayerAFK(Event event, const char[] name, bool dontBroadcast)
{
	int iIdler = GetClientOfUserId(event.GetInt("player"));
	g_bAFK[iIdler] = true;
	if (g_bKeyman[iIdler])
	{
		vSelectKeyman(iIdler, iIdler, 0, false);
		for (int iAdmin = 1; iAdmin <= MaxClients; iAdmin++)
		{
			if (bIsHumanSurvivor(iAdmin) && bIsAdminAllowed(iAdmin))
			{
				bHasTranslationFile() ? PrintToChat(iAdmin, "%s %t", ASS_PREFIX01, "KeymanTeam") : PrintToChat(iAdmin, "%s A Keyman has changed their team! Selecting new Keyman...", ASS_PREFIX01);
			}
		}
		CreateTimer(1.0, tTimerChooseKeyman);
	}
}

public Action eEventPlayerBotReplace(Event event, const char[] name, bool dontBroadcast)
{
	int iSurvivor = GetClientOfUserId(GetEventInt(event, "player"));
	int iBot = GetClientOfUserId(GetEventInt(event, "bot"));
	if (g_cvASSEnable.BoolValue && bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSEnabledGameModes, g_cvASSDisabledGameModes) && bIsIdlePlayer(iBot, iSurvivor)) 
	{
		Handle hDataPack = CreateDataPack();
		WritePackCell(hDataPack, iSurvivor);
		WritePackCell(hDataPack, iBot);
		CreateTimer(0.2, tTimerAFKFix, hDataPack, TIMER_FLAG_NO_MAPCHANGE);
		if (g_bIdle[iSurvivor])
		{
			g_bIdle[iSurvivor] = false;
			vIdleMessage(iSurvivor);
			vIdleWarp(iBot);
		}
	}
}

public Action eEventPlayerIncapacitated(Event event, const char[] name, bool dontBroadcast)
{
	int iDisabled = GetClientOfUserId(event.GetInt("userid"));
	g_cvASSSaferoomSystemOptions.GetString(g_sSaferoomOption, sizeof(g_sSaferoomOption));
	if (g_cvASSEnable.BoolValue && bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSEnabledGameModes, g_cvASSDisabledGameModes))
	{
		if (g_cvASSSaferoomEnable.BoolValue && bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSSaferoomEnabledGameModes, g_cvASSSaferoomDisabledGameModes) && StrContains(g_sSaferoomOption, "k", false) != -1 && bIsHumanSurvivor(iDisabled) && !bIsFinaleMap() && !bIsBuggedMap())
		{
			if (g_bKeyman[iDisabled])
			{
				vSelectKeyman(iDisabled, iDisabled, 0, false);
				for (int iAdmin = 1; iAdmin <= MaxClients; iAdmin++)
				{
					if (bIsHumanSurvivor(iAdmin) && bIsAdminAllowed(iAdmin))
					{
						bHasTranslationFile() ? PrintToChat(iAdmin, "%s %t", ASS_PREFIX01, "KeymanIncapacitated") : PrintToChat(iAdmin, "%s A Keyman is incapacitated! Selecting new Keyman...", ASS_PREFIX01);
					}
				}
				CreateTimer(1.0, tTimerChooseKeyman);
			}
		}
	}
}

public Action eEventPlayerDeath(Event event, const char[] name, bool dontBroadcast)
{
	int iAttacker = GetClientOfUserId(event.GetInt("attacker"));
	int iDead = GetClientOfUserId(event.GetInt("userid"));
	if (g_cvASSEnable.BoolValue && bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSEnabledGameModes, g_cvASSDisabledGameModes))
	{
		g_cvASSSaferoomSystemOptions.GetString(g_sSaferoomOption, sizeof(g_sSaferoomOption));
		if (g_cvASSSaferoomEnable.BoolValue && bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSSaferoomEnabledGameModes, g_cvASSSaferoomDisabledGameModes) && StrContains(g_sSaferoomOption, "k", false) != -1 && bIsHumanSurvivor(iDead) && !bIsFinaleMap() && !bIsBuggedMap())
		{
			if (g_bKeyman[iDead])
			{
				vSelectKeyman(iDead, iDead, 0, false);
				for (int iAdmin = 1; iAdmin <= MaxClients; iAdmin++)
				{
					if (bIsHumanSurvivor(iAdmin) && bIsAdminAllowed(iAdmin))
					{
						bHasTranslationFile() ? PrintToChat(iAdmin, "%s %t", ASS_PREFIX01, "KeymanDead") : PrintToChat(iAdmin, "%s A Keyman is dead! Selecting new Keyman...", ASS_PREFIX01);
					}
				}
				CreateTimer(1.0, tTimerChooseKeyman);
			}
		}
		if (g_bMirror[iAttacker] && iDead > 0 && iAttacker != iDead)
		{
			event.SetInt("attacker", GetClientOfUserId(iDead));
			event.SetString("weapon", g_sWeapon);
			event.SetInt("userid", GetClientOfUserId(iAttacker));
			if (g_bHeadshot[iAttacker])
			{
				event.SetBool("headshot", true);
			}
			SetEntProp(iDead, Prop_Data, "m_iFrags", GetClientFrags(iDead) + 1);
			SetEntProp(iAttacker, Prop_Data, "m_iFrags", GetClientFrags(iAttacker) + 1);
		}
	}
}

public Action eEventPlayerSpawnDeath(Event event, const char[] name, bool dontBroadcast)
{
	int iSurvivor = GetClientOfUserId(event.GetInt("userid"));
	g_cvASSSaferoomSystemOptions.GetString(g_sSaferoomOption, sizeof(g_sSaferoomOption));
	if (g_cvASSEnable.BoolValue && g_cvASSSaferoomEnable.BoolValue && StrContains(g_sSaferoomOption, "g", false) != -1 && iSurvivor > 0)
	{
		g_flPlayerAloneStartTime[iSurvivor] = GetEngineTime();
		g_flPlayerSpawnInterval[iSurvivor] = 0.0;
		g_flPlayerSpawnTime[iSurvivor] = GetEngineTime();
		g_iClosestGroup[iSurvivor] = 1;
		g_iStrikeCount[iSurvivor] = 0;
	}
}

public Action eEventSDPlayerUse(Event event, const char[] name, bool dontBroadcast)
{
	int iDoorUser = GetClientOfUserId(event.GetInt("userid"));
	int iDoorEntity = event.GetInt("targetid");
	g_cvASSDelayDoorType.GetString(g_sDoorType, sizeof(g_sDoorType));
	if (((bIsSurvivor(iDoorUser) && g_cvASSCountBots.BoolValue) || (bIsHumanSurvivor(iDoorUser) && !g_cvASSCountBots.BoolValue)) && IsValidEntity(iDoorEntity))
	{
		GetEntityClassname(iDoorEntity, g_sPropName, sizeof(g_sPropName));
		if (StrEqual(g_sPropName, "prop_door_rotating_checkpoint", false) && GetEntProp(iDoorEntity, Prop_Data, "m_eDoorState") == 0)
		{
			if (bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSEnabledGameModes, g_cvASSDisabledGameModes))
			{
				if (!g_cvASSTankAlive.BoolValue)
				{
					if (iGetTankCount() > 0)
					{
						return Plugin_Continue;
					}
				}
				if (g_cvASSEnable.BoolValue && g_cvASSSaferoomEnable.BoolValue && !g_bNull[iDoorUser] && (!g_cvASSAdminImmunity.BoolValue || (g_cvASSAdminImmunity.BoolValue && !bIsAdminAllowed(iDoorUser))) && (!g_cvASSNoFinales.BoolValue || (g_cvASSNoFinales.BoolValue && !bIsFinaleMap())) && StrContains(g_sDoorType, "1", false) != -1 && bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSEnabledGameModes, g_cvASSDisabledGameModes) && bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSSaferoomEnabledGameModes, g_cvASSSaferoomDisabledGameModes))
				{
					HookSingleEntityOutput(iDoorEntity, "OnFullyOpen", vStartAntiSpamDoor);
					HookSingleEntityOutput(iDoorEntity, "OnFullyClose", vStartAntiSpamDoor);
				}
				else if (!g_cvASSEnable.BoolValue || !g_cvASSSaferoomEnable.BoolValue || g_bNull[iDoorUser] || (g_cvASSAdminImmunity && bIsAdminAllowed(iDoorUser)) || (g_cvASSNoFinales.BoolValue && bIsFinaleMap()) || StrContains(g_sDoorType, "1", false) == -1 || !bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSEnabledGameModes, g_cvASSDisabledGameModes) || !bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSSaferoomEnabledGameModes, g_cvASSSaferoomDisabledGameModes))
				{
					UnhookSingleEntityOutput(iDoorEntity, "OnFullyOpen", vStartAntiSpamDoor);
					UnhookSingleEntityOutput(iDoorEntity, "OnFullyClose", vStartAntiSpamDoor);
				}
				vSDoorSpeed(iDoorUser, iDoorEntity);
			}
		}
	}
	return Plugin_Continue;
}

public Action eEventEDPlayerUse(Event event, const char[] name, bool dontBroadcast)
{
	int iDoorUser = GetClientOfUserId(event.GetInt("userid"));
	int iDoorEntity = event.GetInt("targetid");
	g_cvASSDelayDoorType.GetString(g_sDoorType, sizeof(g_sDoorType));
	if (((bIsSurvivor(iDoorUser) && g_cvASSCountBots.BoolValue) || (bIsHumanSurvivor(iDoorUser) && !g_cvASSCountBots.BoolValue)) && IsValidEntity(iDoorEntity))
	{
		GetEntityClassname(iDoorEntity, g_sPropName, sizeof(g_sPropName));
		if (StrEqual(g_sPropName, "prop_door_rotating_checkpoint", false) && GetEntProp(iDoorEntity, Prop_Data, "m_hasUnlockSequence") == 0)
		{
			if (bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSEnabledGameModes, g_cvASSDisabledGameModes))
			{
				if (!g_cvASSTankAlive.BoolValue)
				{
					if (iGetTankCount() > 0)
					{
						return Plugin_Continue;
					}
				}
				if (g_cvASSEnable.BoolValue && g_cvASSSaferoomEnable.BoolValue && !g_bNull[iDoorUser] && (!g_cvASSAdminImmunity.BoolValue || (g_cvASSAdminImmunity.BoolValue && !bIsAdminAllowed(iDoorUser))) && (!g_cvASSNoFinales.BoolValue || (g_cvASSNoFinales.BoolValue && !bIsFinaleMap())) && StrContains(g_sDoorType, "2", false) != -1 && bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSEnabledGameModes, g_cvASSDisabledGameModes) && bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSSaferoomEnabledGameModes, g_cvASSSaferoomDisabledGameModes))
				{
					HookSingleEntityOutput(iDoorEntity, "OnFullyOpen", vStartAntiSpamDoor);
					HookSingleEntityOutput(iDoorEntity, "OnFullyClose", vStartAntiSpamDoor);
				}
				else if (!g_cvASSEnable.BoolValue || !g_cvASSSaferoomEnable.BoolValue || g_bNull[iDoorUser] || (g_cvASSAdminImmunity && bIsAdminAllowed(iDoorUser)) || (g_cvASSNoFinales.BoolValue && bIsFinaleMap()) || StrContains(g_sDoorType, "2", false) == -1 || !bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSEnabledGameModes, g_cvASSDisabledGameModes) || !bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSSaferoomEnabledGameModes, g_cvASSSaferoomDisabledGameModes))
				{
					UnhookSingleEntityOutput(iDoorEntity, "OnFullyOpen", vStartAntiSpamDoor);
					UnhookSingleEntityOutput(iDoorEntity, "OnFullyClose", vStartAntiSpamDoor);
				}
				vEDoorSpeed(iDoorUser, iDoorEntity);
			}
		}
	}
	return Plugin_Continue;
}

public Action eEventSPlayerUse(Event event, const char[] name, bool dontBroadcast)
{
	int iDoorUser = GetClientOfUserId(event.GetInt("userid"));
	int iDoorEntity = event.GetInt("targetid");
	g_cvASSSaferoomSystemOptions.GetString(g_sSaferoomOption, sizeof(g_sSaferoomOption));
	g_cvASSLockdownDoorType.GetString(g_sLockdownType, sizeof(g_sLockdownType));
	if (!g_bDoorLocked[iDoorEntity] || !g_cvASSEnable.BoolValue || !g_cvASSSaferoomEnable.BoolValue || (StrContains(g_sSaferoomOption, "l", false) == -1 && StrContains(g_sLockdownType, "1", false) == -1))
	{
		return Plugin_Continue;
	}
	if (((bIsSurvivor(iDoorUser) && g_cvASSCountBots.BoolValue) || (bIsHumanSurvivor(iDoorUser) && !g_cvASSCountBots.BoolValue)) && g_cvASSEnable.BoolValue && g_cvASSSaferoomEnable.BoolValue && IsValidEntity(iDoorEntity) && g_bDoorLocked[iDoorEntity])
	{
		if (iDoorEntity != g_iDoorId2)
		{
			GetEntityClassname(iDoorEntity, g_sPropName, sizeof(g_sPropName));
			if (StrEqual(g_sPropName, "prop_door_rotating_checkpoint", false))
			{
				if (bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSEnabledGameModes, g_cvASSDisabledGameModes) && bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSSaferoomEnabledGameModes, g_cvASSSaferoomDisabledGameModes))
				{
					if (g_cvASSTankAlive.BoolValue && !g_bBossSpawned)
					{
						if (iGetTankCount() > 0)
						{
							EmitSoundToAll("doors/latchlocked2.wav", iDoorEntity);
							if (bIsHumanSurvivor(iDoorUser))
							{
								bHasTranslationFile() ? PrintHintText(iDoorUser, "%s %t", ASS_PREFIX, "TankAlive") : PrintHintText(iDoorUser, "%s There is a Tank alive.", ASS_PREFIX);
							}
							return Plugin_Continue;
						}
					}
					else if (!g_cvASSTankAlive.BoolValue && !g_bBossSpawned)
					{
						vSDoorControl(iDoorEntity, false);
						return Plugin_Continue;
					}
					AcceptEntityInput(iDoorEntity, "Lock");
					SetEntProp(iDoorEntity, Prop_Data, "m_hasUnlockSequence", 1);
					if (!g_bLockdownStarted)
					{
						if (IsVoteInProgress())
						{
							if (bIsHumanSurvivor(iDoorUser))
							{
								PrintToChat(iDoorUser, "%s %t", ASS_PREFIX01, "Vote in Progress");
							}
							return Plugin_Continue;
						}
						if (g_bNull[iDoorUser] || (g_cvASSAdminImmunity.BoolValue && bIsAdminAllowed(iDoorUser)) || (g_cvASSCountBots.BoolValue && bIsBotSurvivor(iDoorUser)))
						{
							vNoneOption(iDoorEntity, false);
							if (g_cvASSAutoMode.BoolValue)
							{
								g_bLockdownVoted = false;
								g_bLockdownVoteMenu = true;
							}
						}
						else
						{
							if (g_cvASSAutoMode.BoolValue)
							{
								g_bLockdownStarted = true;
							}
							else
							{
								if (!g_bLockdownVoteMenu)
								{
									g_bLockdownVoted = false;
									g_bLockdownVoteMenu = true;
									vLockdownVoteMenu();
								}
							}
						}
					}
					else
					{
						vLockdownOption(iDoorUser, iDoorEntity, false);
					}
				}
			}
		}
	}
	return Plugin_Continue;
}

public Action eEventEPlayerUse(Event event, const char[] name, bool dontBroadcast)
{
	int iDoorUser = GetClientOfUserId(event.GetInt("userid"));
	int iDoorEntity = event.GetInt("targetid");
	g_cvASSSaferoomSystemOptions.GetString(g_sSaferoomOption, sizeof(g_sSaferoomOption));
	g_cvASSLockdownDoorType.GetString(g_sLockdownType, sizeof(g_sLockdownType));
	if (!g_bDoorLocked2[iDoorEntity] || !g_cvASSEnable.BoolValue || !g_cvASSSaferoomEnable.BoolValue || (StrContains(g_sSaferoomOption, "b", false) == -1 && StrContains(g_sSaferoomOption, "f", false) == -1 && StrContains(g_sSaferoomOption, "g", false) == -1 && StrContains(g_sSaferoomOption, "k", false) == -1 && StrContains(g_sSaferoomOption, "l", false) == -1 && StrContains(g_sLockdownType, "2", false) == -1) || bIsFinaleMap() || bIsBuggedMap())
	{
		return Plugin_Continue;
	}
	if (((bIsSurvivor(iDoorUser) && g_cvASSCountBots.BoolValue) || (bIsHumanSurvivor(iDoorUser) && !g_cvASSCountBots.BoolValue)) && g_cvASSEnable.BoolValue && g_cvASSSaferoomEnable.BoolValue && IsValidEntity(iDoorEntity) && g_bDoorLocked2[iDoorEntity])
	{
		if (iDoorEntity != g_iDoorId)
		{
			GetEntityClassname(iDoorEntity, g_sPropName, sizeof(g_sPropName));
			if (StrEqual(g_sPropName, "prop_door_rotating_checkpoint", false))
			{
				if (bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSEnabledGameModes, g_cvASSDisabledGameModes) && bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSSaferoomEnabledGameModes, g_cvASSSaferoomDisabledGameModes))
				{
					if (g_cvASSTankAlive.BoolValue && !g_bBossSpawned)
					{
						if (iGetTankCount() > 0)
						{
							EmitSoundToAll("doors/latchlocked2.wav", iDoorEntity);
							if (bIsHumanSurvivor(iDoorUser))
							{
								bHasTranslationFile() ? PrintHintText(iDoorUser, "%s %t", ASS_PREFIX, "TankAlive") : PrintHintText(iDoorUser, "%s There is a Tank alive.", ASS_PREFIX);
							}
							return Plugin_Continue;
						}
					}
					else if (!g_cvASSTankAlive.BoolValue && !g_bBossSpawned)
					{
						vEDoorControl(iDoorEntity, false);
						return Plugin_Continue;
					}
					AcceptEntityInput(iDoorEntity, "Lock");
					SetEntProp(iDoorEntity, Prop_Data, "m_hasUnlockSequence", 1);
					if (!g_bBossStarted && !g_bFilterStarted && !g_bGroupStarted && !g_bKeymanStarted && !g_bLockdownStarted2)
					{
						if (IsVoteInProgress())
						{
							if (bIsHumanSurvivor(iDoorUser))
							{
								PrintToChat(iDoorUser, "%s %t", ASS_PREFIX01, "Vote in Progress");
							}
							return Plugin_Continue;
						}
						if (g_bNull[iDoorUser] || (g_cvASSAdminImmunity.BoolValue && bIsAdminAllowed(iDoorUser)) || (g_cvASSCountBots.BoolValue && bIsBotSurvivor(iDoorUser)))
						{
							vNoneOption(iDoorEntity, true);
							if (g_cvASSAutoMode.BoolValue)
							{
								g_bBFGKLVoted = false;
								g_bBFGKLVoteMenu = true;
							}
						}
						else
						{
							char sLetters = g_sSaferoomOption[GetRandomInt(0, strlen(g_sSaferoomOption) - 1)];
							if (g_cvASSAutoMode.BoolValue)
							{
								switch (sLetters)
								{
									case 'B', 'b':
									{
										if (!g_bBossStarted)
										{
											g_bBossStarted = true;
										}
									}
									case 'F', 'f':
									{
										if (!g_bFilterStarted)
										{
											g_bFilterStarted = true;
										}
									}
									case 'G', 'g':
									{
										if (!g_bGroupStarted)
										{
											g_bGroupStarted = true;
										}
									}
									case 'K', 'k':
									{
										if (!g_bKeymanStarted)
										{
											g_bKeymanStarted = true;
										}
									}
									case 'L', 'l':
									{
										if (!g_bLockdownStarted2)
										{
											g_bLockdownStarted2 = true;
										}
									}
									default: vNoneOption(iDoorEntity, true);
								}
							}
							else
							{
								if (!g_bBFGKLVoteMenu)
								{
									g_bBFGKLVoted = false;
									g_bBFGKLVoteMenu = true;
									vBFGKLVoteMenu();
								}
							}
						}
					}
					else
					{
						if (g_bBossStarted)
						{
							vBossOption(iDoorUser, iDoorEntity);
						}
						if (g_bFilterStarted)
						{
							vFilterOption(iDoorUser, iDoorEntity);
						}
						if (g_bGroupStarted)
						{
							vGroupOption(iDoorUser, iDoorEntity);
						}
						if (g_bKeymanStarted)
						{
							vKeymanOption(iDoorUser, iDoorEntity);
						}
						if (g_bLockdownStarted2)
						{
							vLockdownOption(iDoorUser, iDoorEntity, true);
						}
					}
				}
			}
		}
	}
	return Plugin_Continue;
}

public Action eEventRoundStart(Event event, const char[] name, bool dontBroadcast)
{
	if (g_cvASSEnable.BoolValue && bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSEnabledGameModes, g_cvASSDisabledGameModes))
	{
		vResetVoteCounts();
		g_cvASSSaferoomSystemOptions.GetString(g_sSaferoomOption, sizeof(g_sSaferoomOption));
		g_cvASSLockdownDoorType.GetString(g_sLockdownType, sizeof(g_sLockdownType));
		if (g_cvASSSaferoomEnable.BoolValue && bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSSaferoomEnabledGameModes, g_cvASSSaferoomDisabledGameModes))
		{
			if (StrContains(g_sSaferoomOption, "l", false) != -1 && StrContains(g_sLockdownType, "1", false) != -1)
			{
				vSInitializeDoor();
			}
			if ((StrContains(g_sSaferoomOption, "b", false) != -1 || StrContains(g_sSaferoomOption, "f", false) != -1 || StrContains(g_sSaferoomOption, "g", false) != -1 || StrContains(g_sSaferoomOption, "k", false) != -1 || (StrContains(g_sSaferoomOption, "l", false) != -1 && StrContains(g_sLockdownType, "2", false) != -1)) && !bIsFinaleMap() && !bIsBuggedMap())
			{
				vEInitializeDoor();
				vResetGroupCounts();
				vResetVoteMenus();
 				if (StrContains(g_sSaferoomOption, "k", false) != -1)
				{
					vKeymanStats();
				}
			}
		}
		g_sWeapon[0] = '\0';
		for (int iPlayer= 1; iPlayer <= MaxClients; iPlayer++)
		{
			g_bHeadshot[iPlayer] = false;
			g_bMirror[iPlayer] = false;
			vResetPlayerMenu(iPlayer);
		}
		CreateTimer(10.0, tTimerRestartCoordinates);
	}
}

public Action eEventRoundEnd(Event event, const char[] name, bool dontBroadcast)
{
	if (g_cvASSEnable.BoolValue && bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSEnabledGameModes, g_cvASSDisabledGameModes))
	{
		g_cvASSSaferoomSystemOptions.GetString(g_sSaferoomOption, sizeof(g_sSaferoomOption));
		if (g_cvASSSaferoomEnable.BoolValue && bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSSaferoomEnabledGameModes, g_cvASSSaferoomDisabledGameModes) && !bIsFinaleMap() && !bIsBuggedMap() && StrContains(g_sSaferoomOption, "k", false) != -1)
		{
			vKeymanStats();
			for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
			{
				if (g_bKeyman[iPlayer])
				{
					vSelectKeyman(iPlayer, iPlayer, 0, false);
				}
				if (bIsHumanSurvivor(iPlayer) && bIsAdminAllowed(iPlayer))
				{
					bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "KeymanReset") : PrintToChat(iPlayer, "%s Resetting Keymen...", ASS_PREFIX01);
				}
			}
		}
	}
}

public Action eEventServerEnd(Event event, const char[] name, bool dontBroadcast)
{
	vKillReset();
}

public void eEventLeftCheckpoint(Event event, const char[] name, bool dontBroadcast)
{
	int iDoorEntity = event.GetInt("entityid");
	int iLeaver = GetClientOfUserId(event.GetInt("userid"));
	g_cvASSSaferoomSystemOptions.GetString(g_sSaferoomOption, sizeof(g_sSaferoomOption));
	if (g_cvASSEnable.BoolValue && g_cvASSSaferoomEnable.BoolValue && StrContains(g_sSaferoomOption, "k", false) != -1 && bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSEnabledGameModes, g_cvASSDisabledGameModes) && bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSSaferoomEnabledGameModes, g_cvASSSaferoomDisabledGameModes))
	{
		if (g_bStarted[iLeaver] && iLeaver > 0 && iDoorEntity == 0 && !g_bLeftSaferoom)
		{
			CreateTimer(0.5, tTimerLeftSafeArea, iLeaver);
		}
	}
}

public void eEventJoinTeam(Event event, const char[] name, bool dontBroadcast)
{
	int iPlayer = GetClientOfUserId(event.GetInt("userid"));
	g_cvASSSaferoomSystemOptions.GetString(g_sSaferoomOption, sizeof(g_sSaferoomOption));
	if (g_cvASSEnable.BoolValue && bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSEnabledGameModes, g_cvASSDisabledGameModes))
	{
		if (g_cvASSSaferoomEnable.BoolValue && bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSSaferoomEnabledGameModes, g_cvASSSaferoomDisabledGameModes) && StrContains(g_sSaferoomOption, "k", false) != -1 && bIsHumanSurvivor(iPlayer) && !bIsFinaleMap() && !bIsBuggedMap())
		{
			if (!g_bLeftSaferoom)
			{
				vSetStarted(false);
			}
			if (g_bKeyman[iPlayer] && !bIsHumanSurvivor(iPlayer))
			{
				vSelectKeyman(iPlayer, iPlayer, 0, false);
				for (int iAdmin = 1; iAdmin <= MaxClients; iAdmin++)
				{
					if (bIsHumanSurvivor(iAdmin) && bIsAdminAllowed(iAdmin))
					{
						bHasTranslationFile() ? PrintToChat(iAdmin, "%s %t", ASS_PREFIX01, "KeymanTeam") : PrintToChat(iAdmin, "%s A Keyman has changed their team! Selecting new Keyman...", ASS_PREFIX01);
					}
				}
			}
			CreateTimer(1.0, tTimerChooseKeyman);
		}
	}
}

public Action OnPlayerRunCmd(int client, int &buttons, int &impulse, float vel[3], float angles[3], int &weapon)
{
	if (!bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSEnabledGameModes, g_cvASSDisabledGameModes))
	{
		return Plugin_Continue;
	}
	if (g_bInvert[client])
	{
		if (g_iButtonType[client] == 1 || g_iButtonType[client] == 0)
		{
			vel[1] = -vel[1];
			if (buttons & IN_MOVELEFT)
			{
				buttons &= ~IN_MOVELEFT;
				buttons |= IN_MOVERIGHT;
			}
			else if (buttons & IN_MOVERIGHT)
			{
				buttons &= ~IN_MOVERIGHT;
				buttons |= IN_MOVELEFT;
			}
		}
		if (g_iButtonType[client] == 2 || g_iButtonType[client] == 0)
		{
			vel[0] = -vel[0];
			if (buttons & IN_FORWARD)
			{
				buttons &= ~IN_FORWARD;
				buttons |= IN_BACK;
			}
			else if (buttons & IN_BACK)
			{
				buttons &= ~IN_BACK;
				buttons |= IN_FORWARD;
			}
		}
		return Plugin_Changed;
	}
	if (bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSSaferoomEnabledGameModes, g_cvASSSaferoomDisabledGameModes) && !bIsFinaleMap() && !bIsBuggedMap())
	{
		if (buttons & IN_MOVELEFT || buttons & IN_BACK || buttons & IN_FORWARD || buttons & IN_MOVERIGHT || buttons & IN_USE)
		{
			if (bIsSurvivor(client))
			{
				if (!bIsBotSurvivor(client))
				{
					g_bPlayerMoved = true;
				}
				if (g_bPlayerMoved)
				{
					g_bStarted[client] = true;
				}
			}
		}
	}
	return Plugin_Continue;
}

void vSDoorControl(int entity, bool operation)
{
	if (IsValidEntity(entity) && HasEntProp(entity, Prop_Data, "m_eDoorState"))
	{
		if (operation)
		{
			g_bDoorLocked[entity] = true;
			SetEntProp(entity, Prop_Data, "m_hasUnlockSequence", 1);
			AcceptEntityInput(entity, "Close");
			AcceptEntityInput(entity, "Lock");
			AcceptEntityInput(entity, "ForceClosed");
		}
		else
		{
			g_bDoorLocked[entity] = false;
			SetEntProp(entity, Prop_Data, "m_hasUnlockSequence", 0);
			AcceptEntityInput(entity, "Unlock");
			AcceptEntityInput(entity, "ForceClosed");
			AcceptEntityInput(entity, "Open");
		}
	}
}

void vEDoorControl(int entity, bool operation)
{
	if (IsValidEntity(entity) && HasEntProp(entity, Prop_Data, "m_hasUnlockSequence"))
	{
		if (operation)
		{
			g_bDoorLocked2[entity] = true;
			SetEntProp(entity, Prop_Data, "m_hasUnlockSequence", 1);
			AcceptEntityInput(entity, "Close");
			AcceptEntityInput(entity, "Lock");
			AcceptEntityInput(entity, "ForceClosed");
		}
		else
		{
			g_bDoorLocked2[entity] = false;
			SetEntProp(entity, Prop_Data, "m_hasUnlockSequence", 0);
			AcceptEntityInput(entity, "Unlock");
			AcceptEntityInput(entity, "ForceClosed");
			AcceptEntityInput(entity, "Open");
		}
	}
}

void vEntryMode(int entity)
{
	if (g_cvASSSaferoomEntryMode.BoolValue)
	{
		EmitSoundToAll("doors/door_squeek1.wav", entity);
		vEDoorControl(entity, false);
	}
	else
	{
		if (!g_bEntryStarted)
		{
			g_bEntryStarted = true;
			if (g_hWarpTimer == null)
			{
				g_hWarpTimer = CreateTimer(1.0, tTimerWarpCountdown, entity, TIMER_REPEAT);
			}
			CreateTimer(g_cvASSSaferoomWarpCountdown.FloatValue + 1.0, tTimerWarpSurvivors);
		}
		else
		{
			EmitSoundToAll("doors/latchlocked2.wav", entity);
		}
	}
}

void vEntryOption()
{
	if (g_cvASSSaferoomEntryMode.BoolValue)
	{
		vNoneOption(g_iDoorId2, true);
	}
	else
	{
		vEntryCommand();
	}
}

void vEntryCommand()
{
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		if (bIsValidClient(iPlayer))
		{
			vEntry(iPlayer, false);
			break;
		}
	}
}

void vEntryModeSettings()
{
	g_bEntryStarted = false;
	if (g_hWarpTimer != null)
	{
		KillTimer(g_hWarpTimer);
		g_hWarpTimer = null;
	}
	g_iWarpCountdown = g_cvASSSaferoomWarpCountdown.IntValue;
}

void vSInitializeDoor()
{
	int iSafeAreaEntity = -1;
	while ((iSafeAreaEntity = FindEntityByClassname(iSafeAreaEntity, "prop_door_rotating_checkpoint")) != INVALID_ENT_REFERENCE)
	{
		if (GetEntProp(iSafeAreaEntity, Prop_Data, "m_eDoorState") == 0)
		{
			g_iDoorId = iSafeAreaEntity;
			vSDoorControl(iSafeAreaEntity, true);
		}
	}
}

void vEInitializeDoor()
{
	int iCheckpointEntity = -1;
	while ((iCheckpointEntity = FindEntityByClassname(iCheckpointEntity, "prop_door_rotating_checkpoint")) != INVALID_ENT_REFERENCE)
	{
		if (GetEntProp(iCheckpointEntity, Prop_Data, "m_hasUnlockSequence") == 0)
		{
			g_iDoorId2 = iCheckpointEntity;
			vEDoorControl(iCheckpointEntity, true);
		}
	}
}

void vStrikeOptions(int mode, int target, int client, ConVar convar)
{
	convar.GetString(g_sStrikeOption, sizeof(g_sStrikeOption));
	switch (mode)
	{
		case 0:
		{
			char sLetters = g_sStrikeOption[GetRandomInt(0, strlen(g_sStrikeOption) - 1)];
			switch (sLetters)
			{
				case 'A', 'a': vSlowSpeedrunners(target, client, 1, false);
				case 'B', 'b': vDrugSpeedrunners(target, client, 1, false);
				case 'C', 'c': vBlindSpeedrunners(target, client, 1, false);
				case 'D', 'd': vShoveSpeedrunners(target, client, 1, false, 1);
				case 'E', 'e': vShakeSpeedrunners(target, client, 1, false, 1);
				case 'F', 'f': vFreezeSpeedrunners(target, client, 1, false);
				case 'G', 'g': vInvertSpeedrunners(target, client, 1, false);
				case 'H', 'h': vRestartSpeedrunners(target, client, false);
				case 'I', 'i': vWarpSpeedrunners(target, client, false);
				case 'J', 'j': vAmmoSpeedrunners(target, client, 1, false, 0, 1);
				case 'K', 'k': vDisarmSpeedrunners(target, client, 1, false, g_iWeaponSlot[target], 1);
				case 'L', 'l': vHurtSpeedrunners(target, client, 1, false, g_cvASSHurtDamageAmount.IntValue, 1);
				case 'M', 'm': vMirrorSpeedrunners(target, client, 1, false);
				case 'N', 'n': vFireSpeedrunners(target, client, 1, false, 1);
				case 'O', 'o': vHealSpeedrunners(target, client, false);
				case 'P', 'p': vVisionSpeedrunners(target, client, 1, false, 160, 1);
				case 'Q', 'q': vIncapSpeedrunners(target, client, 1, false, 1);
				case 'R', 'r': vRocketSpeedrunners(target, client, false);
				case 'S', 's': vShockSpeedrunners(target, client, false);
				case 'T', 't': vExplodeSpeedrunners(target, client, false);
				case 'U', 'u': vPukeSpeedrunners(target, client, 1, false);
				case 'V', 'v': vChaseSpeedrunners(target, client, false);
				case 'W', 'w': bIsL4D2Game() ? vAcidSpeedrunners(target, client, 1, false, 1) : vPukeSpeedrunners(target, client, 1, false);
				case 'X', 'x': bIsL4D2Game() ? vChargeSpeedrunners(target, client, 1, false, 1) : vChaseSpeedrunners(target, client, false);
				case 'Y', 'y': vIdleSpeedrunners(target, client, false);
				case 'Z', 'z': !g_cvASSExileMode.BoolValue ? vExileSpeedrunners(target, client, 0, false) : vExileSpeedrunners(target, client, 1, false);
				default: vWarpSpeedrunners(target, client, false);
			}
		}
		case 1:
		{
			if (StrContains(g_sStrikeOption, "a", false) != -1)
			{
				vSlowSpeedrunners(target, client, 1, false);
			}
			if (StrContains(g_sStrikeOption, "b", false) != -1)
			{
				vDrugSpeedrunners(target, client, 1, false);
			}
			if (StrContains(g_sStrikeOption, "c", false) != -1)
			{
				vBlindSpeedrunners(target, client, 1, false);
			}
			if (StrContains(g_sStrikeOption, "d", false) != -1)
			{
				vShoveSpeedrunners(target, client, 1, false, 1);
			}
			if (StrContains(g_sStrikeOption, "e", false) != -1)
			{
				vShakeSpeedrunners(target, client, 1, false, 1);
			}
			if (StrContains(g_sStrikeOption, "f", false) != -1)
			{
				vFreezeSpeedrunners(target, client, 1, false);
			}
			if (StrContains(g_sStrikeOption, "g", false) != -1)
			{
				vInvertSpeedrunners(target, client, 1, false);
			}
			if (StrContains(g_sStrikeOption, "h", false) != -1)
			{
				vRestartSpeedrunners(target, client, false);
			}
			if (StrContains(g_sStrikeOption, "i", false) != -1 || g_sStrikeOption[0] == '\0')
			{
				vWarpSpeedrunners(target, client, false);
			}
			if (StrContains(g_sStrikeOption, "j", false) != -1)
			{
				vAmmoSpeedrunners(target, client, 1, false, 0, 1);
			}
			if (StrContains(g_sStrikeOption, "k", false) != -1)
			{
				vDisarmSpeedrunners(target, client, 1, false, g_iWeaponSlot[target], 1);
			}
			if (StrContains(g_sStrikeOption, "l", false) != -1)
			{
				vHurtSpeedrunners(target, client, 1, false, g_cvASSHurtDamageAmount.IntValue, 1);
			}
			if (StrContains(g_sStrikeOption, "m", false) != -1)
			{
				vMirrorSpeedrunners(target, client, 1, false);
			}
			if (StrContains(g_sStrikeOption, "n", false) != -1)
			{
				vFireSpeedrunners(target, client, 1, false, 1);
			}
			if (StrContains(g_sStrikeOption, "o", false) != -1)
			{
				vHealSpeedrunners(target, client, false);
			}
			if (StrContains(g_sStrikeOption, "p", false) != -1)
			{
				vVisionSpeedrunners(target, client, 1, false, 160, 1);
			}
			if (StrContains(g_sStrikeOption, "q", false) != -1)
			{
				vIncapSpeedrunners(target, client, 1, false, 1);
			}
			if (StrContains(g_sStrikeOption, "r", false) != -1)
			{
				vRocketSpeedrunners(target, client, false);
			}
			if (StrContains(g_sStrikeOption, "s", false) != -1)
			{
				vShockSpeedrunners(target, client, false);
			}
			if (StrContains(g_sStrikeOption, "t", false) != -1)
			{
				vExplodeSpeedrunners(target, client, false);
			}
			if (StrContains(g_sStrikeOption, "u", false) != -1)
			{
				vPukeSpeedrunners(target, client, 1, false);
			}
			if (StrContains(g_sStrikeOption, "v", false) != -1)
			{
				vChaseSpeedrunners(target, client, false);
			}
			if (StrContains(g_sStrikeOption, "w", false) != -1)
			{
				bIsL4D2Game() ? vAcidSpeedrunners(target, client, 1, false, 1) : vPukeSpeedrunners(target, client, 1, false);
			}
			if (StrContains(g_sStrikeOption, "x", false) != -1)
			{
				bIsL4D2Game() ? vChargeSpeedrunners(target, client, 1, false, 1) : vChaseSpeedrunners(target, client, false);
			}
			if (StrContains(g_sStrikeOption, "y", false) != -1)
			{
				vIdleSpeedrunners(target, client, false);
			}
			if (StrContains(g_sStrikeOption, "z", false) != -1)
			{
				!g_cvASSExileMode.BoolValue ? vExileSpeedrunners(target, client, 0, false) : vExileSpeedrunners(target, client, 1, false);
			}
		}
	}
}

void vKillReset()
{
	g_bRestartValid = false;
	vKillAutoCheckTimer();
	vResetGroupCounts();
	vResetVoteCounts();
	vResetVoteMenus();
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		g_bAdminMenu[iPlayer] = false;
		g_bNull[iPlayer] = false;
		vKillCheckTimer(iPlayer);
		vResetPlayerMenu(iPlayer);
		vResetPlayerStats(iPlayer);
	}
}

void vResetPlayerStats(int client)
{
	vKillAcidTimer(client);
	vKillAmmoTimer(client);
	g_bBlind[client] = false;
	vKillChargeTimer(client);
	vKillDisarmTimer(client);
	vKillDrugTimer(client);
	vKillFireTimer(client);
	vKillFreezeTimer(client);
	g_bHeadshot[client] = false;
	vKillHurtTimer(client);
	g_bIdle[client] = false;
	vKillIncapTimer(client);
	g_bInvert[client] = false;
	g_bMirror[client] = false;
	vKillPukeTimer(client);
	g_bRestart[client] = false;
	vKillShakeTimer(client);
	vKillShoveTimer(client);
	g_bSlow[client] = false;
	vKillVisionTimer(client);
}

void vResetPlayerMenu(int client)
{
	g_bAcidMenu[client] = false;
	g_bAmmoMenu[client] = false;
	g_bBlindMenu[client] = false;
	g_bChargeMenu[client] = false;
	g_bChaseMenu[client] = false;
	g_bCheckMenu[client] = false;
	g_bDisarmMenu[client] = false;
	g_bDrugMenu[client] = false;
	g_bExileMenu[client] = false;
	g_bExplodeMenu[client] = false;
	g_bFireMenu[client] = false;
	g_bFreezeMenu[client] = false;
	g_bHealMenu[client] = false;
	g_bHurtMenu[client] = false;
	g_bIdleMenu[client] = false;
	g_bIncapMenu[client] = false;
	g_bInvertMenu[client] = false;
	g_bKeymanMenu[client] = false;
	g_bMirrorMenu[client] = false;
	g_bNullMenu[client] = false;
	g_bPukeMenu[client] = false;
	g_bRestartMenu[client] = false;
	g_bRocketMenu[client] = false;
	g_bShakeMenu[client] = false;
	g_bShockMenu[client] = false;
	g_bShoveMenu[client] = false;
	g_bSlowMenu[client] = false;
	g_bStrikeMenu[client] = false;
	g_bVisionMenu[client] = false;
	g_bWarpMenu[client] = false;
}

void vResetVoteCounts()
{
	g_iVotes = 0;
	g_iTotalVotes = 0;
}

void vResetVoteMenus()
{
	vBossSettings();
	vFilterSettings();
	vGroupSettings();
	vKeymanSettings();
	vLockdownSettings();
	vEntryModeSettings();
	g_bLockdownVoted = false;
	g_bBFGKLVoted = false;
}

void vCreateConVar(ConVar &convar, const char[] name, const char[] defaultValue, const char[] description = "", int flags = 0, bool hasMin = false, float min = 0.0, bool hasMax = false, float max = 0.0)
{
	convar = cvASS_ConVar(name, defaultValue, description, flags, hasMin, min, hasMax, max);
	convar.AddChangeHook(vSwitchCvars);
	vSwitchCvars(convar, defaultValue, defaultValue);
}

public void vSwitchCvars(ConVar convar, const char[] oldValue, const char[] newValue)
{
	char sConVars[64];
	convar.GetName(sConVars, sizeof(sConVars));
	char sName[64];
	char sValue[2049];
	Format(sName, sizeof(sName), sConVars);
	Format(sValue, sizeof(sValue), "%s", newValue);
	TrimString(sValue);
	if (StrContains(newValue, ASS_LOCK) == 0)
	{
		strcopy(sValue, sizeof(sValue), sValue[2]);
		TrimString(sValue);
		g_smConVars.SetString(sName, sValue, true);
	}
	else if (StrContains(newValue, ASS_UNLOCK) == 0)
	{
		strcopy(sValue, sizeof(sValue), sValue[2]);
		TrimString(sValue);
		g_smConVars.Remove(sName);
	}
	g_smConVars.GetString(sName, sValue, sizeof(sValue));
	if (!StrEqual(newValue, sValue))
	{
		convar.SetString(sValue);
	}
}

public void vASSAdminImmunityCvar(ConVar convar, const char[] oldValue, const char[] newValue)
{
	if (!g_cvASSEnable.BoolValue || !g_cvASSAdminImmunity.BoolValue || (g_cvASSEnable.BoolValue && g_cvASSAdminImmunity.BoolValue))
	{
		for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
		{
			if ((bIsSurvivor(iPlayer) && g_cvASSCountBots.BoolValue) || (bIsHumanSurvivor(iPlayer) && !g_cvASSCountBots.BoolValue))
			{
				vResetStats(iPlayer);
			}
		}
	}
}

public void vASSAutoModeCvar(ConVar convar, const char[] oldValue, const char[] newValue)
{
	if (!g_cvASSEnable.BoolValue || !g_cvASSAutoMode.BoolValue || !g_cvASSStrikeEnable.BoolValue || (g_cvASSEnable.BoolValue && g_cvASSAutoMode.BoolValue && g_cvASSStrikeEnable.BoolValue))
	{
		for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
		{
			vKillCheckTimer(iPlayer);
		}
	}
	if (!g_cvASSEnable.BoolValue || !g_cvASSAutoMode.BoolValue || !g_cvASSStrikeEnable.BoolValue)
	{
		for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
		{
			g_iStrikeCount[iPlayer] = 0;
		}
		vKillAutoCheckTimer();
	}
	else if (g_cvASSEnable.BoolValue && g_cvASSAutoMode.BoolValue && g_cvASSStrikeEnable.BoolValue)
	{
		vAutoCheckSpeedrunners(1);
	}
}

public void vGameModeCvars(ConVar convar, const char[] oldValue, const char[] newValue)
{
	g_cvASSSaferoomSystemOptions.GetString(g_sSaferoomOption, sizeof(g_sSaferoomOption));
	if (!g_cvASSEnable.BoolValue || !bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSEnabledGameModes, g_cvASSDisabledGameModes))
	{
		for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
		{
			vResetPlayerMenu(iPlayer);
		}
		if (g_cvASSAutoMode.BoolValue && g_cvASSStrikeEnable.BoolValue)
		{
			for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
			{
				vKillCheckTimer(iPlayer);
				vResetPlayerStats(iPlayer);
				g_iStrikeCount[iPlayer] = 0;
			}
			vKillAutoCheckTimer();
		}
		if (g_cvASSAdminImmunity.BoolValue)
		{
			for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
			{
				if ((bIsSurvivor(iPlayer) && g_cvASSCountBots.BoolValue) || (bIsHumanSurvivor(iPlayer) && !g_cvASSCountBots.BoolValue))
				{
					vResetStats(iPlayer);
				}
			}
		}
	}
	else if (g_cvASSEnable.BoolValue && bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSEnabledGameModes, g_cvASSDisabledGameModes))
	{
		for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
		{
			vResetPlayerMenu(iPlayer);
		}
		if (g_cvASSAutoMode.BoolValue && g_cvASSStrikeEnable.BoolValue)
		{
			vAutoCheckSpeedrunners(1);
		}
	}
}

public Action tTimerUpdateIncapCount(Handle timer)
{
	if (!g_cvASSEnable.BoolValue || !bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSEnabledGameModes, g_cvASSDisabledGameModes))
	{
		return Plugin_Continue;
	}
	int iAlive = iGetSurvivorCount();
	int iIncapacitated = g_cvASSIncapacitatedCount.IntValue;
	int iIncapacitatedCount = iGetIncapCount();
	int iRevived = g_cvASSRevivedCount.IntValue;
	int iRevivedCount = iGetReviveCount();
	if (iIncapacitated > iAlive)
	{
		iAlive > 1 ? (iIncapacitated = iAlive - 1) : (iIncapacitated = 0);
	}
	if (iRevived > iAlive)
	{
		iAlive > 1 ? (iRevived = iAlive - 1) : (iRevived = 2);
	}
	if (iRevived != 0)
	{
		if (iRevivedCount >= iRevived)
		{
			if (g_cvASSFailsafe.BoolValue)
			{
				g_cvASSSaferoomEnable.SetString("1");
				g_cvASSStrikeEnable.SetString("1");
			}
		}
	}
	if ((iAlive > 1 && iIncapacitated != 0) || (iAlive < 2 && iIncapacitated == 0))
	{
		if (iIncapacitatedCount >= iIncapacitated)
		{
			if (g_cvASSFailsafe.BoolValue)
			{
				g_cvASSSaferoomEnable.SetString("0");
				g_cvASSStrikeEnable.SetString("0");
			}
		}
	}
	return Plugin_Continue;
}

public Action tTimerLeftSafeArea(Handle timer, any client)
{
	g_cvASSSaferoomSystemOptions.GetString(g_sSaferoomOption, sizeof(g_sSaferoomOption));
	if (!g_cvASSEnable.BoolValue || !g_cvASSSaferoomEnable.BoolValue || StrContains(g_sSaferoomOption, "k", false) == -1 || client == 0 || !IsClientInGame(client) || g_bLeftSaferoom || !bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSEnabledGameModes, g_cvASSDisabledGameModes) || !bIsSystemValid(FindConVar("mp_gamemode"), g_cvASSSaferoomEnabledGameModes, g_cvASSSaferoomDisabledGameModes) || bIsFinaleMap() || bIsBuggedMap())
	{
		return Plugin_Stop;
	}
	g_bLeftSaferoom = true;
	vSetStarted(true);
	if (!bIsSurvivor(client))
	{
		g_bStarted[client] = false;
		return Plugin_Stop;
	}
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		if (bIsHumanSurvivor(iPlayer) && bIsAdminAllowed(iPlayer) && client != 0)
		{
			bIsBotSurvivor(client) ? (bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "BOTLeftSafeArea", client) : PrintToChat(iPlayer, "%s The BOT %N left the safe area!", ASS_PREFIX01, client)) : (bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "PlayerLeftSafeArea", client) : PrintToChat(iPlayer, "%s The player %N left the safe area!", ASS_PREFIX01, client));
		}
	}
	if (g_iKeymanCount < g_cvASSKeymanKeymanAmount.IntValue || (!bIsHumanSurvivor(client) && g_bKeyman[client]))
	{
		for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
		{
			if (bIsHumanSurvivor(iPlayer) && bIsAdminAllowed(iPlayer))
			{
				bHasTranslationFile() ? PrintToChat(iPlayer, "%s %t", ASS_PREFIX01, "KeymanSelect") : PrintToChat(iPlayer, "%s Selecting new Keymen...", ASS_PREFIX01);
			}
		}
		CreateTimer(1.0, tTimerChooseKeyman);
	}
	return Plugin_Stop;
}

public Action tTimerWarpCountdown(Handle timer, any entity)
{
	EmitSoundToAll("buttons/button14.wav", entity);
	g_iWarpCountdown--;
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		if (bIsHumanSurvivor(iPlayer))
		{
			bHasTranslationFile() ? PrintHintText(iPlayer, "%s %t", ASS_PREFIX, "EntryCountdown", g_iWarpCountdown) : PrintHintText(iPlayer, "%s Warping survivors inside in %d.", ASS_PREFIX, g_iWarpCountdown);
		}
	}
	return Plugin_Continue;
}

public Action tTimerWarpSurvivors(Handle timer)
{
	if (g_hWarpTimer != null)
	{
		vEntryCommand();
		g_bEntryStarted = false;
		g_iWarpCountdown = g_cvASSSaferoomWarpCountdown.IntValue;
		KillTimer(g_hWarpTimer);
		g_hWarpTimer = null;
	}
}