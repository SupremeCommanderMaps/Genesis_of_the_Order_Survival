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

local Recall = import(ScenarioInfo.MapPath .. 'Events/Recall.lua')

local Areas = import(ScenarioInfo.MapPath .. 'Utilities/Areas.lua')
local Markers = import(ScenarioInfo.MapPath .. 'Utilities/Markers.lua')
local PlayDialogue = import(ScenarioInfo.MapPath .. 'Utilities/PlayDialogue.lua')
local DialogueList = import(ScenarioInfo.MapPath .. 'Resources/DialogueList.lua')


local EnemyArmies = GameSetup.EnemyArmies
local PlayerArmies = GameSetup.PlayerArmies
local PlayerArmyCount = GameSetup.PlayerArmyCount

local DificultyMultiplier = ScenarioInfo.Options.Option_PlatoonWaveCount
local HealthMultiplier = ScenarioInfo.Options.Option_HealthMultiplier

--[[
GameState 
0 = Active
1 = End Event
]]--
GameState = 0


local SeraphimArmy = "ARMY_ENEMY_SERAPHIM"

local InitialLandRiftCount = 0 
local InitialNavyRiftCount = 0 




function CreateRifts()
    InitialLandRiftCount = 2 + GameSetup.PlayerArmyCount * (DificultyMultiplier * 2)
    InitialNavyRiftCount = 0 + GameSetup.PlayerArmyCount * (DificultyMultiplier * 2)

    for _ = 1, InitialLandRiftCount do
        CreateLandRift(1)
    end
    for _ = 1, InitialNavyRiftCount do
        CreateNavyRift(1)
    end

    RiftCountThread()
    ContinueslyVisualThread()
end


function CreateLandRift(ExtraHpMultiplier)
    ForkThread(
        function()
            WaitSeconds(6)
            

            local Position = Areas.GetRandomPositionInArea(Areas.SpawnLandRift)

            local InvisibleUnitId = 'ueb5102'
            local VisualEffect = CreateUnitHPR(InvisibleUnitId, SeraphimArmy, Position[1], Position[2], Position[3], 0, 0, 0)
            VisualEffect.CanBeKilled = false

            CreateVisibleAreaAtUnit(40, VisualEffect, 30, PlayerArmies)

            for _ = 1, 10 do
                VisualEffect:CreateProjectile('/effects/Entities/SIFInainoStrategicMissileEffect03/SIFInainoStrategicMissileEffect03_proj.bp', 0, 1.35, 0, nil, nil, nil):SetCollision(false)
                VisualEffect:CreateProjectile('/effects/Entities/SIFInainoStrategicMissileEffect03/SIFInainoStrategicMissileEffect03_proj.bp', 0, 1.35, 0, nil, nil, nil):SetCollision(false)
                WaitSeconds(2)

                VisualEffect:CreateProjectile('/effects/Entities/SIFExperimentalStrategicMissileEffect03/SIFExperimentalStrategicMissileEffect03_proj.bp', 0, 1.35, 0, nil, nil, nil):SetCollision(false)
            end
            for _ = 1, 4 do 
                VisualEffect:CreateProjectile('/effects/Entities/SIFExperimentalStrategicMissileEffect01/SIFExperimentalStrategicMissileEffect01_proj.bp', 0, 1.35, 0, nil, nil, nil):SetCollision(false)
                WaitSeconds(2)
            end

            KillUnit(VisualEffect)



            if GameState == 0 then 
                local LandRiftMainUnitId = 'xac1101'
                local LandRift = CreateUnitHPR(LandRiftMainUnitId, SeraphimArmy, Position[1], Position[2], Position[3], 0, 0, 0)
                LandRift:SetMaxHealth(675000 * DificultyMultiplier * HealthMultiplier * ExtraHpMultiplier)
                LandRift:SetHealth(nil, LandRift:GetMaxHealth() * 0.65)
                LandRift:SetRegenRate(300 * DificultyMultiplier * HealthMultiplier * ExtraHpMultiplier)
                LandRift.CanBeKilled = true
                LandRift:SetDoNotTarget(false)
                LandRift:SetReclaimable(false)
                LandRift:SetCapturable(false)
                LandRift:SetCanTakeDamage(true)
                LandRift:SetCustomName("Rift")       
                CreateVisibleAreaAtUnit(40, LandRift, 0, PlayerArmies)   
            end
        end)
end

