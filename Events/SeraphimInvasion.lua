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

local CircularPointGenerator = import(ScenarioInfo.MapPath .. 'Utilities/CircularPointGenerator.lua')
local Markers = import(ScenarioInfo.MapPath .. 'Utilities/Markers.lua')
local PlatoonOrders = import(ScenarioInfo.MapPath .. 'Utilities/PlatoonOrders.lua')
local UnitCreator = import(ScenarioInfo.MapPath .. 'Utilities/UnitCreator.lua')
local PlayDialogue = import(ScenarioInfo.MapPath .. 'Utilities/PlayDialogue.lua')

local DialogueList = import(ScenarioInfo.MapPath .. 'Resources/DialogueList.lua')

local SeraphimWaveTablesEnemyAir = import(ScenarioInfo.MapPath .. 'Tables/SeraphimWaveTablesEnemyAir.lua')
local SeraphimWaveTablesEnemyLand = import(ScenarioInfo.MapPath .. 'Tables/SeraphimWaveTablesEnemyLand.lua')
local SeraphimWaveTablesEnemyNavy = import(ScenarioInfo.MapPath .. 'Tables/SeraphimWaveTablesEnemyNavy.lua')

local SeraphimArmy = "ARMY_ENEMY_SERAPHIM"

local DificultyMultiplier = ScenarioInfo.Options.Option_PlatoonWaveCount

local EnemyArmies = GameSetup.EnemyArmies
local PlayerArmies = GameSetup.PlayerArmies

local LogStats = false


MaxAirWaveCount = table.getn(SeraphimWaveTablesEnemyAir.Tables)
MaxLandWaveCount = table.getn(SeraphimWaveTablesEnemyLand.Tables)
MaxNavyWaveCount = table.getn(SeraphimWaveTablesEnemyNavy.Tables)

