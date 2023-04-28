-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local Utilities = import('/lua/utilities.lua')
local GameSetup = import(ScenarioInfo.MapPath .. 'Functionality/GameSetup.lua')
local DialogueList = import(ScenarioInfo.MapPath .. 'Resources/DialogueList.lua')

local LegTransportShipT2 = import(ScenarioInfo.MapPath .. 'Events/Modules/GcBoss/LegTransportShipT2.lua')
local ArmTankT2 = import(ScenarioInfo.MapPath .. 'Events/Modules/GcBoss/ArmTankT2.lua')
local ArmSacu = import(ScenarioInfo.MapPath .. 'Events/Modules/GcBoss/ArmSacu.lua')
local TorsoMobileArtyT3 = import(ScenarioInfo.MapPath .. 'Events/Modules/GcBoss/TorsoMobileArtyT3.lua')
local TorsoAntiAirT3 = import(ScenarioInfo.MapPath .. 'Events/Modules/GcBoss/TorsoAntiAirT3.lua')
local ShoulderAntiAirT2Flak = import(ScenarioInfo.MapPath .. 'Events/Modules/GcBoss/ShoulderAntiAirT2Flak.lua')
local ShoulderNuke = import(ScenarioInfo.MapPath .. 'Events/Modules/GcBoss/ShoulderNuke.lua')
local HeadShieldDisruptor = import(ScenarioInfo.MapPath .. 'Events/Modules/GcBoss/HeadShieldDisruptor.lua')
local GreenShield = import(ScenarioInfo.MapPath .. 'Events/Modules/GcBoss/GreenShield.lua')

local BossThread = import(ScenarioInfo.MapPath .. 'Events/Modules/GcBoss/BossThread.lua')
local MovementThread = import(ScenarioInfo.MapPath .. 'Events/Modules/GcBoss/MovementThread.lua')
local ProtectionStormThread = import(ScenarioInfo.MapPath .. 'Events/Modules/GcBoss/ProtectionStormThread.lua')
local SpeedMultiplierThread = import(ScenarioInfo.MapPath .. 'Events/Modules/GcBoss/SpeedMultiplierThread.lua')

local CircularPointGenerator = import(ScenarioInfo.MapPath .. 'Utilities/CircularPointGenerator.lua')
local PlayDialogue = import(ScenarioInfo.MapPath .. 'Utilities/PlayDialogue.lua')
local Markers = import(ScenarioInfo.MapPath .. 'Utilities/Markers.lua')
local PlatoonOrders = import(ScenarioInfo.MapPath .. 'Utilities/PlatoonOrders.lua')
local UnitCreator = import(ScenarioInfo.MapPath .. 'Utilities/UnitCreator.lua')
local UnitBuffer = import(ScenarioInfo.MapPath .. 'Utilities/UnitBuffer.lua')
local VisibleArea = import(ScenarioInfo.MapPath .. 'Utilities/VisibleArea.lua')


BossDeath = 0

local PlayerArmies = GameSetup.PlayerArmies
local DificultyMultiplier = (ScenarioInfo.Options.Option_PlatoonWaveCount * 0.5)
local HealthMultiplier = ScenarioInfo.Options.Option_HealthMultiplier
local DamageMultiplier = ScenarioInfo.Options.Option_DamageMultiplier
local Scaling = 1
local Stage = 1 --[[Default = 1]]--

local FinalDestination = ScenarioUtils.MarkerToPosition('defenceobject-1')
local Location1 = Markers.GetRandomPosition(Markers.PathWay)
local Location2 = Markers.GetRandomPosition(Markers.PathWay)
local Location3 = Markers.GetRandomPosition(Markers.PathWay)
local Location4 = Markers.GetRandomPosition(Markers.PathWay)
local Location5 = Markers.GetRandomPosition(Markers.PathWay)
local Location6 = Markers.GetRandomPosition(Markers.PathWay)

local BuildTime = ScenarioInfo.Options.Option_BuildTime
local TimeSpawnBoss1 = Utilities.GetRandomInt(8.0 * 60, 9.0 * 60)
local TimeSpawnBoss2 = Utilities.GetRandomInt(15.5 * 60, 18.0 * 60)
local TimeSpawnBoss3 = Utilities.GetRandomInt(27.5 * 60, 28.0 * 60)

