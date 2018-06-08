# Changelog

## Version 29.8 (June 8, 2018)

1. Bug fixes:

- Grammar fixes.

2. Changes:

- Modified the ass_ammo command to allow for no 3rd argument to count as 0.

## Version 29.7 (June 8, 2018)

1. Updated translation file.

## Version 29.6 (June 8, 2018)

1. Edited the default values of the assstrike_systemoptions and assfilter_blockoptions convars.

## Version 29.5 (June 8, 2018)

1. Bug fixes:

- Fixed the Fire option returning errors on round_start event.

## Version 29.4 (June 8, 2018)

1. Updated translation file.

## Version 29.3 (June 8, 2018)

1. Bug fixes:

- Fixed the Mirror option not working when the attacker and the victim are on the same team.

## Version 29.2 (June 8, 2018)

1. Bug fixes:

- Fixed the Mirror option returning an error when the attacker disconnects.
- Fixed the Mirror option instantly killing any victim of the attacker.

## Version 29.0 (June 8, 2018) (Official GitHub Release)

1. Bug fixes:

- Fixed the Failsafe feature not working properly.
- Fixed the game mode convars not affecting the Saferoom system properly.
- Fixed the bug where the ending saferoom door wouldn't open in some custom maps.
- Fixed the Keyman option not choosing a new Keyman properly when needed.
- Fixed the Keyman option not resetting properly on OnMapEnd().

2. New features:

- Added the Mirror option for the Strike system.
- Added custom config options based on player count and difficulty level of the server.
- Added an option to trigger the Lockdown option for the starting saferoom door.
- Added a check on OnConfigsExecuted() to change the Restart option to Warp option if the plugin is reloaded.
- Added a check to only get the position of survivors for the Restart option.
- Added the ass_mirror command that mirrors a player's damage.
- Added the ass_entry command that warps all survivors inside the saferoom.
- Added the assexile_exilemode convar to decide which form of exile to punish players with.
- Added the assfilter_blockenable convar to decide whether or not to punish blocked door users.
- Added the assfilter_blockmode convar to decide how the Strike system options are used to punish blocked door touchers.
- Added the assfilter_blockoptions convar to decide which Strike system options to use for punishing blocked door users.
- Added the asslockdown_countdown2 convar to adjust the lockdown countdown of the ending saferoom door.
- Added the asslockdown_doortype convar to decide which door type can use the Lockdown option.
- Added the asssaferoom_entrymode convar to decide between unlocking the door and warping survivors inside the saferoom.
- Added the asssaferoom_warpcountdown convar to decide how long until survivors are warped inside the saferoom.
- Added a vote menu for the Lockdown option at the starting saferoom.
- Added a 2nd parameter/argument for the ass_door command.
- Added messages to inform players when an effect on a player is removed.
- Added a menu that pops up with a list of players with similar names when one of them is targeted. (Thanks hmmmmm!)

3. Changes:

- The ass_null command now requires root flag.
- The Boss option's boss spawner no longer uses a fake client to spawn a boss.
- The Lockdown option's mob spawner no longer uses a fake client to spawn a mob.
- The Chase option's special infected spawner no longer uses a fake client to spawn a special infected.
- Idle mode now works even with only 1 human survivor.
- Combined the Kick and Ban options to form the Exile option for the Strike system.
- Combined the ass_ban and ass_kick commands to form the ass_exile command.
- Changed the assban_duration convar to assexile_banduration.
- Changed how the Restart option gets the coordinates of each spawn area.
- Switched to a new method of translating menu texts.
- Improved the Strike system's Idle option.
- Modified the assconfig_executetype and assconfig_createtype convars to support the new custom config types.
- Modified the asslockdown_countdown to now adjust the lockdown countdown for starting saferoom doors.
- Modified the parameters/arguments of various commands.
- Readded the "None" option in the Saferoom system vote menu.
- Renamed the ass_saferoom command to ass_room.
- Removed unnecessary convar change hooks.
- Removed unnecessary checks.
- Removed colored messages.

4. Files:

- Updated game data file.
- Updated include file.
- Updated translation file.

## Version 28.3 (June 1, 2018)

1. The function for choosing a new Keyman is now triggered when a player returns from idle mode.
2. Optimized code a bit.

