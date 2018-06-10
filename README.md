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
12. Lock/unlock convar values - Provides the option to temporarily lock/unlock convar values across map changes.
13. Automatic config updater - Provides the ability to update the main config file when new convars are added.
14. Menus - Provides menus for admin commands.
15. Custom target list - Provides a menu list of players with similar names when one of them is targeted.
16. Lock saferoom doors - Provides options for unlocking ending saferoom doors. If an invalid option or no option is chosen, the door immediately opens.
17. Track speedrunners - Provides options for dealing with speedrunners. If an invalid option or no option is chosen, speedrunners will be warped back to the nearest teammate.
18. Survivor and Infected target filters - Provides custom target filters. (Use @survivors for survivors and @infected for infected.)
19. Log command usage - Provides the option to log command usage.
20. Supports multiple languages - Provides support for translations. [Click here to add support for your language!](http://translator.mitchdempsey.com/sourcemod_plugins/310) (I check everyday so I can update the translation file attached to this post, but you can private message me as well to make sure.)

## System Options
The Anti-Speedrunner System mainly consists of 2 systems.

### Saferoom
- Boss
```
Spawns a Tank behind the player who initially touched the ending saferoom door and it must be defeated first before the door can be unlocked.
```

- Delay
```
Adds a delay to saferoom doors to prevent spam.
```

- Filter
```
Only players that haven't met the strike limit are allowed to open the ending saferoom door.
```

- Group
```
Keeps the ending saferoom door locked until enough survivors are near it.
```

- Keyman
```
Assigns a random player to be the Keyman that will unlock the ending saferoom door.
```

- Lockdown
```
Keeps the saferoom doors locked until the lockdown ends.
```

### Strike
- Acidity
```
Spawns a puddle of acid under a player.
```

- Ammunition
```
Sets a player's ammunition count.
```

- Blindness
```
Blinds a player.
```

- Charge
```
Launches a player in the air as if the player were attacked by a Charger.
```

- Chase
```
Spawns a special infected behind a player.
```

- Disarmament
```
Causes a player to drop all their items.
```

- Drug
```
Drugs a player.
```

- Exile
```
Mode 0: Kicks a player:

Message to player:

"You have been kicked for passing the distance limit many times"

Mode 1: Bans a player with the following reason:

"Banned for passing the distance limit many times."

Message to player:

"You have been banned for passing the distance limit many times"
```

- Explosion
```
Causes an explosion within a small radius around where a player is standing.
```

- Fire
```
Sets a player on fire.
```

- Freeze
```
Stops a player on the spot from moving.
```

- Health
```
Sets a player to black and white with temporary health.
```

- Hurt
```
Damages a player every second.
```

- Idle
```
Forces a player into idle mode.
```

- Incapacitation
```
Incapacitates a player and sends a white beacon from their position.
```

- Inversion
```
Inverts a player's movement keys.
```

- Mirror
```
Mirrors a player's damage.
```

- Puke
```
Covers a player in vomit.
```

- Restart
```
Causes a player to restart at the spawn area with a set of items/weapons.
```

- Rocket
```
Forces a player to lift off into space and explode.
```

- Shake
```
Shakes a player's screen continuously.
```

- Shock
```
Shocks and kills a player.
```

- Shove
```
Shoves a player continuously.
```

- Slow
```
Slows a player's run speed down.
```

- Vision
```
Changes a player's field of view to 160 while forced to scope in.
```

- Warp
```
Warps a player back to the nearest teammate.
```

## Commands
```
[Commands]		[Flags]		[Description]
ass_acid		Kick (c)	Spawn an acid puddle under a player for speedrunning.
Usage: ass_acid <#userid|name> <0: off|1: on> <0: once|1: repeat>
ass_ammo		Kick (c)	Set a player's ammunition count for speedrunning.
Usage: ass_ammo <#userid|name> <0: off|1: on> <count >= 0> <0: once|1: repeat>
ass_blind		Kick (c)	Blind a player for speedrunning.
Usage: ass_blind <#userid|name> <0: off|1: on>
ass_charge		Kick (c)	Charge at a player for speedrunning.
Usage: ass_charge <#userid|name> <0: off|1: on> <0: once|1: repeat>
ass_chase		Kick (c)	Spawn a special infected to chase a player for speedrunning.
Usage: ass_chase <#userid|name> <1: hunter|2: smoker|3: jockey|4: charger>
ass_check		Kick (c)	Run a timer on a player to check for speedrunning.
Usage: ass_check <#userid|name> <0: off|1: on> <0: once|1: repeat>
ass_config		Root (z)	Create a custom config in-game.
Usage: ass_config <0: create|1: execute> <0: difficulty|1: map|2: game mode|3: day|4: player count> "filename"
ass_disarm		Kick (c)	Disarm a player for speedrunning.
Usage: ass_disarm <#userid|name> <0: off|1: on> <1: 1st slot|2: 2nd slot|3: 3rd slot|4: 4th slot|5: 5th slot> <0: once|1: repeat>
ass_door		Kick (c)	Manually lock/unlock saferoom doors.
Usage: ass_door <#userid|name> <0: starting door|1: ending door> <0: unlock|1: lock>
ass_drug		Kick (c)	Drug a player for speedrunning.
Usage: ass_drug <#userid|name> <0: off|1: on>
ass_entry		Root (z)	Warp all survivors inside the saferoom.
Usage: ass_entry
ass_exile		Ban (d)		Exile a player for speedrunning.
Usage: ass_exile <#userid|name> <0: kick|1: ban> <duration >= 1>
ass_explode		Slay (f)	Cause an explosion on a player for speedrunning.
Usage: ass_explode <#userid|name>
ass_fire		Kick (c)	Set a player on fire for speedrunning.
Usage: ass_fire <#userid|name> <0: off|1: on> <0: once|1: repeat>
ass_freeze		Kick (c)	Freeze a player for speedrunning.
Usage: ass_freeze <#userid|name> <0: off|1: on>
ass_heal		Kick (c)	Set a player to black and white with temporary health for speedrunning.
Usage: ass_heal <#userid|name>
ass_hurt		Kick (c)	Hurt a player for speedrunning.
Usage: ass_hurt <#userid|name> <0: off|1: on> <damage >= 0> <0: once|1: repeat>
ass_idle		Slay (f)	Force a player to go idle for speedrunning.
Usage: ass_idle <#userid|name>
ass_incap		Kick (c)	Incapacitate a player for speedrunning.
Usage: ass_incap <#userid|name> <0: off|1: on> <0: once|1: repeat>
ass_invert		Kick (c)	Invert a player's movement keys for speedrunning.
Usage: ass_invert <#userid|name> <0: off|1: on>
ass_key			Kick (c)	Choose a new Keyman.
Usage: ass_key <#userid|name> <0: off|1: on>
ass_mirror		Kick (c)	Mirror a player's damage for speedrunning.
Usage: ass_mirror <#userid|name> <0: off|1: on>
ass_null		Root (z)	Give a player immunity.
Usage: ass_null <#userid|name> <0: off|1: on>
ass_puke		Kick (c)	Puke on a player for speedrunning.
Usage: ass_puke <#userid|name> <0: off|1: on> <0: once|1: repeat>
ass_restart		Kick (c)	Cause a player to restart at the spawn area for speedrunning.
Usage: ass_restart <#userid|name> <0: off|1: on> "item1,item2,item3,item4,item5"
ass_rocket		Slay (f)	Send a player into space for speedrunning.
Usage: ass_rocket <#userid|name> <launch delay> <detonation delay>
ass_room		Root (z)	Manually set the entry method for ending saferoom doors.
Usage: ass_room <0: none|1: boss|2: filter|3: group|4: keyman|5: lockdown>
ass_shake		Kick (c)	Shake a player's screen for speedrunning.
Usage: ass_shake <#userid|name> <0: off|1: on> <0: once|1: repeat>
ass_shock		Slay (f)	Shock a player for speedrunning.
Usage: ass_shock <#userid|name>
ass_shove		Kick (c)	Shove a player for speedrunning.
Usage: ass_shove <#userid|name> <0: off|1: on> <0: once|1: repeat>
ass_slow		Kick (c)	Slow a player down for speedrunning.
Usage: ass_slow <#userid|name> <0: off|1: on> <speed <= 0.99>
ass_strike		Root (z)	Give a player a strike for speedrunning.
Usage: ass_strike <#userid|name> <amount >= 1>
ass_vision		Kick (c)	Change a player's vision for speedrunning.
Usage: ass_vision <#userid|name> <0: off|1: on> <fov <= 160> <0: once|1: repeat>
ass_warp		Kick (c)	Warp a player to your position for speedrunning.
Usage: ass_warp <#userid|name>
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
// Minimum: "0.000000"
// Maximum: "1.000000"
ass_adminimmunity "0"

// Enable the Anti-Speedrunner System's automatic mode?
// (0: OFF)
// (1: ON)
// -
// Default: "1"
// Minimum: "0.000000"
// Maximum: "1.000000"
ass_automode "1"

// Allow the use of admin commands during automatic mode?
// (0: OFF)
// (1: ON)
// -
// Default: "1"
// Minimum: "0.000000"
// Maximum: "1.000000"
ass_commandoverride "1"

// Should the Anti-Speedrunner System count bots as players?
// (0: OFF)
// (1: ON)
// -
// Default: "1"
// Minimum: "0.000000"
// Maximum: "1.000000"
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
// Minimum: "0.000000"
// Maximum: "1.000000"
ass_enablesystem "1"

// Disable/re-enable the Anti-Speedrunner System's functions after X survivors are incapacitated/revived?
// (0: OFF)
// (1: ON)
// -
// Default: "1"
// Minimum: "0.000000"
// Maximum: "1.000000"
ass_failsafe "1"

// Amount of incapacitated survivors needed to turn the Anti-Speedrunner System off.
// (0: OFF, keep the Anti-Speedrunner System enabled.)
// (X: ON, disable the Anti-Speedrunner System after X survivors are incapacitated.)
// -
// Default: "2"
// Minimum: "1.000000"
// Maximum: "66.000000"
ass_incapacitatedcount "2"

// Log command usage?
// (0: OFF)
// (1: ON)
// -
// Default: "1"
// Minimum: "0.000000"
// Maximum: "1.000000"
ass_logcommands "1"

// Automatically disable the Anti-Speedrunner system during finale maps?
// (0: OFF)
// (1: ON)
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "1.000000"
ass_nofinales "0"

// Amount of revived survivors needed to turn the Anti-Speedrunner System back on.
// (0: OFF, keep the Anti-Speedrunner System disabled.)
// (X: ON, re-enable the Anti-Speedrunner System after X survivors are revived.)
// -
// Default: "2"
// Minimum: "1.000000"
// Maximum: "66.000000"
ass_revivedcount "2"

// Enable the Saferoom system?
// (0: OFF)
// (1: ON)
// -
// Default: "1"
// Minimum: "0.000000"
// Maximum: "1.000000"
asssaferoom_enablesystem "1"

// Warp survivors inside or unlock the saferoom door?
// (0: Warp)
// (1: Unlock)
// -
// Default: "1"
// Minimum: "0.000000"
// Maximum: "1.000000"
asssaferoom_entrymode "1"

// Survivors will be warped inside the saferoom after X second(s).
// -
// Default: "5"
// Minimum: "1.000000"
// Maximum: "99999.000000"
asssaferoom_warpcountdown "5"

// Enable the Strike system?
// (0: OFF)
// (1: ON)
// -
// Default: "1"
// Minimum: "0.000000"
// Maximum: "1.000000"
assstrike_enablesystem "1"

// Keep the Anti-Speedrunner System enabled when there is a Tank alive?
// (0: OFF)
// (1: ON)
// -
// Default: "1"
// Minimum: "0.000000"
// Maximum: "1.000000"
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
// Minimum: "0.000000"
// Maximum: "1.000000"
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
// How it works:
// Server time + assconfig_timeoffset
// Example:
// assconfig_timeoffset "+10"
// 12:00 PM + 10 = 10:00 PM
// assconfig_timeoffset "-10"
// 12:00 PM - 10 = 2:00 AM
// -
// Default: ""
assconfig_timeoffset ""

// Prevent saferoom doors from being spammed for X second(s).
// (0: OFF)
// -
// Default: "3.0"
// Minimum: "1.000000"
// Maximum: "99999.000000"
assdelay_doordelay "3.0"

// Saferoom doors move at this speed.
// (Default speed: 200.0)
// -
// Default: "25.0"
// Minimum: "1.000000"
// Maximum: "200.000000"
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

// Kick or ban speedrunners?
// (0: Kick)
// (1: Ban)
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "1.000000"
assexile_exilemode "0"

// Ban speedrunners for X minute(s).
// (0: Permanent ban.)
// (X: Ban for this many minutes.)
// -
// Default: "60"
// Minimum: "0.000000"
// Maximum: "99999.000000"
assexile_banduration "60"

// Punish blocked door users?
// (0: OFF)
// (1: ON)
// -
// Default: "1"
// Minimum: "0.000000"
// Maximum: "1.000000"
assfilter_blockenable "1"

// Combine punishment options or randomly pick one?
// (0: Combine)
// (1: Pick one)
// -
// Default: "1"
// Minimum: "0.000000"
// Maximum: "1.000000"
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
// (M or m: Mirror)
// (N or n: Fire)
// (O or o: Health)
// (P or p: Vision)
// (Q or q: Incapacitation)
// (R or r: Rocket)
// (S or s: Shock)
// (T or t: Explosion)
// (U or u: Puke)
// (V or v: Chase)
// (W or w: Acidity, switches to Puke in L4D1.)
// (X or x: Charge, switches to Chase in L4D1.)
// (Y or y: Idle)
// (Z or z: Exile)
// -
// Default: "QqWweErRtTyYuUIiOopPAasSdDfFgGHhJjkKLlXxcCvVbBnNMm"
assfilter_blockoptions "QqWweErRtTyYuUIiOopPAasSdDfFgGHhJjkKLlXxcCvVbBnNMm"

// Nearby survivors must be this close to ending saferoom doors.
// -
// Default: "500.0"
// Minimum: "1.000000"
// Maximum: "99999.000000"
assgroup_groupdistance "500.0"

// Amount of nearby survivors needed to operate ending saferom doors.
// -
// Default: "3"
// Minimum: "1.000000"
// Maximum: "66.000000"
assgroup_survivorcount "3"

// Hurt speedrunners by this much every second.
// -
// Default: "1"
// Minimum: "1.000000"
// Maximum: "99999.000000"
asshurt_damageamount "1"

// The Keyman system will automatically pick a new Keyman if the current Keyman does not open the door after X second(s).
// -
// Default: "10"
// Minimum: "1.000000"
// Maximum: "99999.000000"
asskeyman_countdown "10"

// How many Keymen are chosen per map?
// -
// Default: "2"
// Minimum: "1.000000"
// Maximum: "66.000000"
asskeyman_keymanamount "2"

// The starting door's lockdown will end after X second(s).
// -
// Default: "60"
// Minimum: "1.000000"
// Maximum: "99999.000000"
asslockdown_countdown "60"

// The ending door's lockdown will end after X second(s).
// -
// Default: "60"
// Minimum: "1.000000"
// Maximum: "99999.000000"
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
// Minimum: "0.000000"
// Maximum: "1.000000"
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

// Set speedrunners' run speed to X value.
// -
// Default: "0.25"
// Minimum: "0.100000"
// Maximum: "1.000000"
assslow_runspeed "0.25"

// How many seconds between each check for speedrunners?
// -
// Default: "5.0"
// Minimum: "0.000000"
// Maximum: "99999.000000"
assstrike_detectiondelay "5.0"

// Distance allowed before speedrunners are dealt with.
// -
// Default: "2000"
// Minimum: "1.000000"
// Maximum: "99999.000000"
assstrike_distancelimit "2000"

// Distance allowed before speedrunners are warned to go back.
// -
// Default: "1000"
// Minimum: "1.000000"
// Maximum: "99999.000000"
assstrike_distancewarning "1000"

// Combine punishment options or randomly pick one?
// (0: Combine)
// (1: Pick one)
// -
// Default: "1"
// Minimum: "0.000000"
// Maximum: "1.000000"
assstrike_punishmode "1"

// Number of strikes needed to be punished for speedrunning.
// -
// Default: "5"
// Minimum: "1.000000"
// Maximum: "99999.000000"
assstrike_strikelimit "5"

// Give strikes first before punishing speedrunners?
// (0: OFF)
// (1: ON)
// -
// Default: "1"
// Minimum: "0.000000"
// Maximum: "1.000000"
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
// (M or m: Mirror)
// (N or n: Fire)
// (O or o: Health)
// (P or p: Vision)
// (Q or q: Incapacitation)
// (R or r: Rocket)
// (S or s: Shock)
// (T or t: Explosion)
// (U or u: Puke)
// (V or v: Chase)
// (W or w: Acidity, switches to Puke in L4D1.)
// (X or x: Charge, switches to Chase in L4D1.)
// (Y or y: Idle)
// (Z or z: Exile)
// -
// Default: "QqWweErRtTyYuUIiOopPAasSdDfFgGHhJjkKLlXxcCvVbBnNMm"
assstrike_systemoptions "QqWweErRtTyYuUIiOopPAasSdDfFgGHhJjkKLlXxcCvVbBnNMm"
```

### Locking/Unlocking ConVar values

The Anti-Speedrunner System provides the option to lock/unlock convar values. By locking a convar's value, the Anti-Speedrunner System will prevent convars from reverting to their default values across map changes until the server ends or restarts.

> The default lock and unlock switch symbols are "==" and "!=" respectively. You can change these on lines 17 and 18 in the anti-speedrunner_system.inc file. The character limit for both is 2.

#### Usage:
Normal
```
assstrike_systemoptions "abc" // Value set in anti-speedrunner_system.cfg.
assstrike_systemoptions "def" // Value set during a map.
Map changes...
assstrike_systemoptions "abc" // Value after map changes.
```

Lock
```
assstrike_systemoptions "abc" // Value set in anti-speedrunner_system.cfg.
assstrike_systemoptions "==def" // Value set during a map.
Map changes...
assstrike_systemoptions "def" // Value after map changes.
```

Unlock
```
assstrike_systemoptions "abc" // Value set in anti-speedrunner_system.cfg.
assstrike_systemoptions "!=def" // Value set during a map.
Map changes...
assstrike_systemoptions "abc" // Value after map changes.
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

## Questions You May Have
> If you have any questions that aren't addressed below, feel free to message me or post on this [thread](https://forums.alliedmods.net/showthread.php?t=302868).

### Main Features
1. How do I enable admin immunity for certain flags?

By default, anyone with the generic admin flag (b) can be given immunity with the ass_adminimmunity convar. Alternatively, you can give an admin flag access to the ass_override command so that only anyone with that flag can get immunity. Either way, ass_adminimmunity must be enabled for the immunity to work.

2. What is automatic mode?

Automatic mode is basically a feature that allows the plugin to work on its own without having to use commands or menus to control it. The system will have a mind of its own in a way.

3. Why can't I use the admin commands in chat during automatic mode?

This is a default feature so that any commands that admins use on players will not affect the system when it's doing its job. Even if you use the commands through the admin menu, automatic mode will disable the the effects if it detects that the player affected hasn't passed the distance limit.

4. What is the ass_countbots convar for?

The convar tells the plugin whether or not to punish bots as if they were real players. If it's turned off, then the system completely ignores them. If it's turned on, then the system will treat them like actual players and will punish them if they do anything that the system disapproves of.

5. How do I enable/disable the plugin in certain game modes?

There are 2 sets of convars that need to be addressed.

The asssaferoom_enabledgamemodes and asssaferoom_disabledgamemodes only apply to the Saferoom system since they act differently from the rest of the plugin's features.

The ass_enabledgamemodes and ass_disabledgamemodes apply to the whole plugin.

Here are some scenarios and their outcomes:
- Scenario 1
```
ass_enabledgamemodes "" // The plugin itself is enabled in all game modes.
asssaferoom_enabledgamemodes "coop" // The Saferoom system is only enabled in Campaign mode.

Outcome: The plugin works in every game mode but the Saferoom system will automatically shut off if the game mode isn't Campaign mode.
```
- Scenario 2
```
ass_enabledgamemodes "versus" // The plugin itself is enabled in only Versus mode.
asssaferoom_enabledgamemodes "coop" // The Saferoom system is only enabled in Campaign mode.

Outcome: The plugin works only in Versus mode so the game mode specified for the Saferoom system wouldn't matter.
```
- Scenario 3
```
ass_enabledgamemodes "coop,versus" // The plugin itself is enabled in only Versus mode.
asssaferoom_enabledgamemodes "coop" // The Saferoom system is only enabled in Campaign mode.

Outcome: The plugin works only in Campaign and Versus modes but the Saferoom system will automatically shut off if the game mode isn't Campaign mode.
```

6. What is the assstrike_distancelimit convar for?

The convar determines how far a survivor can be from his/her teammates before he/she is punished. It should be higher than the value of assstrike_distancewarning.

7. What is the assstrike_distancewarning convar for?

The convar determines how far a survivor can be from his/her teammates before he/she is warned to go back. It should be lower than the value of assstrike_distancelimit.

8. How does the failsafe function work?

The failsafe function basically detects when the system is needed.

If the amount of incapacitated survivors detected matches or exceeds the value defined by the ass_incapacitatedcount convar, then the plugin disables itself.

If the amount of able/revived survivors detected matches or exceeds the value defined by the ass_revivedcount convar, then the plugin re-enables itself.

9. How do I stop the plugin from enabling/disabling itself?

Set ass_failsafe to 0.

10. What is the ass_logcommands convar for?

It basically decides if the plugin should log every command usage.

11. How do I automatically disable everything on finale maps?

Set ass_nofinales to 1.

12. How does the plugin work during Tank fights?

If you don't want the plugin to interfere with the gameplay during Tank fights, then set ass_tankalive to 0. Otherwise, set it to 1.

### Commands

1. Can you go into more detail how each command can be used?
I'll just show examples for how to use each command.

```
// ass_acid
ass_acid @me 1 1 // Spawn acid puddles under yourself every 7 seconds.
ass_acid @me 1 // Spawn an acid puddle under yourself once.
ass_acid @me or ass_acid // Open a menu with a list of players to select from.

// ass_ammo
ass_ammo @me 1 0 1 // Set your ammo count to 0 continuously.
ass_ammo @me 1 7 // Set your ammo count to 7 once.
ass_ammo @me 1 // Set your ammo count to 0 once.
ass_ammo @me or ass_ammo // Open a menu with a list of players to select from.

// ass_blind
ass_blind @me 1 // Blind yourself.
ass_blind @me or ass_blind // Open a menu with a list of players to select from.

// ass_charge
ass_charge @me 1 1 // Charge at yourself every 5 seconds.
ass_charge @me 1 // Charge at yourself once.
ass_charge @me or ass_charge // Open a menu with a list of players to select from.

// ass_chase
ass_chase @me 3 // Spawn a Jockey behind yourself to chase you.
ass_chase @me // Pick a random special infected defined in asschase_infectedtype to spawn behind yourself to chase you.
ass_chase // Open a menu with a list of players to select from.

// ass_check
ass_check @me 1 1 // Run a continuous timer to check if you're speedrunning.
ass_check @me 1 // Check if you're speedrunning once.
ass_check @me or ass_check // Open a menu with a list of players to select from.

// ass_config
ass_config 0 1 // Create a map config.
ass_config 1 or ass_config // Open a menu with a list of options to select from.

// ass_disarm
ass_disarm @me 1 3 1 // Disarm your 3rd weapon slot continuously.
ass_disarm @me 1 2 // Disarm your 2nd weapon slot once.
ass_disarm @me 1 // Disarm all your weapon slots once.
ass_disarm @me or ass_disarm // Open a menu with a list of players to select from.

// ass_door
ass_door 0 1 // Lock the starting saferoom door.
ass_door 1 or ass_door // Open a menu with a list of options to select from.

// ass_drug
ass_drug @me 1 // Drug yourself.
ass_drug @me or ass_drug // Open a menu with a list of players to select from.

// ass_entry
ass_entry // Warp all survivors to the saferoom.

// ass_exile
ass_exile @me 1 60 // Ban yourself for 60 minutes or 1 hour for speedrunning.
ass_exile @me 0 // Kick yourself for speedrunning.
ass_exile @me or ass_exile // Open a menu with a list of options to select from.

// ass_explode
ass_explode @me // Cause an explosion on yourself.
ass_explode // Open a menu with a list of players to select from.

// ass_fire
ass_fire @me 1 1 // Set yourself on fire continuously.
ass_fire @me 1 // Burn yourself once.
ass_fire @me or ass_fire // Open a menu with a list of players to select from.

// ass_freeze
ass_freeze @me 1 // Freeze yourself.
ass_freeze @me or ass_freeze // Open a menu with a list of players to select from.

// ass_heal
ass_heal @me // Set yourself to black and white and give yourself temporary health.
ass_heal // Open a menu with a list of players to select from.

// ass_hurt
ass_hurt @me 1 1 1 // Hurt yourself with 1 damage continuously.
ass_hurt @me 1 1 // Hurt yourself with 1 damage once.
ass_hurt @me 1 // Hurt yourself with whatever damage is defined in asshurt_damageamount.
ass_hurt @me // Open a menu with a list of players to select from.

// ass_idle
ass_idle @me // Set yourself to idle.
ass_idle // Open a menu with a list of players to select from.

// ass_incap
ass_incap @me 1 1 // Incapacitate yourself continuously.
ass_incap @me 1 // Incpacitate yourself once.
ass_incap @me or ass_incap // Open a menu with a list of players to select from.

// ass_invert
ass_invert @me 1 //Invert your movement keys.
ass_invert @me or ass_invert // Open a menu with a list of players to select from.

// ass_key
ass_key @me 1 // Mark yourself as a Keyman.
ass_key @me or ass_key // Open a menu with a list of players to select from.

// ass_mirror
ass_mirror @me 1 // Mirror your own damage.
ass_mirror @me or ass_mirror // Open a menu with a list of players to select from.

// ass_null
ass_null @me 1 // Give yourself player immunity.
ass_null @me or ass_null // Open a menu with a list of players to select from.

// ass_puke
ass_puke @me 1 1 // Puke on yourself every 5 seconds.
ass_puke @me 1 // Puke on yourself once.
ass_puke @me or ass_puke // Open a menu with a list of players to select from.

// ass_restart
ass_restart @me "smg" // Restart yourself at the spawn area with an SMG.
ass_restart @me // Restart yourself at the spawn area with the loadout defined in assrestart_loadout.
ass_restart // Open a menu with a list of players to select from.

// ass_rocket
ass_rocket @me 3.0 4.5 // Launch yourself into space after 3.0 seconds and detonate yourself 1.5 seconds later.
ass_rocket @me 3.0 // Launch yourself into space after 3.0 seconds and detonate yourself 0.5 seconds later.
ass_rocket @me // Launch yourself into space after 2.0 seconds and detonate yourself 1.5 seconds later.
ass_rocket // Open a menu with a list of players to select from.

// ass_room
ass_room 4 // Set the ending saferoom door's method to the Keyman option.
ass_room // Open a menu with a list of Saferoom system options to select from.

// ass_shake
ass_shake @me 1 1 // Shake your screen every 5 seconds.
ass_shake @me 1 // Shake your screen once for 5 seconds.
ass_shake @me or ass_shake // Open a menu with a list of players to select from.

// ass_shock
ass_shock @me // Shock yourself to death.
ass_shock // Open a menu with a list of players to select from.

// ass_shove
ass_shove @me 1 1 // Shove yourself continuously.
ass_shove @me 1 // Shove yourself once.
ass_shove @me or ass_shove // Open a menu with a list of players to select from.

// ass_slow
ass_slow @me 1 0.15 // Set your run speed to 0.15.
ass_slow @me 1 // Set your run speed to whatever value is defined in assslow_runspeed.
ass_slow @me or ass_slow // Open a menu with a list of players to select from.

// ass_strike
ass_strike @me 4 // Give yourself 4 strikes.
ass_strike @me // Give yourself a strike as long as you don't exceed the limit. Otherwise you get punished.
ass_strike // Open a menu with a list of players to select from.

// ass_vision
ass_vision @me 1 100 1 // Set your field of view to 100 continuously.
ass_vision @me 1 100 // Set your field of view to 100 once.
ass_vision @me 1 // Set your field of view to 160 once.
ass_vision @me or ass_vision // Open a menu with a list of players to select from.

// ass_warp
ass_warp @me // Warp yourself to the nearest teammate.
ass_warp // Open a menu with a list of players to select from.
```

### Configuration
1. How do I enable the custom configurations features?

Set assconfig_enablesystem to 1.

2. How do I tell the plugin to only create certain custom config files?

Set the values in assconfig_createtype.

Examples:
```
assconfig_createtype "123" // Creates the folders and config files for each difficulty, map, and game mode.
assconfig_createtype "4" // Creates the folder and config files for each day.
assconfig_createtype "12345" // Creates the folders and config files for each difficulty, map, game mode, day, and player count.
```

3. How do I tell the plugin to only execute certain custom config files?

Set the values in assconfig_executetype.

Examples:
```
assconfig_executetype "123" // Executes the config file for the current difficulty, map, and game mode.
assconfig_executetype "4" // Executes the config file for the current day.
assconfig_executetype "12345" // Executes the config file for the current difficulty, map, game mode, day, and player count.
```

4. How can I make the Daily configs execute during a certain time of the day?

Set the time offset value in assconfig_timeoffset.

Examples:
```
assconfig_timeoffset "+10" // Adds 10 hours to the server time.
assconfig_timeoffset "-10" // Subtracts 10 hours to the server time.
```

### Saferoom system
#### Main Features
1. What is asssaferoom_entrymode for?

It sets how the Saferoom system will let survivors into the saferoom. If set to 0, the door will remain locked and all survivors will be warped inside. If set to 1, the door will unlock and survivors can get in.

2. What are the Saferoom system options?
```
1. Boss // Add "b" to asssaferoom_systemoptions to use.
2. Filter // Add "f" to asssaferoom_systemoptions to use.
3. Group // Add "g" to asssaferoom_systemoptions to use.
4. Keyman // Add "k" to asssaferoom_systemoptions to use.
5. Lockdown // Add "l" to asssaferoom_systemoptions to use.
```

3. How can I configure what options the Saferoom system will use.

Set the values in asssaferoom_systemoptions.

Examples:
```
asssaferoom_systemoptions "fkl" // Only Filter, Keyman, and Lockdown options will be used.
asssaferoom_systemoptions "k" // Only Keyman option will be used.
asssaferoom_systemoptions "lgb" // Only Boss, Group, and Lockdown options will be used.
```

4. What is the asssaferoom_warpcountdown for?

It adds a delay to the warp function of the Saferoom system.

Example:
```
asssaferoom_warpcountdown "60" // It takes 60 seconds or 1 minute before all survivors are warped inside the saferoom if asssaferoom_entrymode is set to 0.
```

#### Boss
1. How does the Boss option work?

If the Boss option is chosen, the plugin will spawn a Tank behind the player that initially touched the door. Once that Tank is killed, the door can be unlocked.

2. What kind of bosses are there?

For now, there's only the Tank as a boss. Future updates may include integration of my Super Tanks+ plugin. We'll see...

#### Delay
1. How does the Delay option work?

- Saferoom doors move at a speed defined by assdelay_doorspeed.
- Saferoom doors get a cooldown between rotations. The cooldown duration is defined by assdelay_doordelay.
- Depending on the door type defined in assdelay_doortype, a saferoom door may or may not be affected.

2. How do I reset the door speed back to default?

Set the value of assdelay_doorspeed to 200.0.

3. How do I stop players from spamming the doors to prevent other players from getting in or out of the saferoom?

Set the cooldown value in assdelay_doordelay.

#### Filter
1. How does the Filter option work?

If the Filter option is chosen, the plugin will check if the player touching the door has any strikes. If the player's number of strikes matches or exceeds the value defined in assstrike_strikelimit, then the door remains locked. If the player's number of strikes is less than the value defined in assstrike_strikelimit, then the door is unlocked.

2. What if the whole survivor team matches or exceeds the strike limit?

The saferoom door will automatically unlock when a player touches it.

3. What is the assfilter_blockenable for?

The convar gives you the option to punish players whose strike limit either matches or exceeds the value defined in assstrike_strikelimit. The type of punishments that the Filter option can use is defined in assfilter_blockoptions.

4. What is the assfilter_blockmode for?

The convar tells the Filter option to either pick a random punishment or combine all the punishments together. The punishments should be defined in assfilter_blockoptions.

5. What are the options available for assfilter_blockoptions?

```
1. Acidity // Add "w" to assfilter_blockoptions to use.
2. Ammunition // Add "j" to assfilter_blockoptions to use.
3. Blindness // Add "c" to assfilter_blockoptions to use.
4. Charge // Add "x" to assfilter_blockoptions to use.
5. Chase // Add "v" to assfilter_blockoptions to use.
6. Disarmament // Add "k" to assfilter_blockoptions to use.
7. Drug // Add "b" to assfilter_blockoptions to use.
8. Exile // Add "z" to assfilter_blockoptions to use.
9. Explosion // Add "t" to assfilter_blockoptions to use.
10. Fire // Add "n" to assfilter_blockoptions to use.
11. Freeze // Add "f" to assfilter_blockoptions to use.
12. Health // Add "o" to assfilter_blockoptions to use.
13. Hurt // Add "l" to assfilter_blockoptions to use.
14. Idle // Add "y" to assfilter_blockoptions to use.
15. Incapacitation // Add "q" to assfilter_blockoptions to use.
16. Inversion // Add "g" to assfilter_blockoptions to use.
17. Mirror // Add "m" to assfilter_blockoptions to use.
18. Puke // Add "u" to assfilter_blockoptions to use.
19. Restart // Add "h" to assfilter_blockoptions to use.
20. Rocket // Add "r" to assfilter_blockoptions to use.
21. Shake // Add "e" to assfilter_blockoptions to use.
22. Shock // Add "s" to assfilter_blockoptions to use.
23. Shove // Add "d" to assfilter_blockoptions to use.
24. Slow // Add "a" to assfilter_blockoptions to use.
25. Vision // Add "p" to assfilter_blockoptions to use.
26. Warp // Add "i" to assfilter_blockoptions to use.
```

#### Group
1. How does the Group option work?

If the Group option is chosen, the plugin will check how many survivors are near the saferoom door when a player touches it. If the number of nearby survivors matches or exceeds the value defined in assgroup_survivorcount, then the door will unlock. Otherwise, the door will remain locked.

2. What is the assgroup_groupdistance for?

The convar determines how close survivors have to be to the saferoom door to be counted towards assgroup_survivorcount.

3. What if there aren't enough survivors alive to meet the requirement?

The saferoom door will automatically unlock when a player touches it.

#### Keyman
1. How does the Keyman option work?

If the Keyman option is chosen, the plugin will assign a number of players to be Keymen. Only they will be allowed to unlock the door.

2. How do I tell the plugin how many players can be a Keyman?

Set the value in asskeyman_keymanamount.

3. What is the asskeyman_countdown for?

The convar determines how long after a non-Keyman player initially touches the door until a new set of Keymen are chosen. The countdown is canceled if a Keyman opens the door before it ends. This is a feature that prevents Keymen from trolling the team.

4. What happens if all the Keymen are dead?

Each time a Keyman dies, disconnects, goes AFK, or gets incapacitated, a new one is chosen.

#### Lockdown
1. How does the Lockdown option work?

If the Lockdown option is chosen, the plugin will initiate a lockdown before a saferoom door can open.

2. What is asslockdown_doortype for?

The convar lets you decide which type of saferoom door can use the Lockdown option.

3. How can I set the length of lockdowns?

- For starting saferoom doors, set the value in asslockdown_countdown.
- For ending saferoom doors, set the value in asslockdown_countdown2.

4. What is asslockdown_spawnmobs for?

The convar tells the plugin whether to spawn mobs during a lockdown or not. This feature only applies to ending saferoom doors.

### Strike system
#### Main Features
1. What is assstrike_detectiondelay for?

The convar determines how many seconds pass before the plugin checks for speedrunners.

2. How can I set the strike limit that players can reach before being punished?

Set the value in assstrike_strikelimit.

3. How can I disable the strike limit feature?

Set assstrike_strikemode to 0.

4. What is the assstrike_punishmode for?

The convar tells the Strike system to either pick a random punishment or combine all the punishments together. The punishments should be defined in assstrike_systemoptions.

5. What are the options available for assstrike_systemoptions?

```
1. Acidity // Add "w" to assstrike_systemoptions to use.
2. Ammunition // Add "j" to assstrike_systemoptions to use.
3. Blindness // Add "c" to assstrike_systemoptions to use.
4. Charge // Add "x" to assstrike_systemoptions to use.
5. Chase // Add "v" to assstrike_systemoptions to use.
6. Disarmament // Add "k" to assstrike_systemoptions to use.
7. Drug // Add "b" to assstrike_systemoptions to use.
8. Exile // Add "z" to assstrike_systemoptions to use.
9. Explosion // Add "t" to assstrike_systemoptions to use.
10. Fire // Add "n" to assstrike_systemoptions to use.
11. Freeze // Add "f" to assstrike_systemoptions to use.
12. Health // Add "o" to assstrike_systemoptions to use.
13. Hurt // Add "l" to assstrike_systemoptions to use.
14. Idle // Add "y" to assstrike_systemoptions to use.
15. Incapacitation // Add "q" to assstrike_systemoptions to use.
16. Inversion // Add "g" to assstrike_systemoptions to use.
17. Mirror // Add "m" to assstrike_systemoptions to use.
18. Puke // Add "u" to assstrike_systemoptions to use.
19. Restart // Add "h" to assstrike_systemoptions to use.
20. Rocket // Add "r" to assstrike_systemoptions to use.
21. Shake // Add "e" to assstrike_systemoptions to use.
22. Shock // Add "s" to assstrike_systemoptions to use.
23. Shove // Add "d" to assstrike_systemoptions to use.
24. Slow // Add "a" to assstrike_systemoptions to use.
25. Vision // Add "p" to assstrike_systemoptions to use.
26. Warp // Add "i" to assstrike_systemoptions to use.
```

#### Chase
1. How can I decide which special infected goes after players?

Set the values in asschase_infectedtype.

#### Disarmament
1. How can I decide which weapon slots are disarmed?

Set the values in assdisarm_weaponslot.

#### Exile
1. How can I decide if a player is kicked or banned?

Set the value in assexile_exilemode.

2. How do I set the duration of the bans?

Set the value in assexile_banduration.

#### Hurt
1. How can I decide how much damage players take per second?

Set the value in asshurt_damageamount.

#### Restart
1. How can I decide what loadout players restart with?

Set the loadout in assrestart_loadout.

#### Slow
1. How can I decide how slow players should be?

Set the value in assslow_runspeed.

## Credits
**ztar, Pescoxa, raziEil (disawar)** - For the [Anti-Runner System - REMAKE (Keyman system)](https://forums.alliedmods.net/showthread.php?p=2552450#post2552450).

**panxiaohai** - For the [We Can Not Survive Alone (Group and Chase systems)](https://forums.alliedmods.net/showthread.php?t=167389).

**Krufftys Killers** - For sharing the code to his Anti-Solo plugin (Warp system), reporting errors, setting up a server specifically for testing the plugin, and for overall continuous support.

**cravenge** - For the [Lockdown System (Delay and Lockdown systems)](https://forums.alliedmods.net/showthread.php?p=2409095) and for helping me with various parts of the code.

**phoenix0001** - For [suggesting](https://forums.alliedmods.net/showthread.php?t=297009) a plugin ([twice](https://forums.alliedmods.net/showthread.php?t=297009)) that requires changing a cvar based on client count.

**Tak (Chaosxk)** - For providing a [rough sample](https://forums.alliedmods.net/showpost.php?p=2518197&postcount=4) of how to change a cvar based on client count.

**Lux** - For fixing up Tak (Chaosxk)'s [code](https://forums.alliedmods.net/showpost.php?p=2561468&postcount=9) and helping me with some parts of the code.

**NgBUCKWANGS** - For helping to fix the errors reported by Krufftys Killers [here](https://forums.alliedmods.net/showpost.php?p=2561615&postcount=23) and for the mapname.cfg and convar switch code in his [ABM](https://forums.alliedmods.net/showthread.php?t=291562) plugin.

**KasperH** - For the Hungarian phrase translations and reporting errors.

**Mi.Cura** - For the Portuguese phrase translations and reporting errors.

**joyist** - For the Chinese phrase translations.

**8guawong** - For helping me with some parts of the code.

**Powerlord** - For showing me a better and more efficient way in creating and handling vote menus.

**Spirit_12** - For the L4D signatures for the gamedata file.

**honorcode** - For the L4D2 signatures for the gamedata file found in the L4D2 New Custom Commands' gamedata file and the codes to spawn spitter acid puddles, to charge at players, to cause explosions, to ignite players, to set players to black and white, to incapacitate players, to puke on players, to shake players' screens, and to shove players.

**strontiumdog** - For the [Evil Admin: Mirror Damage](https://forums.alliedmods.net/showthread.php?p=702913), [Evil Admin: Rocket](https://forums.alliedmods.net/showthread.php?t=79617), and [Evil Admin: Vision](https://forums.alliedmods.net/showthread.php?p=702918).

**Marcus101RR** - For the code to set a player's weapon's ammo.

**AtomicStryker** - For the code and gamedata signatures to respawn survivors.

**Farbror Godis** - For the [Curse](https://forums.alliedmods.net/showthread.php?p=2402076) plugin.

**Silvers (Silvershot)** - For the code that allows users to enable/disable the plugin in certain game modes and help with gamedata signatures.

**Milo|** - For the code that automatically generates config files for each day and each map installed on a server.

**Impact** - For the [AutoExecConfig](https://forums.alliedmods.net/showthread.php?t=204254) include.

**hmmmmm** - For showing me how to pick a random character out of a dynamic string and for his [Menu Targeting](https://forums.alliedmods.net/showthread.php?t=306954) include.

**SourceMod Team** - For the beacon, blind, drug, and ice source codes.

# Contact Me
If you wish to contact me for any questions, concerns, suggestions, or criticism, I can be found here:
- [AlliedModders Forum](https://forums.alliedmods.net/member.php?u=181166)
- [Steam](https://steamcommunity.com/profiles/76561198056665335)

# 3rd-Party Revisions Notice
If you would like to share your own revisions of this plugin, please rename the files! I do not want to create confusion for end-users and it will avoid conflict and negative feedback on the official versions of my work. If you choose to keep the same file names for your revisions, it will cause users to assume that the official versions are the source of any problems your revisions may have. This is to protect you (the reviser) and me (the developer)! Thank you!

# Donate
- [Donate to SourceMod](https://www.sourcemod.net/donate.php)

Thank you very much! :)