local SpawnLocation = Markers.GetRandomPosition(Markers.LandSpawn)
local UnitBp = 'ual0401'
local Army = "ARMY_ENEMY_ORDER_BOSS"

function LittleBehemoth()
 	ScenarioFramework.CreateTimerTrigger(SpawnBoss, BuildTime + TimeSpawnBoss1, false) -- TimeSpawnBoss1
	ScenarioFramework.CreateTimerTrigger(SpawnBoss, BuildTime + TimeSpawnBoss2, false) -- TimeSpawnBoss2
	ScenarioFramework.CreateTimerTrigger(SpawnBoss, BuildTime + TimeSpawnBoss3, false) -- TimeSpawnBoss3
end

function SpawnBoss() -- Main Unit
    SpawnLocation = Markers.GetRandomPosition(Markers.LandSpawn) -- Get new spawn location
    if Stage > 3 then 
        return
    end

	MainUnit = CreateUnitHPR(UnitBp, Army, SpawnLocation[1], SpawnLocation[2], SpawnLocation[3], 0, 0, 0)
	MainUnit:SetReclaimable(false)
	MainUnit:SetIntelRadius('Omni', 500)
	MainUnit:SetCustomName("For the Order")   
	MainUnit:SetSpeedMult(0.85)     
	MainUnit.ImmuneToStun = true

    IssueAggressiveMove({MainUnit}, Location1)
	IssueAggressiveMove({MainUnit}, Location2)
	IssueAggressiveMove({MainUnit}, Location3)
	IssueAggressiveMove({MainUnit}, Location4)
	IssueAggressiveMove({MainUnit}, Location5)
	IssueAggressiveMove({MainUnit}, Location6)
	IssueAggressiveMove({MainUnit}, FinalDestination)

    UnitBuffer.SetVetLevel(MainUnit, 5)
    VisibleArea.Create(20, MainUnit, 0, PlayerArmies)

	if Stage == 1 then
        SetupBossStage1(MainUnit)
	end
	if Stage == 2 then
        SetupBossStage2(MainUnit)
	end
	if Stage == 3 then
        SetupBossStage3(MainUnit)
	end
	Stage = Stage + 1
end

function SetupBossStage1(MainUnit)
    MainUnit:SetMaxHealth((20000 * HealthMultiplier) * DificultyMultiplier)
    MainUnit:SetHealth(nil, MainUnit:GetMaxHealth())
    MainUnit:SetRegen(5 * HealthMultiplier * DificultyMultiplier)
    MainUnit:SetAllWeaponsEnabled()
    LegTransportShipT2.CreateModule(Army, MainUnit, SpawnLocation, HealthMultiplier, DamageMultiplier, DificultyMultiplier, Stage)
    ArmTankT2.CreateModule(Army, MainUnit, SpawnLocation, HealthMultiplier, DamageMultiplier, DificultyMultiplier, Stage)
    ShoulderAntiAirT2Flak.CreateModule(Army, MainUnit, SpawnLocation, HealthMultiplier, DamageMultiplier, DificultyMultiplier, Stage)     
    GreenShield.CreateModule(Army, MainUnit, SpawnLocation, HealthMultiplier, DamageMultiplier, DificultyMultiplier, Stage)

    SpeedMultiplierThread.Initialize(MainUnit, FinalDestination, Location1, Location2, Location3, Location4, Location5, Location6)
    BossThread.Initialize(MainUnit, Stage)
end