function StartInvasionThread()
    local Counter = 0
    local UpdateStage = 10

    local SpeedMultiplier = 1
    local ExtraHpMultiplier = 1

    local WaveTableAir = SeraphimWaveTablesEnemyAir.Tables
    local WaveTableLand = SeraphimWaveTablesEnemyLand.Tables
    local WaveTableNavy = SeraphimWaveTablesEnemyNavy.Tables

    local FinalDestination = ScenarioUtils.MarkerToPosition('defenceobject-1')

    local CircleRadius = 10
    local MinimalSpawnInterval = 30
    local SpawnInterval = 100

    local LandRifAirWaveCount = 1
    local LandRifLandWaveCount = 1

    local NavyRifAirWaveCount = 1
    local NavyRifNavyWaveCount = 1

    local LandWaveCount = 1
    local NavyWaveCount = 1
    

    ForkThread(function()
        while true do 
            local UnitCountPerRift = Random(0,1) + DificultyMultiplier

            local CurrentLandRiftCount = GetCurrentLandRiftCount()
            local CurrentNavyRiftCount = GetCurrentNavyRiftCount()

            local CurrentLandRiftTable = GetCurrentLandRift()
            local CurrentNavyRiftTable = GetCurrentNavyRift()

            for i, LandRift in CurrentLandRiftTable do
                if not LandRift.Dead then
                    local SpawnLocation = LandRift:GetPosition()

                    local WaveLayerAir = 'Air'     

                    local OrderIdAir = WaveTableAir[LandRifAirWaveCount].OrderId
                    local FormationAir = WaveTableAir[LandRifAirWaveCount].Formation
                    local UnitTableDataAir = WaveTableAir[LandRifAirWaveCount].UnitIds

                    local OrderIdLand = WaveTableLand[LandRifLandWaveCount].OrderId
                    local FormationLand = WaveTableLand[LandRifLandWaveCount].Formation
                    local UnitTableDataLand = WaveTableLand[LandRifLandWaveCount].UnitIds

                    CreateAirWave(ExtraHpMultiplier, SpeedMultiplier, LandRifAirWaveCount, FinalDestination, CircleRadius, SpawnLocation, UnitCountPerRift, OrderIdAir, FormationAir, UnitTableDataAir, WaveLayerAir)
                    CreateLandWave(ExtraHpMultiplier, SpeedMultiplier, LandRifLandWaveCount, FinalDestination, CircleRadius, SpawnLocation, UnitCountPerRift, OrderIdLand, FormationLand, UnitTableDataLand, WaveLayerAir)
                end
                if i == CurrentLandRiftCount then
                    -- set back a couple of waves
                    if LandRifAirWaveCount >= MaxAirWaveCount then
                        LandRifAirWaveCount = LandRifAirWaveCount - 7
                    end
                    -- if not max then next wave
                    if LandRifAirWaveCount < MaxAirWaveCount then
                        LandRifAirWaveCount = LandRifAirWaveCount + 1
                    end

                    -- set back a couple of waves
                    if LandRifLandWaveCount >= MaxLandWaveCount then
                        LandRifLandWaveCount = LandRifLandWaveCount - 4
                    end
                    -- if not max then next wave
                    if LandRifLandWaveCount < MaxLandWaveCount then
                        LandRifLandWaveCount = LandRifLandWaveCount + 1
                    end
                end
            end

            for i, NavyRift in CurrentNavyRiftTable do
                if not NavyRift.Dead then
                    local SpawnLocation = NavyRift:GetPosition()

                    local WaveLayerAir = 'Air'     

                    local OrderIdAir = WaveTableAir[NavyRifAirWaveCount].OrderId
                    local FormationAir = WaveTableAir[NavyRifAirWaveCount].Formation
                    local UnitTableDataAir = WaveTableAir[NavyRifAirWaveCount].UnitIds

                    local OrderIdNavy = WaveTableNavy[NavyRifNavyWaveCount].OrderId
                    local FormationNavy = WaveTableNavy[NavyRifNavyWaveCount].Formation
                    local UnitTableDataNavy = WaveTableNavy[NavyRifNavyWaveCount].UnitIds

                    CreateAirWave(ExtraHpMultiplier, SpeedMultiplier, NavyRifAirWaveCount, FinalDestination, CircleRadius, SpawnLocation, UnitCountPerRift, OrderIdAir, FormationAir, UnitTableDataAir, WaveLayerAir)
                    CreateNavyWave(ExtraHpMultiplier, SpeedMultiplier, NavyRifNavyWaveCount, FinalDestination, CircleRadius, SpawnLocation, UnitCountPerRift, OrderIdNavy, FormationNavy, UnitTableDataNavy, WaveLayerAir)
                end
                if i == CurrentNavyRiftCount then
                    -- set back a couple of waves
                    if NavyRifAirWaveCount >= MaxAirWaveCount then
                        NavyRifAirWaveCount = NavyRifAirWaveCount - 7
                    end
                    -- if not max then next wave
                    if NavyRifAirWaveCount < MaxAirWaveCount then
                        NavyRifAirWaveCount = NavyRifAirWaveCount + 1
                    end

                    -- set back a couple of waves
                    if NavyRifNavyWaveCount >= MaxNavyWaveCount then
                        NavyRifNavyWaveCount = NavyRifNavyWaveCount - 3
                    end               
                    -- if not max then next wave
                    if NavyRifNavyWaveCount < MaxNavyWaveCount then
                        NavyRifNavyWaveCount = NavyRifNavyWaveCount + 1
                    end
                end
            end


            if Counter >= UpdateStage then
                if SpeedMultiplier < 1.374 then
                    SpeedMultiplier = SpeedMultiplier + 0.125
                    UpdateStage = UpdateStage * 1.25
                    if LogStats == true then
                        LOG("SeraphimInvasion: SpeedMultiplier:" .. repr(SpeedMultiplier))
                    end
                end
            end

            if SpawnInterval >= MinimalSpawnInterval then
                SpawnInterval = SpawnInterval - 3 
                if LogStats == true then
                    LOG("SeraphimInvasion: SpawnInterval:" .. repr(SpawnInterval))
                end
            end
            
            if Counter > 2 then
                ExtraHpMultiplier = ExtraHpMultiplier + 0.12
                if LogStats == true then
                    LOG("SeraphimInvasion: ExtraHpMultiplier:" .. repr(ExtraHpMultiplier))
                end
            end

            if Counter == 7 then
                -- Astrox Hall: The Seraphim are pouring through the Rift at an alarming rate. There is no stopping them. We are doomed.'
                PlayDialogue.Dialogue(DialogueList.Astrox_3, nil, false)
            end

            if Counter == 16 then
                -- ZanGoattheZeGary: Do not fret. Dying by my hand is the supreme honor.
                PlayDialogue.Dialogue(DialogueList.Gary_9, nil, false)
                -- Entropy: Shut that damn alien up, Commander. Preferably with a nuke. HQ out.
                PlayDialogue.Dialogue(DialogueList.Entropy_8, nil, false)
            end

            Counter = Counter + 1 

            if LogStats == true then
                LOG("SeraphimInvasion: Counter:" .. repr(Counter))
            end

            WaitSeconds(SpawnInterval)
        end
    end)
