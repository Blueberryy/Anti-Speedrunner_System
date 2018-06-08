# Anti-Speedrunner System
One day I just got tired of seeing players run off on their own or in small groups because they're too impatient to work as a team. I searched for every efficient, effective, and working plugin to counter this issue. I wouldn't say that this is the best plugin to counter all forms of rushing, but it does a pretty awesome job at dealing with those pesky players. With that said, I hope you enjoy!

## License
Anti-Speedrunner System: a L4D/L4D2 SourceMod Plugin
Copyright (C) 2017  Alfred "Crasher_3637/Psyk0tik" Llagas

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

## About
The Anti-Speedrunner System provides various options for dealing with players that speedrun through campaigns and making sure survivors stick together!

> The Anti-Speedrunner System aims to be one of, if not the most ideal system for dealing with speedrunners, or players that rush. This, however, does not guarantee that every arbitrary scenario/situation will be handled by the system.

### What makes the Anti-Speedrunner System viable in Left 4 Dead/Left 4 Dead 2?
Well, it's simple. The system provides various options for making sure that survivors stick together. Whether you're the kind of admin that wants to brutally punish players that rush, or just give them a little slap on the wrist, the Anti-Speedrunner System will have an option that you'll find useful/ideal for many situations.

### Requirements
The Anti-Speedrunner System was developed against SourceMod 1.8+.

### Installation
1. Delete files from old versions of the plugin.
2. Extract the folder inside the .zip file.
3. Place anti-speedrunner_system.phrases.txt into addons/sourcemod/translations folder.
4. Place all the contents into their respective folders.
5. If prompted to replace or merge anything, click yes.
6. Load up the Anti-Speedrunner System.
  - Type ```sm_rcon sm plugins load anti-speedrunner_system``` in console.
  - OR restart the server.
7. Customize the Anti-Speedrunner_System (Config file generated on first load).

### Uninstalling/Upgrading to Newer Versions
1. Delete anti-speedrunner_system.smx from addons/sourcemod/plugins folder.
2. Delete anti-speedrunner_system.phrases.txt from addons/sourcemod/translations folder.
3. Delete anti-speedrunner_system.txt from addons/sourcemod/gamedata folder.
4. Delete anti-speedrunner_system folder from addons/sourcemod/scripting folder.
5. Delete anti-speedrunner_system.inc from addons/sourcemod/scripting/include folder.
6. Delete anti-speedrunner_system folder from cfg/sourcemod folder.
7. Follow the Installation guide above. (Only for upgrading to newer versions.)

### Disabling
1. Move anti-speedrunner_system.smx to plugins/disabled folder.
2. Unload the Anti-Speedrunner System.
  - Type ```sm_rcon sm plugins unload anti-speedrunner_system``` in console.
  - OR restart the server.