- No changes to config files.
- No changes to game data file.
- No changes to translation file.
- Updated ass_keyman.sp.
- Updated anti-speedrunner_system.sp.
- Updated include file.

## Version 28.2 (May 31, 2018)

1. Fixed the issue with a new Keyman not being chosen when a Keyman is incapacitated, killed, disconnected, or switched to another team.
2. Fixed the issue with a new set of Keymen not being chosen when the Keyman countdown ends.
3. Added @survivors and @infected target filters for convenience.

- No changes to config files.
- No changes to game data file.
- Updated anti-speedrunner_system.sp.
- Updated ass_keyman.sp.
- Updated include file.
- Updated translation file.

## Version 28.0 (May 31, 2018)

1. Fixed ShowActivity2() not working properly.
2. Changed how ass_config works. (Before: ass_config <1: map|2: mode|3: day> "filename" | After: ass_config <0: create|1: execute> <0: map|1: mode|2: day> "filename")
3. Fixed Lockdown countdown sometimes opening the door too early or too late.
4. Fixed Lockdown countdown not resetting when a lockdown is re-activated.
5. Lockdown system now continuously spawns mobs of zombies until lockdown is over.
6. Fixed Keyman countdown sometimes choosing a new Keyman too early or too late.
7. Fixed Keyman countdown not resetting when a new Keyman is chosen.
8. The Keyman option now allows for multiple Keymen per map.
9. Replaced the Kill option with an Idle option. (Use ass_idle to force a player to go idle.)
10. Removed the assheal_bufferamount since it doesn't work.
11. Added more parameters to most of the admin commands.
12. Admin commands will now stay enabled even if their corresponding options aren't listed in assstrike_systemoptions.
13. Improved logging.
14. Modified some convars.
15. Optimized code a bit more.
16. Updated gamedata file.
17. Updated include file.
18. Updated translation file.

## Version 27.2 (May 25, 2018)

1. Fixed map configs not generating properly for the L4D2 version.

## Version 27.0 (May 24, 2018)

1. Removed the assmenu_enablesystem convar.
2. Added the ass_config command which allows admins with root flag to create a custom config in-game.
3. Removed the l4d and l4d2 subfolders under map_configs and gamemode_configs and added the l4d2_/l4d_ prefixes for those folders.

- cfg/sourcemod/anti-speedrunner_system/l4d2_gamemode_configs / cfg/sourcemod/anti-speedrunner_system/l4d_gamemode_configs
- cfg/sourcemod/anti-speedrunner_system/l4d2_map_configs / cfg/sourcemod/anti-speedrunner_system/l4d_map_configs

- No changes to gamedata file.
- No changes to translation file.

## Version 26.5 (May 22, 2018)

1. Fixed custom configs not being executed.
2. Added the command ass_null to manually turn off all current effects on a player at once.
3. Improved command logging.
4. Bug fixes.
5. Updated translation file.

- No changes to convars.
- No changes to config files.
- No changes to gamedata file.

## Version 26.0 (May 20, 2018)

1. Added a subfolder for each L4D game inside the cfg/sourcemod/anti-speedrunner_system/gamemode_configs folder.
2. Added a subfolder for each L4D game inside the cfg/sourcemod/anti-speedrunner_system/map_configs folder.
3. Added the Ammunition option for the Strike system.
4. Added the Inversion option for the Strike system.
5. Added the Restart option for the Strike system.
6. Added the Rocket option for the Strike system.
7. Added the Vision option for the Strike system.
8. Added the Filter option for the Saferoom system.
9. Removed the "None" option in the Saferoom system vote menu.
10. Added support for multiple combinations for the Strike system and Saferoom system options.
11. Added default functions for the following convars:

- asschase_infectedtype "" - Defaults to the Hunter when the convar value is left empty.
- asssaferoom_systemoptions "" - Defaults to the None option when the convar value is left empty.
- assstrike_systemoptions "" - Defaults to the Warp option when the convar value is left empty.