end

function CreateAirWave(ExtraHpMultiplier, SpeedMultiplier, WaveCount, FinalDestination, CircleRadius, SpawnLocation, UnitCountPerRift, OrderIdAir, FormationAir, UnitTableDataAir, WaveLayerAir)
    local AttackLocation = Markers.GetRandomPosition(Markers.PathWay) 
    local Location1 = Markers.GetRandomPosition(Markers.PathWayAir)
    local Location2 = Markers.GetRandomPosition(Markers.PathWayAir)
    local Location3 = Markers.GetRandomPosition(Markers.PathWayAir)
    local Location4 = Markers.GetRandomPosition(Markers.PathWayAir)
    local Location5 = Markers.GetRandomPosition(Markers.PathWayAir)
    local Location6 = Markers.GetRandomPosition(Markers.PathWayAir)

    local AirUnits = { }
    local VectorPoints = CircularPointGenerator.CircularPointGenerator(UnitCountPerRift, CircleRadius, SpawnLocation)
    for Point = 1, UnitCountPerRift do
        for k, UnitBlueprint in UnitTableDataAir do 
            local Unit = UnitCreator.CreateUnit(UnitBlueprint, SeraphimArmy, VectorPoints[Point])
            Unit:SetCustomName(WaveCount)
            Unit:SetSpeedMult(SpeedMultiplier * 0.80)
            Unit:SetAccMult(SpeedMultiplier * 0.80)            
            Unit:SetTurnMult(SpeedMultiplier * 0.80)
            if ExtraHpMultiplier > 1 then
                local Hp = Unit:GetMaxHealth()
                Unit:SetVeterancy(1)
                Unit:SetVeterancy(1)
                Unit:SetVeterancy(1)
                Unit:SetVeterancy(1)
                Unit:SetVeterancy(1)
                Unit:SetMaxHealth(Hp * ExtraHpMultiplier)
                Unit:SetHealth(nil, (Hp * ExtraHpMultiplier))
            end
            local UnitID = Unit:GetUnitId()
            if UnitID == "xsa0402" then -- Sera t4 exp bomber 
                RandomValue = Random(1,4) 
                if RandomValue == 1 then 
                    local CurrentHp = Unit:GetMaxHealth()
                    Unit:SetMaxHealth(CurrentHp * 0.20)
                    Unit:SetHealth(nil, (CurrentHp * 0.20))

                    Unit.OnKilled = function(self, instigator, type, overkillRatio) -- Turns off CrashDamage for t4 bomber leaves no wreck on land 
                        ForkThread(function()
                            WaitSeconds(3.5) -- Wait or els it just drops to ground where its bin killed
                            if not IsDestroyed(self) then 
                                self:ForkThread(self.DeathThread, overkillRatio , instigator) -- Start DeathThread or bomber wont sink in water
                            end
                        end)
                    end
                else
                IssueDestroySelf({Unit}) -- reduce the amount of t4 bombers
                end
            end
            table.insert(AirUnits, Unit)
        end
    end

    PlatoonOrders.GiveOrderAir(
        SeraphimArmy, WaveLayerAir, OrderIdAir, AirUnits, 
        SpawnLocation, AttackLocation, FinalDestination, 
        Location1, Location2, Location3, Location4, Location5, Location6, 
        FormationAir, 0)

end