## Features
1. Automatic mode - Provides the option to run a timer at the start of each map to keep track of who is speedrunning.
2. Admin commands - Provides a variety of commands to manipulate the different system options.
3. Admin immunity - Provides the option to give admins with the generic flag or the "ass_override" command immunity.
4. Admin menu - Provides a category on the admin menu for the plugin.
5. Player immunity - Provides a command to give players temporary immunity per map.
6. Finale exception - Provides the option to automatically disable all systems on finale maps.
7. Count bots as players - Provides the option to decide whether bots are affected by the system.
8. Tank detection - Provides the option to keep the plugin enabled/disabled during Tank fights.
9. Failsafe function - Provides the option to keep the plugin enabled/disabled after a certain amount of survivors are incapacitated/revived.
10. Supports multiple game modes - Provides the option to enable/disable the plugin in certain game modes.
11. Custom configurations - Provides support for custom configurations, whether per difficulty, per map, per game mode, per day, or per player count.
12. Automatic config updater - Provides the ability to update the main config file when new convars are added.
13. Menus - Provides menus for admin commands.
14. Custom target list - Provides a menu list of players with similar names when one of them is targeted.
14. Lock saferoom doors - Provides options for unlocking ending saferoom doors. If an invalid option or no option is chosen, the door immediately opens.
15. Track speedrunners - Provides options for dealing with speedrunners. If an invalid option or no option is chosen, speedrunners will be warped back to the nearest teammate.
16. Survivor and Infected target filters - Provides custom target filters. (Use @survivors for survivors and @infected for infected.)
17. Log command usage - Provides the option to log command usage.
18. Supports multiple languages - Provides support for translations. [Click here to add support for your language!](http://translator.mitchdempsey.com/sourcemod_plugins/309) (I check everyday so I can update the translation file attached to this post, but you can private message me as well to make sure.)

## Commands
```
[Commands]			[Flags]		[Description]
ass_acid			Kick (c)	Spawn an acid puddle under a player for speedrunning
ass_ammo			Kick (c)	Set a player's ammunition count to 0 for speedrunning.
ass_blind			Kick (c)	Blind a player for speedrunning.
ass_charge			Kick (c)	Charge at a player for speedrunning.
ass_chase			Kick (c)	Spawn a special infected to chase a player for speedrunning.
ass_check			Kick (c)	Run a timer on a player to check for speedrunning.
ass_config			Root (z)	Create a custom config in-game.
ass_disarm			Kick (c)	Disarm a player for speedrunning.
ass_door			Kick (c)	Manually lock/unlock saferoom doors.
ass_drug			Kick (c)	Drug a player for speedrunning.
ass_entry			Root (z)	Warp all survivors inside the saferoom.
ass_exile			Ban (d)		Exile a player for speedrunning.
ass_explode			Slay (f)	Cause an explosion on a player for speedrunning.
ass_fire			Kick (c)	Set a player on fire for speedrunning.
ass_freeze			Kick (c)	Freeze a player for speedrunning.
ass_heal			Kick (c)	Set a player to black and white with temporary health for speedrunning.
ass_hurt			Kick (c)	Hurt a player for speedrunning.
ass_idle			Slay (f)	Force a player to go idle for speedrunning.
ass_incap			Kick (c)	Incapacitate a player for speedrunning.
ass_invert			Kick (c)	Invert a player's movement keys for speedrunning.
ass_key				Kick (c)	Choose a new Keyman.
ass_null			Root (z)	Give a player immunity.
ass_puke			Kick (c)	Puke on a player for speedrunning.
ass_restart			Kick (c)	Cause a player to restart at the spawn area for speedrunning.
ass_rocket			Slay (f)	Send a player into space for speedrunning.
ass_room			Root (z)	Manually set the entry method for ending saferoom doors.
ass_shake			Kick (c)	Shake a player's screen for speedrunning.
ass_shock			Slay (f)	Shock a player for speedrunning.
ass_shove			Kick (c)	Shove a player for speedrunning.
ass_slow			Kick (c)	Slow a player down for speedrunning.
ass_strike			Root (z)	Give a player a strike for speedrunning.
ass_third			Kick (c)	Force a player to switch between firstperson and thirdperson for speedrunning.
ass_vision			Kick (c)	Change a player's vision for speedrunning.
ass_warp			Kick (c)	Warp a player to your position for speedrunning.
```

## Overrides
```
ass_override
```

## Configuration Variables (ConVars/CVars)
```
// Should admins with the generic flag or "ass_override" override command be immune to the Anti-Speedrunner System?
// (0: OFF)
// (1: ON)
// -
// Default: "0"
ass_adminimmunity "0"

// Enable the Anti-Speedrunner System's automatic mode?
// (0: OFF)
// (1: ON)
// -
// Default: "1"
ass_automode "1"

// Allow the use of admin commands during automatic mode?
// (0: OFF)
// (1: ON)
// -
// Default: "1"
ass_commandoverride "1"

// Should the Anti-Speedrunner System count bots as players?
// (0: OFF)
// (1: ON)
// -
// Default: "1"
ass_countbots "1"

// Disable the Anti-Speedrunner System in these game modes.
// Separate game modes with commas.
// Game mode limit: 64
// Character limit for each game mode: 32
// (Empty: None)
// (Not empty: Disabled only in these game modes.)
// -
// Default: ""
ass_disabledgamemodes ""

// Distance allowed before speedrunners are dealt with.
// -
// Default: "2000.0"
// Minimum: "0.000000"
// Maximum: "99999.000000"
ass_distancelimit "2000.0"

// Distance allowed before speedrunners are warned to go back.
// -
// Default: "1000.0"
// Minimum: "0.000000"
// Maximum: "99999.000000"
ass_distancewarning "1000.0"

// Enable the Anti-Speedrunner System in these game modes.
// Separate game modes with commas.
// Game mode limit: 64
// Character limit for each game mode: 32
// (Empty: All)
// (Not empty: Enabled only in these game modes.)
// -
// Default: ""
ass_enabledgamemodes ""

// Enable the Anti-Speedrunner System?
// (0: OFF)
// (1: ON)
// -
// Default: "1"
ass_enablesystem "1"

// Disable/re-enable the Anti-Speedrunner System's functions after X survivors are incapacitated/revived?
// (0: OFF)
// (1: ON)
// -
// Default: "1"
ass_failsafe "1"

// Amount of incapacitated survivors needed to turn the Anti-Speedrunner System off.
// (0: OFF, keep the Anti-Speedrunner System enabled.)
// (X: ON, disable the Anti-Speedrunner System after X survivors are incapacitated.)
// -
// Default: "2"
ass_incapacitatedcount "2"

// Log command usage?
// (0: OFF)
// (1: ON)
// -
// Default: "1"
ass_logcommands "1"

// Automatically disable the Anti-Speedrunner system during finale maps?
// (0: OFF)
// (1: ON)
// -
// Default: "0"
ass_nofinales "0"

// Amount of revived survivors needed to turn the Anti-Speedrunner System back on.
// (0: OFF, keep the Anti-Speedrunner System disabled.)
// (X: ON, re-enable the Anti-Speedrunner System after X survivors are revived.)
// -
// Default: "2"
ass_revivedcount "2"

// Keep the Anti-Speedrunner System enabled when there is a Tank alive?
// (0: OFF)
// (1: ON)
// -
// Default: "1"
ass_tankalive "1"

// Spawn this type of special infected to chase speedrunners.
// Combine numbers in any order for different results.
// Repeat the same number to increase its chance of being chosen.
// Character limit: 16
// (1: Hunter)
// (2: Smoker)
// (3: Jockey, switches to Hunter in L4D1.)
// (4: Charger, switches to Smoker in L4D1.)
// -
// Default: "3333111144442222"
asschase_infectedtype "3333111144442222"

// Which type of custom config should the Anti-Speedrunner System create?
// Combine numbers in any order for different results.
// Character limit: 5
// (1: Difficulties)
// (2: Maps)
// (3: Game modes)
// (4: Days)
// (5: Player count)
// -
// Default: "31425"
assconfig_createtype "31425"

// Enable the Configuration system?
// (0: OFF)
// (1: ON)
// -
// Default: "0"
assconfig_enablesystem "0"

// Which type of custom config should the Anti-Speedrunner System execute?
// Combine numbers in any order for different results.
// Character limit: 5
// (1: Difficulties)
// (2: Maps)
// (3: Game modes)
// (4: Days)
// (5: Player count)
// -
// Default: "1"
assconfig_executetype "1"

// What is the time offset of the server?
// (Used for daily configs.)
// -
// Default: ""
assconfig_timeoffset ""

// Prevent saferoom doors from being spammed for X second(s).
// (0: OFF)
// -
// Default: "3.0"
// Minimum: "0.000000"
// Maximum: "99999.000000"
assdelay_doordelay "3.0"

// Saferoom doors move at this speed.
// (Default speed: 200.0)
// -
// Default: "25.0"
// Minimum: "0.000000"
// Maximum: "99999.000000"
assdelay_doorspeed "25.0"

// Which type of saferoom door should be affected?
// Combine numbers in any order for different results.
// Character limit: 2
// (1: Starting saferoom doors only.)
// (2: Ending saferoom doors only.)
// -
// Default: "21"
assdelay_doortype "21"

// Which weapon slot should be disarmed?
// Combine numbers in any order for different results.
// Character limit: 5
// (1: 1st slot only.)
// (2: 2nd slot only.)
// (3: 3rd slot only.)
// (4: 4th slot only.)
// (5: 5th slot only.)
// -
// Default: "34125"
assdisarm_weaponslot "34125"

// Ban speedrunners for X minute(s).
// (0: Permanent ban.)
// (X: Ban for this many minutes.)
// -
// Default: "60"
assexile_banduration "60"

// Kick or ban speedrunners?
// (0: Kick)
// (1: Ban)
// -
// Default: "0"
assexile_exilemode "0"

// Punish blocked door users?
// (0: OFF)
// (1: ON)
// -
// Default: "1"
assfilter_blockenable "1"

// Combine punishment options or randomly pick one?
// (0: Combine)
// (1: Pick one)
// -
// Default: "1"
assfilter_blockmode "1"

// Which system options do you want to use to deal with blocked door users?
// Combine letters in any order for different results.
// Repeat the same letter to increase its chance of being chosen.
// Character limit: 52
// (A or a: Slow)
// (B or b: Drug)
// (C or c: Blindness)
// (D or d: Shove)
// (E or e: Shake)
// (F or f: Freeze)
// (G or g: Inversion)
// (H or h: Restart)
// (I or i: Warp)
// (J or j: Ammunition)
// (K or k: Disarmament)
// (L or l: Hurt)
// (M or m: Fire)
// (N or n: Health)
// (O or o: Vision)
// (P or p: Incapacitation)
// (Q or q: Rocket)
// (R or r: Shock)
// (S or s: Explosion)
// (T or t: Puke)
// (U or u: Chase)
// (V or v: Acidity, switches to Puke in L4D1.)
// (W or w: Charge, switches to Chase in L4D1.)
// (X or x: Idle)
// (Y or y: Thirdperson, switches to Idle in L4D1.)
// (Z or z: Exile)
// -
// Default: "QqWweErRtTuUIiOopPAasSdDfFgGHhJjkKLlcCvVbBnNMm"
assfilter_blockoptions "QqWweErRtTuUIiOopPAasSdDfFgGHhJjkKLlcCvVbBnNMm"

// Nearby survivors must be this close to ending saferoom doors.
// -
// Default: "500.0"
// Minimum: "0.000000"
// Maximum: "99999.000000"
assgroup_groupdistance "500.0"

// Amount of nearby survivors needed to operate ending saferom doors.
// -
// Default: "3"
assgroup_survivorcount "3"

// Hurt speedrunners by this much every second.
// -
// Default: "1"
asshurt_damageamount "1"

// The Keyman system will automatically pick a new Keyman if the current Keyman does not open the door after X second(s).
// -
// Default: "10"
asskeyman_countdown "10"

// How many Keymen are chosen per map?
// -
// Default: "2"
asskeyman_keymanamount "2"

// The starting door's lockdown will end after X second(s).
// -
// Default: "60"
asslockdown_countdown "60"

// The ending door's lockdown will end after X second(s).
// -
// Default: "60"
asslockdown_countdown2 "60"

// Which type of saferoom door should be affected?
// Combine numbers in any order for different results.
// Character limit: 2
// (1: Starting saferoom doors only.)
// (2: Ending saferoom doors only.)
// -
// Default: "21"
asslockdown_doortype "21"

// Spawn mobs of zombies during the lockdown.
// (0: OFF)
// (1: ON)
// -
// Default: "1"
asslockdown_spawnmobs "1"

// What loadout should speedrunners restart with?
// Separate items with commas.
// Item limit: 5
// Valid formats:
// 1. "rifle,smg,pistol,pain_pills,pipe_bomb"
// 2. "pain_pills,molotov,first_aid_kit,autoshotgun"
// 3. "hunting_rifle,rifle,smg"
// 4. "autoshotgun,pistol"
// 5. "molotov"
// -
// Default: "smg,pistol,pain_pills"
assrestart_loadout "smg,pistol,pain_pills"

// Disable the Boss, Group, Keyman, and Lockdown systems in these game modes.
// Separate game modes with commas.
// Game mode limit: 64
// Character limit for each game mode: 32
// (Empty: None)
// (Not empty: Disabled only in these game modes.)
// -
// Default: "versus,realismversus,scavenge,survival,mutation1"
asssaferoom_disabledgamemodes "versus,realismversus,scavenge,survival,mutation1"

// Enable the Boss, Group, Keyman, and Lockdown systems in these game modes.
// Separate game modes with commas.
// Game mode limit: 64
// Character limit for each game mode: 32
// (Empty: All)
// (Not empty: Enabled only in these game modes.)
// -
// Default: "coop,realism,mutation12"
asssaferoom_enabledgamemodes "coop,realism,mutation12"

// Enable the Saferoom system?
// (0: OFF)
// (1: ON)
// -
// Default: "1"
asssaferoom_enablesystem "1"

// Warp survivors inside or unlock the saferoom door?
// (0: Warp)
// (1: Unlock)
// -
// Default: "1"
asssaferoom_entrymode "1"

// Which system options do you want to use to deal with speedrunners?
// Combine letters in any order for different results.
// Repeat the same letter to increase its chance of being chosen.
// Character limit: 20
// (B or b: Boss)
// (F or f: Filter)
// (G or g: Group)
// (K or k: Keyman)
// (L or l: Lockdown)
// -
// Default: "KkKkLLllfFfFbbBBgGGg"
asssaferoom_systemoptions "KkKkLLllfFfFbbBBgGGg"

// Survivors will be warped inside the saferoom after X second(s).
// -
// Default: "5"
asssaferoom_warpcountdown "5"

// Set speedrunners' run speed to X value.
// -
// Default: "0.25"
// Minimum: "0.000000"
// Maximum: "1.000000"
assslow_runspeed "0.25"

// How often does the Strike system check for speedrunners?
// -
// Default: "5.0"
// Minimum: "1.000000"
// Maximum: "99999.000000"
assstrike_detectiondelay "5.0"

// Enable the Strike system?
// (0: OFF)
// (1: ON)
// -
// Default: "1"
assstrike_enablesystem "1"

// Number of strikes needed to be punished for speedrunning.
// -
// Default: "5"
// Minimum: "0.000000"
// Maximum: "99999.000000"
assstrike_limit "5"

// Combine punishment options or randomly pick one?
// (0: Combine)
// (1: Pick one)
// -
// Default: "1"
assstrike_punishmode "1"

// Give strikes first before punishing speedrunners?
// (0: OFF)
// (1: ON)
// -
// Default: "1"
assstrike_strikemode "1"

// Which system options do you want to use to deal with speedrunners?
// Combine letters in any order for different results.
// Repeat the same letter to increase its chance of being chosen.
// Character limit: 52
// (A or a: Slow)
// (B or b: Drug)
// (C or c: Blindness)
// (D or d: Shove)
// (E or e: Shake)
// (F or f: Freeze)
// (G or g: Inversion)
// (H or h: Restart)
// (I or i: Warp)
// (J or j: Ammunition)
// (K or k: Disarmament)
// (L or l: Hurt)
// (M or m: Fire)
// (N or n: Health)
// (O or o: Vision)
// (P or p: Incapacitation)
// (Q or q: Rocket)
// (R or r: Shock)
// (S or s: Explosion)
// (T or t: Puke)
// (U or u: Chase)
// (V or v: Acidity, switches to Puke in L4D1.)
// (W or w: Charge, switches to Chase in L4D1.)
// (X or x: Idle)
// (Y or y: Thirdperson, switches to Idle in L4D1.)
// (Z or z: Exile)
// -
// Default: "QqWweErRtTuUIiOopPAasSdDfFgGHhJjkKLlcCvVbBnNMm"
assstrike_systemoptions "QqWweErRtTuUIiOopPAasSdDfFgGHhJjkKLlcCvVbBnNMm"
```

### Custom Configuration Files
The Anti-Speedrunner System has features that allow for creating and executing custom configuration files.

> Any convars written inside these custom config files will be executed. These files are only created/executed by the A.S.S.

By default, the A.S.S can create and execute the following types of configurations:

1. Difficulty - Files are created/executed based on the current game difficulty. (Example: If the current z_difficulty is set to Impossible (Expert mode), then "impossible.cfg" is executed (or created if it doesn't exist already).
2. Map - Files are created/executed based on the current map. (Example: If the current map is c1m1_hotel, then "c1m1_hotel.cfg" is executed (or created if it doesn't exist already).
3. Game mode - Files are created/executed based on the current game mode. (Example: If the current game mode is Versus, then "versus.cfg" is executed (or created if it doesn't exist already).
4. Daily - Files are created/executed based on the current day. (Example: If the current day is Friday, then "friday.cfg" is executed (or created if it doesn't exist already).
5. Player count - Files are created/executed based on the current number of human players. (Example: If the current number is 8, then "8.cfg" is executed (or created if it doesn't exist already).

#### Features
1. Create custom config files (can be based on difficulty, map, game mode, day, player count, or custom name).
2. Execute custom config files (can be based on difficulty, map, game mode, day, player count, or custom name).
3. Automatically generate config files for all difficulties specified by z_difficulty.
4. Automatically generate config files for all maps installed on the server.
5. Automatically generate config files for all game modes specified by sv_gametypes and mp_gamemode.
6. Automatically generate config files for all days.
7. Automatically generate config files for up to 66 players.

## Credits
**ztar, Pescoxa, raziEil (disawar)** - For the [Anti-Runner System - REMAKE (Keyman system)](https://forums.alliedmods.net/showthread.php?p=2552450#post2552450).

**panxiaohai** - For the [We Can Not Survive Alone (Group and Chase systems)](https://forums.alliedmods.net/showthread.php?t=167389).

**Krufftys Killers** - For sharing the code to his Anti-Solo plugin (Warp system), reporting errors, setting up a server specifically for testing the plugin, and for overall continuous support.

**cravenge** - For the [Lockdown System (Delay and Lockdown systems)](https://forums.alliedmods.net/showthread.php?p=2409095) and for helping me with various parts of the code.

**phoenix0001** - For [suggesting](https://forums.alliedmods.net/showthread.php?t=297009) a plugin ([twice](https://forums.alliedmods.net/showthread.php?t=297009)) that requires changing a cvar based on client count.

**Tak (Chaosxk)** - For providing a [rough sample](https://forums.alliedmods.net/showpost.php?p=2518197&postcount=4) of how to change a cvar based on client count.

**Lux** - For fixing up Tak (Chaosxk)'s [code](https://forums.alliedmods.net/showpost.php?p=2561468&postcount=9) and helping me with some parts of the code.

**NgBUCKWANGS** - For helping to fix the errors reported by Krufftys Killers [here](https://forums.alliedmods.net/showpost.php?p=2561615&postcount=23), and for the mapname.cfg code in his [ABM](https://forums.alliedmods.net/showthread.php?t=291562) plugin.

**KasperH** - For the Hungarian phrase translations and reporting errors.

**Mi.Cura** - For the Portuguese phrase translations and reporting errors.

**joyist** - For the Chinese phrase translations.

**8guawong** - For helping me with some parts of the code.

**Powerlord** - For showing me a better and more efficient way in creating and handling vote menus.

**Spirit_12** - For the L4D signatures for the gamedata file.

**honorcode** - For the L4D2 signatures for the gamedata file found in the L4D2 New Custom Commands' gamedata file and the codes to spawn spitter acid puddles, to charge at players, to cause explosions, to ignite players, to set players to black and white, to incapacitate players, to puke on players, to shake players' screens, and to shove players.

**strontiumdog** - For the [Evil Admin: Rocket](https://forums.alliedmods.net/showthread.php?t=79617) and [Evil Admin: Vision](https://forums.alliedmods.net/showthread.php?p=702918).

**Marcus101RR** - For the code to set a player's weapon's ammo.

**AtomicStryker** - For the code and gamedata signatures to respawn survivors.

**Farbror Godis** - For the [Curse](https://forums.alliedmods.net/showthread.php?p=2402076) plugin.

**Silvers (Silvershot)** - For the code that allows users to enable/disable the plugin in certain game modes and help with gamedata signatures.

**Milo|** - For the code that automatically generates config files for each day and each map installed on a server.

**Impact** - For the [AutoExecConfig](https://forums.alliedmods.net/showthread.php?t=204254) include.

**hmmmmm** - For showing me how to pick a random character out of a dynamic string and for his [Menu Targeting](https://forums.alliedmods.net/showthread.php?t=306954).

**SourceMod Team** - For the beacon, blind, drug, and ice source codes.

# Contact Me
If you wish to contact me for any questions, concerns, suggestions, or criticism, I can be found here:
- [AlliedModders Forum](https://forums.alliedmods.net/member.php?u=181166)
- [Steam](https://steamcommunity.com/profiles/76561198056665335)

# 3rd-Party Revisions Notice
If you would like to share your own revisions of this plugin, please rename the files! I do not want to create confusion for end-users and it will avoid conflict and negative feedback on the official versions of my work. If you choose to keep the same file names for your revisions, it will cause users to assume that the official versions are the source of any problems your revisions may have. This is to protect you (the reviser) and me (the developer)! Thank you!