12. Added a convar to enable/disable the plugin's menus.
13. Added a convar for the Strike system to decide whether to punish speedrunners with all specified options or just pick one of them.
14. Auto mode now creates a global timer rather than a timer for each client.
15. Added a convar to adjust the detection timer for speedrunners.
16. Added a convar to log command usage.
17. Fixed the Delay system not working sometimes.
18. Fixed the saferoom door not unlocking when the plugin is reloaded while any of the Saferoom systems are enabled.
19. Fixed the custom configs not being created by calling the functions on OnMapStart() instead of OnPluginStart().
20. Fixed the plugin not creating config files for mutations.
21. The plugin now checks for "sv_gametypes" to get the game modes ran by the server, not just "mp_gamemode" which only shows the current game mode.
22. Incapacitated survivors are no longer punished for being separated from the rest of the team.
23. Optimized code.
24. Updated translation file with new phrases and removed some old phrases.
25. Included custom config files for each stock mutation and every mutation from Rayman1103's Mutation Mod.
26. Included custom config files for each map of all stock campaigns and 200 custom campaigns.

## Version 25.0 (May 6, 2018)

1. More files!
2. More systems!
3. More variety!
4. Less code!
5. Less convars!
6. Less lines!
7. Fixed lots of bugs.
8. Updated translation file with new phrases. (Thanks to Mi.Cura for Portuguese translations and KasperH for Hungarian translations!)

## Version 24.0 (April 18, 2018)

1. Separated the plugin into individual plugins.
2. All related plugins now depend on an include file.
3. Renamed the following systems:

Bile = Puke

Companion = Group

Health = Hurt

Punishment = Chase

Teleportation = Warp

## Version 23.0 (April 14, 2018)

1. Switched back from OnAutoConfigsBuffered() to OnConfigsExecuted().
2. Added the cvar ass_configtype to choose between map-based configs, game mode configs, daily configs, or all three.
3. Added the cvar ass_configexecute to decide which type of config file to execute on OnConfigsExecuted().
4. Added the cvar ass_timeoffset to decide the time offset of the server used by the daily config files.
5. Renamed the cvar ass_generateconvars to ass_configconvars.
6. Renamed the cvar ass_generateconfigs to ass_configcreate.
7. The plugin now requires and uses anti-speedrunner_system.inc to create/update the autoconfig file.
8. The autoconfig file was moved from cfg/sourcemod to cfg/sourcemod/anti-speedrunner_system.

## Version 22.2 (April 7, 2018)

1. Fixed the plugin not generating the assdelay_finalemaps cvar in the custom config files, and instead generating 2 asshealth_finalemaps cvars.

## Version 22.0 (April 6, 2018)

1. Re-coded how the plugin detects incapacitated players. (Thanks cravenge!)
2. Fixed the Keyman system spamming chat with messages when various players are incapacitated.
3. Added a feature that allows the plugin to automatically generate a config file with all the plugin's convars for each map if it doesn't already exist.
4. Added the cvar ass_generateconfigs to decide whether or not the plugin automatically generates a config file for each map.
5. Added the cvar ass_generateconvars to decide whether or not the plugin automatically generates the plugin's convars in the map-based config files.
6. Other bug fixes.
7. Hid the ass_pluginversion cvar.
8. Updated translation file with KasperH's changes.

## Version 21.2 (March 22, 2018)

1. Fixed the Keyman system choosing a new Keyman when certain events are fired.
2. Possibly fixed a problem regarding the Shake system that caused crashes. (Thanks Lux and KasperH!)

## Version 21.0 (March 10, 2018)

1. Added cvars to disable Bile, Delay, Health, Incapacitation, Punishment, Shake, and Teleportation systems during finales.
2. Added cvars to allow bots to bypass the security systems and open up the saferoom doors.
3. Bug fixes for Companion, Keyman, and Lockdown systems.
4. Removed unnecessary check for Delay system.
5. Divided the ass_announcesystems and ass_announcetimer into 10 different cvars each for more options.
6. Users without the gamedata file can still use the plugin but the Bile system will automatically disable itself until the gamedata file is present.

## Version 20.3 (February 1, 2018)

1. Fixed automode for Companion, Keyman, and Lockdown systems not resetting upon map transition. (Before: The plugin would still break after choosing a random method.)

## Version 20.2 (January 24, 2018)

1. Companion and Keyman systems will properly shut off on disabled game modes. (Before: they would still activate and thus could cause issues for certain config settings.)
2. On automated mode, once a method has been randomly chosen, it will stay that way. (Before: some of the methods overlapped.)

## Version 20.0 (January 22, 2018)

