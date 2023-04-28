--[[ General information  ]]--

Genesis of the Order

A survival map for Supreme Commander

--[[ Author  ]]--

Made by "Jammer" Ronald de Vries

--[[ Special thanks to ]]--

Jip

--[[ Installation guide ]]--

Clone or download this repository. If downloaded, unzip the download. Open a new window and navigate towards your _My Documents_ folder. From there, navigate to: 
``` sh
".../My Documents/My Games/Gas Powered Games/Supreme Commander: Forged Alliance/"
```
If the _Maps_ folder does not exist, create one. Merge the _Maps_ folder of the .zip with your local _Maps_ folder.

--[[ License ]]--

All assets are licensed with [CC-BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/).

--[[ Bugs ]]--


--[[ Future Plans ]]--

End game Score screen / statistics
Redo ArmyStrength 
* Partially done. Update the HP damage buff to include shields 
* Partially done. Update Damage buff to increase range weapons + firerate + projectile live
If Mods are used chance difficulty accordingly
Make a Check: if A factory can build unit or els restrict unit  
* Partially done. Make a Check: vanilla unit stats . Use that for Mod check values

Move DefencObject and emergencyshield to Events 

--[[ Changelog ]]--

---- Version 1 ----
* Initial release

---- Version 2 ----
*  Small fixes

---- Version 3 ----
*  Added 2 extra mexes

---- Version 4 ----
*  Changed Landwaves 

---- Version 5 ----
*  Decreased Walking Speed Boss

---- Version 6 ----
*  ...

---- Version 7 ----
*  Different terrain color 

---- Version 8 ----
*  Terrain color
*  Changed water depth because of boss
*  Boss walking speed changed speed multiplier

---- Version 9 ----
*  Changed water depth because of boss
*  Lowerd walking speed boss slightly

---- Version 10 ----
*  Second boss Hp changed to 80k

---- Version 11 ----
*  Third boss arty fix / added Sam / extra obsidians on arms when difficulty Hard

---- Version 12 ----
*  Decreased Walking Speed Boss
*  Fixed the Hp/damage multiplier 
*  When recalled dialogue should play once
*  Fixed Lag late game broken ForkThread in Armystrenght

---- Version 13 ----
*  Fixed alot of Warnings in moholog
*  Reduced amount of Rambo Sacus 
*    -5 per player around wave 70
*  Added Endless Option 
*    Now possible to win game by destroying all rifts
*    Updated Recall function
*  Recall spot is bigger 
*    added a decal 
*    added Ping to position
*    Recall Text Box
*    New count down timer 
*  Seraphim T4 bomber HP reduced *0.30 
*    Start Bomber HP = 51.4k insted of 176.8k
*  Seraphim Air speed boost alot slower
*    Start Speed = *0.55 up to *1.375 speed max 
*  Updated the PlayDialogue 
*    Can now play custom audio with custom video
*  Added Statistic 
*    Press Shift F3 to show
*  Changed the Welcome message 
*    Dialogue was the Aeon now: the Order of Illuminate
*  Added Extra Drop
*    Fatboy drop to help against last boss

---- Version 14 ----
*  Bug fix

---- Version 15 ----
*  Reduced amount of Rambo Sacus
*    -7 per player around wave 70
*  Reduced amount of T4 
*    -7 per player from wave 76 to 82
*  Second T4 exp air from min 43 now 47
*  Updated UnitsIdle 
*    Units should move when stuck then get attack command again
*  Updated Statistics

---- Version 16 ----
*  Reinforcement drops wont go to Ai or dead player 
*  Added Extra Units Options 
*    Added 3 extra engineers same faction -- Currently default
*      1 Extra Acu same faction
*  Next Recall Timer
*  Mexes a bit closer to players
*  Reduced Health on Seraphim Rifts
*    Added regen increase by time

---- Version 17 ----
*  Endboss fixes
*    Immune to stun
*      Thanks to Jip for adding Unit.ImmuneToStun = true/false to game
*    Not reclaimable
*    sam dps 25 ---> 105
*  Recall count down timer
*    Next Recall timer in minutes now
*  Seraphim Waves
*    Removed Hover AA on last Land Wave now t4 Chicken walks at full speed
*    T4 Exp bomber and t3 bombers
*      AggressiveMove
*      Reduced T4 bomber by 75% 
*      Reduced T4 bomber Hp to 43k
*  ReinforcemntDrop 
*    timetrigger with value to select wavetable
*  New Splats 
*    Hydro and Mex better visible now