function SetupBossStage2(MainUnit)
    MainUnit:SetMaxHealth((80000 * HealthMultiplier) * DificultyMultiplier)
    MainUnit:SetHealth(nil, MainUnit:GetMaxHealth())
    MainUnit:SetRegen(50 * HealthMultiplier * DificultyMultiplier)

    Weapon2 = MainUnit:GetWeapon(2) -- Vacuum Gun
    Weapon2:SetWeaponEnabled(false)
    Weapon3 = MainUnit:GetWeapon(3) -- Vacuum Gun
    Weapon3:SetWeaponEnabled(false)

    LegTransportShipT2.CreateModule(Army, MainUnit, SpawnLocation, HealthMultiplier, DamageMultiplier, DificultyMultiplier, Stage)
    ArmTankT2.CreateModule(Army, MainUnit, SpawnLocation, HealthMultiplier, DamageMultiplier, DificultyMultiplier, Stage)
    ArmSacu.CreateModule(Army, MainUnit, SpawnLocation, HealthMultiplier, DamageMultiplier, DificultyMultiplier, Stage)	
    ShoulderAntiAirT2Flak.CreateModule(Army, MainUnit, SpawnLocation, HealthMultiplier, DamageMultiplier, DificultyMultiplier, Stage)  
    HeadShieldDisruptor.CreateModule(Army, MainUnit, SpawnLocation, HealthMultiplier, DamageMultiplier, DificultyMultiplier, Stage)  

    MovementThread.Initialize(MainUnit, Stage, FinalDestination, Location1, Location2, Location3, Location4, Location5, Location6) 
    SpeedMultiplierThread.Initialize(MainUnit, FinalDestination, Location1, Location2, Location3, Location4, Location5, Location6)
    BossThread.Initialize(MainUnit, Stage)
end

function SetupBossStage3(MainUnit)
    MainUnit:SetMaxHealth((300000 * HealthMultiplier) * DificultyMultiplier)
    MainUnit:SetHealth(nil, MainUnit:GetMaxHealth())
    MainUnit:SetRegen(250 * HealthMultiplier * DificultyMultiplier)

    LegTransportShipT2.CreateModule(Army, MainUnit, SpawnLocation, HealthMultiplier, DamageMultiplier, DificultyMultiplier, Stage)
    ArmTankT2.CreateModule(Army, MainUnit, SpawnLocation, HealthMultiplier, DamageMultiplier, DificultyMultiplier, Stage)
    ArmSacu.CreateModule(Army, MainUnit, SpawnLocation, HealthMultiplier, DamageMultiplier, DificultyMultiplier, Stage)	
    TorsoMobileArtyT3.CreateModule(Army, MainUnit, SpawnLocation, HealthMultiplier, DamageMultiplier, DificultyMultiplier, Stage)	
    TorsoAntiAirT3.CreateModule(Army, MainUnit, SpawnLocation, HealthMultiplier, DamageMultiplier, DificultyMultiplier, Stage)
    ShoulderNuke.CreateModule(Army, MainUnit, SpawnLocation, HealthMultiplier, DamageMultiplier, DificultyMultiplier, Stage) 
    ShoulderAntiAirT2Flak.CreateModule(Army, MainUnit, SpawnLocation, HealthMultiplier, DamageMultiplier, DificultyMultiplier, Stage)  
    HeadShieldDisruptor.CreateModule(Army, MainUnit, SpawnLocation, HealthMultiplier, DamageMultiplier, DificultyMultiplier, Stage)  

    MovementThread.Initialize(MainUnit, Stage, FinalDestination, Location1, Location2, Location3, Location4, Location5, Location6) 
    SpeedMultiplierThread.Initialize(MainUnit, FinalDestination, Location1, Location2, Location3, Location4, Location5, Location6)
    ProtectionStormThread.Initialize(Army, MainUnit, HealthMultiplier, DamageMultiplier, DificultyMultiplier, Stage)
    BossThread.Initialize(MainUnit, Stage)

    if ScenarioInfo.Options.Option_PlatoonWaveCount == 3 then -- Extra Units if Difficulty is Hard
        ArmTankT2.CreateModule(Army, MainUnit, SpawnLocation, HealthMultiplier, DamageMultiplier, DificultyMultiplier, Stage)
        ArmSacu.CreateModule(Army, MainUnit, SpawnLocation, HealthMultiplier, DamageMultiplier, DificultyMultiplier, Stage)	
    end

    ForkThread(function()
        WaitSeconds(90)
        PlayDialogue.Dialogue(DialogueList.Gary_6, nil, false) -- ZanGoattheZeGary: Language Not Recognized
    end)
end