function CreateNavyRift(ExtraHpMultiplier)
    ForkThread(
        function()
            WaitSeconds(6)

            local Position = Areas.GetRandomPositionInArea(Areas.SpawnNavyRift)

            local InvisibleUnitId = 'ueb5102'
            local VisualEffect = CreateUnitHPR(InvisibleUnitId, SeraphimArmy, Position[1], Position[2], Position[3], 0, 0, 0)
            VisualEffect.CanBeKilled = false

            CreateVisibleAreaAtUnit(40, VisualEffect, 30, PlayerArmies)

            for _ = 1, 10 do
                VisualEffect:CreateProjectile('/effects/Entities/SIFInainoStrategicMissileEffect03/SIFInainoStrategicMissileEffect03_proj.bp', 0, 1.35, 0, nil, nil, nil):SetCollision(false)
                VisualEffect:CreateProjectile('/effects/Entities/SIFInainoStrategicMissileEffect03/SIFInainoStrategicMissileEffect03_proj.bp', 0, 1.35, 0, nil, nil, nil):SetCollision(false)
                WaitSeconds(2)

                VisualEffect:CreateProjectile('/effects/Entities/SIFExperimentalStrategicMissileEffect03/SIFExperimentalStrategicMissileEffect03_proj.bp', 0, 1.35, 0, nil, nil, nil):SetCollision(false)
            end
            for _ = 1, 4 do 
                VisualEffect:CreateProjectile('/effects/Entities/SIFExperimentalStrategicMissileEffect03/SIFExperimentalStrategicMissileEffect03_proj.bp', 0, 1.35, 0, nil, nil, nil):SetCollision(false)
                WaitSeconds(2)
            end

            KillUnit(VisualEffect)

            if GameState == 0 then 
                local NavyRiftMainUnitId = 'xsc2201'
                local NavyRift = CreateUnitHPR(NavyRiftMainUnitId, SeraphimArmy, Position[1], Position[2], Position[3], 0, 0, 0)
                NavyRift:SetMaxHealth(325000 * DificultyMultiplier * HealthMultiplier * ExtraHpMultiplier)
                NavyRift:SetHealth(nil, NavyRift:GetMaxHealth() * 0.55)
                NavyRift:SetRegenRate(150 * DificultyMultiplier * HealthMultiplier * ExtraHpMultiplier)
                NavyRift.CanBeKilled = true
                NavyRift:SetDoNotTarget(false)
                NavyRift:SetReclaimable(false)
                NavyRift:SetCapturable(false)
                NavyRift:SetCanTakeDamage(true)
                NavyRift:SetCustomName("Rift")     
                CreateVisibleAreaAtUnit(40, NavyRift, 0, PlayerArmies)  
            end
        end)
end


function RiftCountThread()
    local ExtraHpMultiplier = 1.00
    local RiftCountThreadTickCounter = 0
    ForkThread(
        function()
            WaitSeconds(60) -- Wait or els more Rifts spawn in the start
            while true do 


                local CurrentLandRiftCount = GetCurrentLandRiftCount()     
                local CurrentNavyRiftCount = GetCurrentNavyRiftCount()  

                ExtraHpMultiplier = ExtraHpMultiplier + 0.05
   
                if ScenarioInfo.Options.Option_EndlessMode == 0 then 
                    if CurrentLandRiftCount + CurrentNavyRiftCount == 0 then
                            GameState = 1

                            PlayDialogue.Dialogue(DialogueList.Astrox_5, nil, false) --Astrox Hall: The Rift is sealed, and the Order is on the run. Sadly, there's no sign of Princess Burke, but we'll keep looking.
                            WaitSeconds(10)
                            PlayDialogue.Dialogue(DialogueList.Entropy_6, nil, false) --Entropy: All operational objectives have been completed. Begin preparations to recall. We're getting you off that rock. HQ out.
                            WaitSeconds(10) 
                            PlayDialogue.Dialogue(DialogueList.Gary_10, nil, false) --ZanGoattheZeGary: Soon there will be more of us than you can possibly ever hope to defeat.
                            WaitSeconds(10) 
                            local RecallNumber = 1-- Endless Recall
                            Recall.StartRecall(RecallNumber)

                        break
                    end
                end

                if RiftCountThreadTickCounter >= 15 / (DificultyMultiplier * GameSetup.PlayerArmyCount) then 
                    LOG("SeraphimRifts: We Got New Rift? " .. repr(RiftCountThreadTickCounter))
                    RandomNumber = Random(1,2)
                    if RandomNumber == 1 then 
                        if CurrentLandRiftCount < InitialLandRiftCount then
                            CreateLandRift(ExtraHpMultiplier)
                            RiftCountThreadTickCounter = 0
                        end 
                    else  
                        if CurrentNavyRiftCount < InitialNavyRiftCount then
                            CreateNavyRift(ExtraHpMultiplier)
                            RiftCountThreadTickCounter = 0
                        end 
                    end
                    if RandomNumber == 2 then 
                        if CurrentLandRiftCount < InitialLandRiftCount then
                            CreateNavyRift(ExtraHpMultiplier)
                            RiftCountThreadTickCounter = 0
                        end 
                    else  
                        if CurrentNavyRiftCount < InitialNavyRiftCount then
                            CreateLandRift(ExtraHpMultiplier)
                            RiftCountThreadTickCounter = 0
                        end 
                    end
                end
                LOG("SeraphimRifts: Check1 " .. repr(RiftCountThreadTickCounter))

                RiftCountThreadTickCounter = RiftCountThreadTickCounter + 1

                LOG("SeraphimRifts: Check2 " .. repr(RiftCountThreadTickCounter))

                WaitSeconds(60)      
            end
        end)