1. Added the Health system.
2. Readded the Incapacitation system with a different purpose and function.
3. Replaced the override commands with unique ones for each applicable system.
4. Improved the voting system for all 10 systems.
5. Added _votesystem and _automode cvars for the Companion and Lockdown systems to decide whether players can vote for the method of entry or the plugin chooses a random method.
6. Added _admintouch cvars for the Companion, Keyman, and Lockdown systems to allow admins to bypass the saferoom security.
7. Added the command sm_asscmd to allow players to bring up a list of available vote commands.
8. Added the command sm_assadmin to allow admins to bring up a list of available admin commands.
9. Added _distancefinal cvars to allow users to decide whether or not the systems can overlap each other.
10. Vote menus no longer appear to idle players and anyone who isn't playing on the survivor team.
11. Optimized/shortened some of the code.
12. Updated translation file to include a ton of new announcements/messages including ones for the Health and Incapacitation systems.

## Version 19.0 (January 16, 2018)

1. Removed the ass_override command.
2. Added the command sm_assadmin to list all admin commands to admins.
3. Added the command sm_asscmd to list all vote commands to players.
4. All admin commands can now be used as overrides for their respective systems (One command override for each system is enough).
5. Added the Shake system to annoy speedrunners.
6. Added the commands sm_votequake/sm_vquake, sm_quake "player"/sm_fquake "player", and sm_autoquake/sm_afquake.
7. Added a feature that freezes speedrunners for a certain amount of time after being teleported.
8. Added a feature that changes speedrunners' movement speed when puked on.
9. Added cvars to decide whether or not to inform players of commands.
10. Fixed some messages not being displayed properly.
11. Fixed the issue with special infected being targetable by the admin commands.
12. Separated the cvars assrush_disabledgamemodes and assrush_enabledgamemodes for each of the systems that they support.
13. Separated the cvars asssaferoom_disabledgamemodes and asssaferoom_enabledgamemodes for each of the systems that they support.
14. Updated translation file to include Shake system's announcements/messages and new messages for other systems.

## Version 18.0 (January 12, 2018)

1. Added the cvars ass_enabledgamemodes and ass_disabledgamemodes to allow users to decide what game modes to enable/disable the plugin in.
2. Added the cvars asssaferoom_enabledgamemodes and asssaferoom_disabledgamemodes to allow users to decide what game modes to enable/disable the Companion, Delay, Keyman, and Lockdown systems in.
3. Added the cvars assrush_enabledgamemodes and assrush_disabledgamemodes to allow users to decide what game modes to enable/disable the Bile, Punishment, and Teleportation systems in.
4. Permanently fixed the Companion, Keyman, and Lockdown systems returning invalid after map/campaign transitions.
5. Fixed the "(3)ABMclient2" bug so now the plugin should no longer conflict with any version of ABM (I hope...).
6. Added a check for infected team (this relates to competitive modes).
7. Made it so that most announcements/messages are only visible to players on the survivor team while the rest are only viewable by admins regardless of their team.
8. Fixed the countdown timer for choosing a new Keyman not working.
9. Changed how some messages are displayed.
10. Lockdown system is now fully functional.
11. Removed some unnecessary code.
12. Updated translation file to include new messages.

## Version 17.0 (January 10, 2018)

1. Fixed a log error with the lockdown timer.
2. Moved the Incapacitation system to be part of the plugin's core features. (I figured a crucial feature shouldn't need to be its own system.)
3. Fixed the Companion, Keyman, and Lockdown systems' gamemode check returning invalid after a few map transitions in L4D2.
4. Renamed the commands sm_bile, sm_autobile, and sm_votebile to sm_puke, sm_autopuke, and sm_votepuke.
5. Fixed the issue with some announcements/messages appearing multiple times at once in chat.
6. Updated translation file with KasperH's Hungarian translations and to exclude Incapacitation system messages.

## Version 16.0 (January 5, 2018)

1. Fixed the Keyman system choosing a new Keyman each time the current Keyman gets revived. (It should only happen when the current Keyman gets incapacitated.)
2. Added the command sm_lock <0|1> to allow admins to forcefully lock/unlock saferoom doors.
3. Added the cvar ass_commandaccess to decide whether or not to give admins access to the sm_lock <0|1> command.
4. Minor code revisions.
5. Updated translation file to include new messages.

## Version 15.0 (January 1, 2018)