function CreateLandWave(ExtraHpMultiplier, SpeedMultiplier, WaveCount, FinalDestination, CircleRadius, SpawnLocation, UnitCountPerRift, OrderIdLand, FormationLand, UnitTableDataLand, WaveLayerAir)
    local AttackLocation = Markers.GetRandomPosition(Markers.PathWay) 
    local Location1 = Markers.GetRandomPosition(Markers.PathWay)
    local Location2 = Markers.GetRandomPosition(Markers.PathWay)
    local Location3 = Markers.GetRandomPosition(Markers.PathWay)
    local Location4 = Markers.GetRandomPosition(Markers.PathWay)
    local Location5 = Markers.GetRandomPosition(Markers.PathWay)
    local Location6 = Markers.GetRandomPosition(Markers.PathWay)

    local LandUnits = { }
    local VectorPoints = CircularPointGenerator.CircularPointGenerator(UnitCountPerRift, CircleRadius, SpawnLocation)
    for Point = 1, UnitCountPerRift do
        for k, UnitBlueprint in UnitTableDataLand do 
            local Unit = UnitCreator.CreateUnit(UnitBlueprint, SeraphimArmy, VectorPoints[Point])
            Unit:SetCustomName(WaveCount)
            Unit:SetSpeedMult(SpeedMultiplier)
            Unit:SetAccMult(SpeedMultiplier)
            Unit:SetTurnMult(SpeedMultiplier)
            if ExtraHpMultiplier > 1 then
                local Hp = Unit:GetMaxHealth()
                Unit:SetVeterancy(1)
                Unit:SetVeterancy(1)
                Unit:SetVeterancy(1)
                Unit:SetVeterancy(1)
                Unit:SetVeterancy(1)
                Unit:SetMaxHealth(Hp * ExtraHpMultiplier)
                Unit:SetHealth(nil, (Hp * ExtraHpMultiplier))
            end
            table.insert(LandUnits, Unit)
        end
    end

    PlatoonOrders.GiveOrderLand(
        SeraphimArmy, WaveLayerAir, OrderIdLand, LandUnits, 
        SpawnLocation, AttackLocation, FinalDestination, 
        Location1, Location2, Location3, Location4, Location5, Location6, 
        FormationLand, 0)
end

function CreateNavyWave(ExtraHpMultiplier, SpeedMultiplier, WaveCount, FinalDestination, CircleRadius, SpawnLocation, UnitCountPerRift, OrderIdNavy, FormationNavy, UnitTableDataNavy, WaveLayerAir)
    local AttackLocation = Markers.GetRandomPosition(Markers.PathWay) 
    local Location1 = Markers.GetRandomPosition(Markers.PathWayNavy)
    local Location2 = Markers.GetRandomPosition(Markers.PathWayNavy)
    local Location3 = Markers.GetRandomPosition(Markers.PathWayNavy)
    local Location4 = Markers.GetRandomPosition(Markers.PathWayNavy)
    local Location5 = Markers.GetRandomPosition(Markers.PathWayNavy)
    local Location6 = Markers.GetRandomPosition(Markers.PathWayNavy)

    local NavyUnits = { }
    local VectorPoints = CircularPointGenerator.CircularPointGenerator(UnitCountPerRift, CircleRadius, SpawnLocation)
    for Point = 1, UnitCountPerRift do
        for k, UnitBlueprint in UnitTableDataNavy do 
            local Unit = UnitCreator.CreateUnit(UnitBlueprint, SeraphimArmy, VectorPoints[Point])
            Unit:SetCustomName(WaveCount) 

            Unit:SetSpeedMult(SpeedMultiplier)    
         
            Unit:SetAccMult(SpeedMultiplier)
            Unit:SetTurnMult(SpeedMultiplier)
            if ExtraHpMultiplier > 1 then
                local Hp = Unit:GetMaxHealth()
                Unit:SetVeterancy(1)
                Unit:SetVeterancy(1)
                Unit:SetVeterancy(1)
                Unit:SetVeterancy(1)
                Unit:SetVeterancy(1)
                Unit:SetMaxHealth(Hp * ExtraHpMultiplier)
                Unit:SetHealth(nil, (Hp * ExtraHpMultiplier))
            end
            table.insert(NavyUnits, Unit)
        end
    end

    PlatoonOrders.GiveOrderNavy(
        SeraphimArmy, WaveLayerAir, OrderIdNavy, NavyUnits, 
        SpawnLocation, AttackLocation, FinalDestination, 
        Location1, Location2, Location3, Location4, Location5, Location6, 
        FormationNavy, 0)
end


function GetCurrentLandRiftCount()
    local LandRifts = GetArmyBrain(SeraphimArmy):GetListOfUnits(categories.xac1101, false)
    local Count = table.getn(LandRifts)
    return Count
end

function GetCurrentNavyRiftCount()
    local NavyRifts = GetArmyBrain(SeraphimArmy):GetListOfUnits(categories.xsc2201, false)
    local Count = table.getn(NavyRifts)
    return Count
end

function GetCurrentLandRift()
    local LandRifts = GetArmyBrain(SeraphimArmy):GetListOfUnits(categories.xac1101, false)
    return LandRifts
end

function GetCurrentNavyRift()
    local NavyRifts = GetArmyBrain(SeraphimArmy):GetListOfUnits(categories.xsc2201, false)
    return NavyRifts
end