end

function ContinueslyVisualThread()
    ForkThread(
        function()
            while true do
                if GameState == 1 then
                    break
                end
                local CurrentLandRiftTable = GetCurrentLandRift()
                local CurrentNavyRiftTable = GetCurrentNavyRift()

                for i, LandRift in CurrentLandRiftTable do
                    if not LandRift.Dead then
                        local Position = LandRift:GetPosition()
                        local VisualEffect = CreateUnitHPR("opc2002", SeraphimArmy, Position[1], Position[2], Position[3], 0, 0, 0)
                        VisualEffect:SetCanTakeDamage(false)
                        VisualEffect.CanBeKilled = false
                        LandRift:CreateProjectile('/effects/Entities/SIFExperimentalStrategicMissileEffect05/SIFExperimentalStrategicMissileEffect05_proj.bp', 0, 1.00, 0, nil, nil, nil):SetCollision(false)
                        LandRift:CreateProjectile('/effects/Entities/SIFExperimentalStrategicMissileEffect04/SIFExperimentalStrategicMissileEffect04_proj.bp', 0, 3.50, 0, nil, nil, nil):SetCollision(false)
                        LandRift:CreateProjectile('/effects/Entities/SIFExperimentalStrategicMissileEffect05/SIFExperimentalStrategicMissileEffect05_proj.bp', 0, 1.50, 0, nil, nil, nil):SetCollision(false)
                        KillUnit(VisualEffect)
                    end
                end
                for i, NavyRift in CurrentNavyRiftTable do
                    if not NavyRift.Dead then
                        local Position = NavyRift:GetPosition()
                        local InvisibleUnitId = 'ueb5102'
                        local VisualEffect = CreateUnitHPR(InvisibleUnitId, SeraphimArmy, Position[1], Position[2], Position[3], 0, 0, 0)
                        VisualEffect.CanBeKilled= false
                        VisualEffect:CreateProjectile('/effects/entities/EffectProtonAmbient01/EffectProtonAmbient01_proj.bp', 0, -1.0, 0, nil, nil, nil):SetCollision(false)
                        VisualEffect:CreateProjectile('/effects/entities/EffectProtonAmbient01/EffectProtonAmbient01_proj.bp', 0, -1.0, 0, nil, nil, nil):SetCollision(false)
                        VisualEffect:CreateProjectile('/effects/entities/EffectProtonAmbient01/EffectProtonAmbient01_proj.bp', 0, -1.0, 0, nil, nil, nil):SetCollision(false)
                        VisualEffect:CreateProjectile('/effects/entities/EffectProtonAmbient01/EffectProtonAmbient01_proj.bp', 0, -1.0, 0, nil, nil, nil):SetCollision(false)
                        VisualEffect:CreateProjectile('/effects/Entities/SIFExperimentalStrategicMissileEffect05/SIFExperimentalStrategicMissileEffect05_proj.bp', 0, 0.01, 0, nil, nil, nil):SetCollision(false)
                        KillUnit(VisualEffect)
                    end
                end
                WaitSeconds(2)
            end
    end)
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

function KillUnit(Unit)
    ForkThread(
        function()
            WaitSeconds(2)
            Unit.CanBeKilled = true
            WaitSeconds(2)
            IssueDestroySelf({Unit})
        end)
end

function CreateVisibleAreaAtUnit(Radius, Unit, Duration, VisibleArmy)

    local VisibleAreaTable = { }

    for i, Army in VisibleArmy do 
        local VisibleArea = ScenarioFramework.CreateVisibleAreaAtUnit(Radius, Unit, Duration, GetArmyBrain(Army))
        VisibleArea:AttachBoneTo(-1, Unit, -1)
        table.insert(VisibleAreaTable, VisibleArea)
    end

    Unit.OldOnKilled = Unit.OnKilled

    Unit.OnKilled = function(self, instigator, type, overkillRatio)

        for x, VisibleArea in VisibleAreaTable do 
            VisibleArea:Destroy()
        end

        self.OldOnKilled(self, instigator, type, overkillRatio)
    end
end