1. Added the Bile system. (Requires gamedata file.)
2. Added the Companion system. (Requested by Krufftys Killers.)
3. Added the Lockdown system (just half of cravenge's Lockdown System). (Currently in its experimental state so please let me know if you encounter any problems/errors.)
4. Renamed the cvar assincap_requiredamount to assincap_incappedcount.
5. Changed how the Incapacitation system works again adding the cvar assincap_revivedcount to decide how many non-incapped/revived survivors must be present to re-enable the other systems.
6. Added the commands sm_vbile, sm_bile "player", and sm_autobile.
7. Fixed the cvar asskeyman_tankalive not working properly.
8. Fixed the vote system not counting votes properly.
9. Fixed the _adminimmunity cvars not working properly.
10. Fixed the Keyman system returning invalid after map transition on L4D.
11. Fixed the Keyman system not disabling properly on bugged/finale maps.
12. Added the override command ass_override so server owners can filter which admin flags are immune to the systems and can see the admin-only messages/announcements.
13. Added the OnClientPostAdminCheck() forward for handling the system status announcements.
14. Fixed the errors reported by Krufftys Killers regarding HasEntProp, vDoorControl, and vCvarChanged_cvKeymanEnable.
15. Combined the function callbacks called by the Punishment system for both automatic and manual modes. (No longer glitches.)
16. Combined the function callbacks called by the Teleportation system for both automatic and manual modes. (No longer glitches.)
17. Added a check for translation files. (English users no longer need it.)
18. Removed support for non-competitive game modes.
19. Added a check to allow spectators to vote since the plugin only supports non-competitive modes anyway.
20. Redid the entire code for the Punishment system to be exactly like the Teleportation system's code. (This now makes the Punishment system more accurate and efficient.)
21. Removed the cvar asskeyman_countbots due to uselessness.
22. Added a vote feature for choosing the method of entry when the Companion, Keyman, and Lockdown systems are all enabled. (Options: 1. Companion, 2. Keyman, 3. Lockdown, 4. None)
23. Added a vote feature for deciding which method of entry to use when only 2 of 3 saferoom systems (Companion, Keyman, Lockdown) are enabled. (Options: 1. X, 2. X, 3. Neither)
24. Added a vote feature for deciding if a method of entry should be used when only 1 of 3 saferoom systems (Companion, Keyman, Lockdown) is enabled. (Options: 1. X, 2. None)
25. Fixed the Teleportation system not respecting admin immunity.
26. Fixed the Teleportation system teleporting bots to admins when admin immunity is on.
27. Optimized code by removing redundant lines/function callbacks.
28. Updated translation file to support Bile, Companion, and Lockdown systems' announcements/messages.

## Version 14.0 (December 25, 2017)

1. Renamed all cvars, files, and file paths.
2. Added alternatives to the commands.
3. Changed how the Incapacitation system works. (Once all systems are disabled, all survivors must be revived before systems are turned back on.)
4. Added the cvar ass_announcesystems to decide whether or not to announce the status of each system on every map start.
5. Added the cvar assdelay_endingspeed and assdelay_startingspeed to decide how fast/slow saferoom doors should open.
6. Added the cvars asskeyman_override, asspunish_override, and assteleport_override to decide whether or not admins have access to the admin commands during automatic mode.
7. Added the cvar asspunish_countbots to decide whether or not the Punishment system should consider bots as players.
8. Added the cvar asspunish_detectiondelay to decide how often the Teleportation system checks for speedrunners.
9. Renamed the sm_chase and sm_warp commands to sm_autochase and sm_autowarp.
10. Added the commands sm_chase and sm_warp for individual targetting.
11. Separated the callback functions of the automated mode for systems from the ones used by the commands/vote system.
12. Combined the cvars ass_inform and ass_inform_timer into 1 cvar: ass_informplayers.
13. Added the cvar asskeyman_choosedelay to decide how long until a new Keyman is chosen from the moment the function is called.
14. Changed how the cvar asskeyman_tankalive works by how it was coded.
15. Removed the Tank as an option in the asspunish_infected cvar and renamed the cvar to asspunish_infectedtype.
16. Made it so that any value used for asspunish_infectedtype other than the ones specified in the cvar description will either spawn a Tank or a mob.
17. Renamed the cvars asspunish_maxinterval and asspunish_mininterval to asspunish_maxseconds and asspunish_minseconds respectively.
18. All time/distance-based cvars can now be disabled with the value "0.0" but this means that some of these cvars can make their respective systems null and void.
19. Added the cvar asskeyman_countbots to decide whether or not the Keyman system can pick bots to be the Keyman. (Recommended only for servers with no humans.)
20. Changed the cvars assdelay_endingantispam and assdelay_startingantispam to be timers now.
21. Added support for versus/team versus, scavenge/team scavenge, and survival modes. (Edit lines 357 and 1011 to add support for other gamemodes.)
22. Fixed vote system always returning yes regardless of the winning vote option.
23. Fixed vote system menu only showing up for the player that starts the vote.
24. Fixed vote system only translating to the vote caller's language instead of each client's language.
25. Fixed errors regarding the Keyman system, specifically HasEntProp, ControlDoor, and CvarChanged_asskeyman_enablesystem.
26. Redid the entire vote system in favor of efficiency and less code.
27. The commands' callback functions are now separate from the _automode cvars' callback functions.
28. The Keyman system's automatic mode now disables access to commands and vote system.
29. The Punishment system's automatic mode now disables access to commands and vote system.
30. The Teleportation system's automatic mode now disables access to commands and vote system.
31. The cvar ass_enableplugin now disables the entire system properly.
32. Updated translation file to support the responses to commands when there's a Tank alive, when the entire plugin is off, when the system tied to a command is off, when the cvar for a command itself is turned off, a Teleportation system announcement, and new vote results messages.
33. Switched from OnConfigsExecuted() to OnAutoConfigsBuffered for handling custom map settings.
34. Major code clean-up and optimization.

## Version 13.0 (December 15, 2017)

1. Added the cvar l4d_ass_inform_timer to decide when to inform players.
2. Added the cvar l4d_ass_keyman_timer to decide when to choose a new Keyman after a non-Keyman first tries to open the ending saferoom door.
3. Separated GlobalBuffer into separate arrays to avoid problems.
4. Updated translation file to include some minor changes and KasperH's Hungarian phrase translations.

## Version 12.5 (December 14, 2017)

1. Added the cvar l4d_ass_keyman_specify to decide whether sm_key randomly chooses a player to be the Keyman or a player's name can be specified in the 2nd parameter. (sm_key or sm_key "player")
2. Fixed the inform message repeating 2-3 times within a 6-second period.
3. System announcements are now only visible to admins.
4. Added the cvar l4d_ass_keyman_auto to decide whether or not a Keyman is automatically chosen.
5. Added the cvar l4d_ass_keyman_force decide whether or not admins can force-choose a Keyman.
6. Split the cvar l4d_ass_admin into 3 separate cvars for the Keyman, Punishment, and Teleportation systems for better management. (l4d_ass_keyman_admin = only admins can be chosen, l4d_ass_punish_admin and l4d_ass_teleport_admin = admins are granted immunity.)
7. Added a vote system for the Keyman system. (Can still work even if l4d_ass_keyman_auto is on.)
8. Added the cvar l4d_ass_keyman_vote to decide whether or not players can use sm_votekey.
9. Players can now vote to choose a new Keyman using sm_votekey.
10. The inform timer has been increased from 45 seconds to 2 minutes so it's less spammy.
11. Updated translation file to include the sm_votekey command message used to inform players.

## Version 12.0 (December 12, 2017)

1. Reorganized the entire code and added category keywords to make finding certain parts easier.
2. Removed the sm_rush command.
3. Removed the Keyman System option from the admin menu.
4. Renamed the cvar l4d_ass_teleport_distance to l4d_ass_teleport_range.
5. Added limits to cvar values.
6. Added the cvar l4d_ass_enable to allow users to enable/disable the entire plugin.
7. Added the cvar l4d_ass_admin to decide whether or not admins are immune to the Teleportation and Punishment systems.
8. Added the cvar l4d_ass_punish_auto to decide whether the Punishment system's function is automatically or manually called.
9. Added the cvar l4d_ass_teleport_auto to decide whether the Teleportation system's function is automatically or manually called.
10. The Punishment system's function can now be manually called by admins via the sm_chase command.
11. The Teleportation system's function can now be manually called by admins via the sm_warp command.
12. Added the cvar l4d_ass_punish_force to decide whether or not admins can force-punish speedrunners.
13. Added the cvar l4d_ass_teleport_force to decide whether or not admins can force-teleport speedrunners.
14. Added a vote system for the Punishment system.
15. Added a vote system for the Teleportation system.
16. Added the cvar l4d_ass_punish_vote to decide whether or not players can use sm_votechase.
17. Added the cvar l4d_ass_teleport_vote to decide whether or not players can use sm_votewarp.
18. Players can now vote to punish speedrunners using sm_votechase.
19. Players can now vote to teleport speedrunners using sm_votewarp.
20. Added the cvar l4d_ass_punish_timer to set the duration of the Punishment system's function when voted on/manually called.
21. Added the cvar l4d_ass_teleport_timer to set the duration of the Teleportation system's function when voted on/manually called.
22. Added a timer to inform players about the sm_votechase and sm_votewarp commands every 45 seconds.
23. Added the cvar l4d_ass_inform to decide whether or not to inform players about the sm_votechase and sm_votewarp commands.
24. Fixed the Keyman system not turning back on properly upon map transition when using custom settings on the previous map. (Will still break when playing on a local/listen server.)
25. Updated translation file to remove unused announcements/messages and add new announcements/messages.

## Version 11.5 (December 8, 2017)

1. Fixed the _tank cvars not working properly.
2. More code optimization.

## Version 11.4 (December 7, 2017)

1. Added the cvar l4d_ass_punish_infected to decide which special infected to send after rushers.
2. Added an option to spawn a Tank after a rusher.
3. Renamed the config file back from l4d_anti-speedrunner_cvar to l4d_anti-speedrunner.
4. Fixed the bug where the plugin stops working between map transitions that use custom map settings.
5. Optimized the code even more.

## Version 11.3 (December 7, 2017)

1. Added a check to properly disable the Keyman system during finales.
2. Optimized code by removing unnecessary/redundant lines.

## Version 11.2 (December 4, 2017)

1. Added support for custom settings for any map.
2. Less code, more files.

## Version 11.1 (December 2, 2017)

1. Applied Lux's suggestions [here](https://forums.alliedmods.net/showpost.php?p=2564044&postcount=44).
2. Updated translation file with KasperH's fixes [here](https://forums.alliedmods.net/showpost.php?p=2564041&postcount=43).

## Version 11.0 (December 1, 2017)

1. Added the Delay system.
2. The anti-spam and anti-close procedure codes for saferoom doors can now operate without the Keyman system.
3. Fixed the Teleportation system not working properly.
4. Lowered the Punishment system's delay check from 3 seconds to 1 second again for efficient teleportation.
5. The Keyman system now only chooses a non-incapacitated player to be the Keyman.
6. Added a check for the Incapacitation system when l4d_ass_incap_required value is greater than the amount of survivors alive.
7. Updated translation file to support Hungarian and Spanish languages.
8. Updated translation file to support the Delay system's announcements.
9. All messages are now handled by the translation file.
10. Optimized the code.

## Version 10.5 (November 23, 2017)

1. Fixed the error where systems were not disabling when a rescue vehicle leaves.
2. All systems now disable when the rescue vehicle arrives.
3. Fixed the error where the Incapacitation system stopped working due to checking for only human players.
4. Shortened the code a bit more.

## Version 10.4 (November 23, 2017)

1. Added a check to disable all systems when the rescue vehicle leaves.
2. Fixed the bug where the "[ASS] Player has been teleported to the team" message keeps spamming the chat when a vehicle is leaving.
3. Shortened the code a bit.

## Version 10.3 (November 22, 2017)

1. Added a better check for checking clients when l4d_ass_teleport_bots is set to 0.

## Version 10.2 (November 22, 2017)

1. Improved the code for the Incapacitation system. (Now 1700+ lines shorter!)
2. The Incapacitation system can now be flexible to allow any number of survivors to be incapacitated for it to take effect. Before, the system would only take effect when 1 survivor is left standing.
3. Fixed an error where the Incapacitation, Punishment, and Teleportation systems weren't disabling on the proper maps.
4. Corrected l4d_greenhouse05_runway to l4d_airport05_runway.
5. Added more checks for disabling the Keyman system on certain maps.
6. Renamed all cvars with the _on suffix to have the _incap suffix instead.
7. Renamed l4d_ass_incap to l4d_ass_incap_enable, l4d_ass_keyman to l4d_ass_keyman_enable, l4d_ass_punish to l4d_ass_punish_enable, l4d_ass_teleport to l4d_ass_teleport_enable.
8. Updated translation file to remove unnecessary indentations and to fix the "CAUTION: Only the Keyman can open the saferoom door." message not showing up in the Russian translation.
9. Optimized the code more. (From 3684 lines to 1919 lines!)

## Version 10.1 (November 21, 2017)

1. Fixed an error where the Incapacitation, Punishment, and Teleportation systems weren't disabling on the following finale maps with big areas:

l4d_greenhouse05_runway, c11m5_runway
l4d_river03_port, c7m3_port
c1m4_atrium
c6m3_port
c2m5_concert
c4m5_milltown_escape
c5m5_bridge
c13m4_cutthroatcreek

## Version 10.0 (November 21, 2017)

1. Optimized code a bit.
2. Added a check for the Incapacitation system for OnMapStart() and OnPluginStart(), in case the map transitions while there are incapacitated survivors in the saferoom.
3. Fixed an error where the Incapacitation system would not work if the Keyman system was off.
4. Fixed an error that prevented the Incapacitation system from re-enabling the other systems.
5. Added 3 cvars to enable/disable the Incapacitation system from re-enabling the other systems even if they are off by default.
6. Renamed the _tank_alive suffix to _tank to shorten some cvars.
7. Renamed l4d_ass_teleport_count_bots to l4d_ass_teleport_bots.
8. Edited l4d_ass_keyman_spam to now enable/disable the anti-spam procedure for both beginning and ending saferoom doors.
9. Added a cvar to enable/disable the ability to close beginning saferoom doors once opened.
10. Added a cvar to enable/disable the anti-spam procedure affecting ending saferoom doors.

## Version 9.0 (November 20, 2017)

1. Added a check to disable all Keyman system features when l4d_ass_keyman is set to 0.
2. Fixed errors reported by Krufftys Killers regarding the saferoom door's entity.
3. Added a cvar to enable/disable the anti-spam procedure for ending saferoom doors.
4. Applied more checks for the Incapacitation system.

## Version 8.0 (November 19, 2017)

1. Added the Incapacitation system.
2. Added a cvar to enable/disable the Incapacitation system.
3. Shortened the command sm_rusher to sm_rush.
4. Shortened all cvars.
5. Updated translation file to support the Incapacitation system's announcements.

## Version 7.0 (November 19, 2017)

1. Removed all announcement-related cvars.
2. Removed the cvar l4d_antispeedrunner_keyman_colors.
3. The delay check for the Teleportation system was raised from 1 second to 3 seconds in favor of less chat spam for the racer.
4. Fixed some announcements not working.
5. Updated translation file.

## Version 6.0 (November 16, 2017)

1. Added a check to prevent griefers from spamming the saferoom door.
2. Renamed the command sm_alone to sm_rusher for consistency.
3. Renamed the cvar l4d_antispeedrunner_lock to l4d_antispeedrunner_keyman_tank_alive for consistency.
4. Updated translation file.
5. Shortened the code.

## Version 5.0 (November 15, 2017)

1. Fixed Punishment system not working even when l4d_antispeedrunner_punish_tank_alive is set to 0.
2. Fixed Teleportation system not working even when l4d_antispeedrunner_teleport_tank_alive is set to 0.
3. The delay check for the Teleportation system was lowered from 5 seconds to 1 second.
4. Converted to new syntax.

## Version 4.0 (November 14, 2017)

1. Added 2 cvars to enable/disable Punishment and Teleportation systems' announcements.
2. Added a cvar to enable/disable Teleportation system affecting bots.
3. Removed l4d_antispeedrunner_announce.
4. Updated translation file to support the Punishment and Teleportation systems' announcements.

## Version 3.0 (November 14, 2017)

1. Added 2 cvars to enable/disable Punishment and Teleportation systems during Tank fights.
2. Renamed a few cvars.
3. Fixed and cleaned some code.

## Version 2.0 (November 13, 2017)

1. Added cvars to enable/disable each system.
2. Removed l4d_antispeedrunner_enable.
3. Renamed all cvars.
4. Fixed and cleaned some code.

## Version 1.0 (November 13, 2017)

Initial Release.