---- Version 18 ----
*   02-10-2022
*  Game Options
*    Resources Settings
*      Default Resources
*      Extra Resources  
*      No Resources 
*  UnitsIdle 
*    GiveAgressiveMove Location error, Order was unit insted of location
*  WelcomeMessage
*    Broadcast Textmessage Income, Storage, BuildRate, BuildRange, UnitCost, Unit Restriction if active
*  Restrictions 
*    Mod Check "Are Units compareable to Vanilla Units"
*      IsMassFabricatorAllowed
*      IsEnergyFabricatorAllowed
*      IsMassStorageAllowed
*      IsEnergyStorageAllowed
*      IsParagonAllowed
*      IsShieldAllowed
*      IsUnitAllowed ( Currently only checks if unit has valid Tech Category )
*  SeraphimInvasion 
*    T4 bombers 
*      No Crash Damage
*      75% --> 25% chance of spawning
*    SpeedMultiplier
*      IntervalSpeedbuff 0.25 --> 0.125
*      SpeedMulti Land/navy max 2.5 --> 1.375x 
*      SpeedMulti Air 1.375 --> 1.1x
*    Unit Buffs
*      Increased Hp Buff 0.10 --> 0.12 
*      Hp Buff increase at wave 6 --> 2 
*    Spawn Interval 60 --> 100
*      Spawn Interval decrease 1 second each min --> 3 seconds each min
*      MinimalSpawnInterval 40 --> 30
*  SeraphimRifts
*    CreateRifts
*      Decreased Land Rifts Hp 5250000 --> 675000
*      Decreased Navy Rifts Hp 2625265 --> 325000
*      Increased SetHeatlh % Land Rifts 0.15% --> 0.65%
*      Increased SetHeatlh % Navy Rifts 0.15% --> 0.55%
*      Reduced RegenRate Land Rifts 2581 --> 300
*      Reduced RegenRate Navy Rifts 2581 --> 150
*    RiftCountThread
*      Rebuilding Destroyed Rifts each 60seconds --> if Counter > 15/(Dificulty*PlayerArmyCount)  
*      Rebuild 1 Rift Land or Navy. Picked by Random Number
*  Recall 
*    Ai not needed for Recall
*    Distance Dialogue for Acus that is needed to go to the recall zone
*    Marker above Acus that i needed for recall
*    Endless recall not working should be fixed
*    Added New message to winning game 
*  WelcomeMessage
*    ShowBriefing in a DialogueBox Right side of screen 

---- Version 19 ----
*   14-10-2022
*   ReinForcementDrop
*       Does a Alert Ping when Dropped units have bin given to player
*   AeonBoss
*       On Stage 2 Tractor Claws disabled
*       On Stage 2/3 
*       Added 2 Sacus in UpperArms
*       Added MovementThread now switches between AggresiveMove and Move order
*           When on move order eye cannon disabled
*   WelcomeMessage
*       Added Extra Units option to message
*       Added Extra Resources option to message
*       Added GameBreakers to message
*       Changed Position of Text and Brighter Color
*   EmergencyShield
*       Shield HP / Shield Max HP in Quantum Gate Beacon CustomName
*       Emergency Quantum Gate Beacon HP shows Shield Hp / Shield Max Hp
*       Added +50 Enegry production. Should fix E Shield depletion bug
*   Recall
*       Added End message when recalled 
*       Objectives showing Completed when recalled  
*       When recalled Summit objective set to complete should fix the failing when winning 
*   SeraphimRifts
*       Land and Navy Rift have Different Interval Checks for building new one if destroyed
*       Initial Rift Spawns decreased by RiftCount - (Playercount + 2) Now Rifts will build during the game. Should fix Game speed when Sera and Aeon are attacking together.
*   SeraphimInvasion / UnitBuffer 
*       Added Veterancy Check. Should fix script stop working when Sera t3 bomber spawns
*   UnitBuffer 
*       Shield Hp, Size Increases when Health Multipier Mod
*       Weapon Damge Mod, Range Mod and Fire Rate mod

---- Version 20 ----
*   Restrictions
*       Check for Buildrestrictions Succesfull or els Stop Game "To Counter the No buildrestriction Mods"
*   UnitBuffer
*       Fixed SetLifetime bugging out Lazor weapons. Should fix GC and Czar bugging out
*       Fixed Error for Czar Shield ImpactMesh "Czar has ImpactMeshBig!"
*       Fixed Set Veterancy "update for new Vet system"
*   SeraphimInvasion
*       Fixed Set Veterancy "update for new Vet system"
*   NukeEvent 
*       Fixed Deforming Land when Yolona's Spawning "Dont Spawn Buildings to close to Edge Map"

---- Version 21 ----
*   UnitBuffer
*       Updated Set Veterancy Level 
*   OrderBoss 
*       Fixed Boss not Getting full Vet
*       Made all the Modules into single lua files
*       All Module Units have own destroy thread "All units should now die when boss dies"
*       Thread for the mobile t3 arty 
*       More sams in torso Final Boss
*   Recall
*       Recall timer dialogue into Dialogue Message Box 

