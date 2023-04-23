-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local Utilities = import('/lua/utilities.lua')

local PlayDialogue = import(ScenarioInfo.MapPath .. 'Utilities/PlayDialogue.lua')
local DialogueList = import(ScenarioInfo.MapPath .. 'Resources/DialogueList.lua')

local LogStats = false

local RandomTime = Utilities.GetRandomInt(11.5 * 60, 13.0 * 60)

local Count = 1
local TableLaunchers = { }
local Army = "ARMY_ENEMY_AEON"



local AttackPositionTable = {
    ScenarioUtils.MarkerToPosition("nuketarget-1"),
    ScenarioUtils.MarkerToPosition("nuketarget-2"), 
    ScenarioUtils.MarkerToPosition("nuketarget-3")
}

function StartNukeEvent()
    ScenarioFramework.CreateTimerTrigger(LaunchNuke, RandomTime, false)
end

function LaunchNuke()
    for i = 1, 3 do
        local SpawnNukeLauncher = ScenarioUtils.MarkerToPosition("nuke-" .. i)

        local NukeLauncher = CreateUnitHPR( 'XSB2401', Army, SpawnNukeLauncher[1] , SpawnNukeLauncher[2], SpawnNukeLauncher[3] , 0, 0, 0)

        ForkThread(function()
            WaitSeconds(0.5)
            local NewPosition = VECTOR3(SpawnNukeLauncher[1] - 800, SpawnNukeLauncher[2] + 40, SpawnNukeLauncher[3] - 440)
            NukeLauncher:SetPosition(NewPosition, true)
        end)
        table.insert(TableLaunchers, NukeLauncher)
    end

    FireNuke(TableLaunchers)
    AdjustProjectile(TableLaunchers)

end


function AdjustProjectile(TableLaunchers)
    local CreateProjectileAtMuzzle = function(self, muzzle)


        local Projectile = self:CreateProjectileForWeapon(muzzle)

        local Target = Projectile:GetCurrentTargetPosition()

    
        Target = VECTOR3(Target[1] + 800, Target[2], Target[3] + 400)

        Projectile:SetNewTargetGround(Target)
        
        if not Projectile or Projectile:BeenDestroyed() then
            return Projectile
        end
        
        return Projectile
    end

    for k, Launcher in TableLaunchers do 
        local Weapon = Launcher:GetWeapon(1)
        Weapon.CreateProjectileAtMuzzle = CreateProjectileAtMuzzle
    end
    
end

function FireNuke(TableLaunchers)

    ForkThread(function()
        PlayDialogue.Dialogue(DialogueList.Gary_4, nil, false) -- ZanGoattheZeGary: [Language Not Recognized]
        WaitSeconds(1)

        for i, Launcher in TableLaunchers do
            if not Launcher:IsDead() then
                local AttackPosition1 = GetRandomPosition(AttackPositionTable)
                local AttackPosition2 = GetRandomPosition(AttackPositionTable)
                Launcher:GiveNukeSiloAmmo(1)
                IssueNuke({Launcher}, AttackPosition1)
                WaitSeconds(0.5)
                Launcher:GiveNukeSiloAmmo(1)
                IssueNuke({Launcher}, AttackPosition2)

            end     
        end 
        WaitSeconds(2)
        PlayDialogue.Dialogue(DialogueList.Entropy_14, nil, false) -- Entropy: Looks like that alien is launching a nuke. Flight trajectory indicates it's heading toward the town to the east. HQ out.
        WaitSeconds(20)
        IssueDestroySelf(TableLaunchers)
    end)
end

function GetRandomPosition(Positions)
    local n = table.getn(Positions)
    local i = math.floor(Random() * n) + 1
    return Positions[i]
end




function StartSecondNukeEvent()
    local RandomTimeSecondEvent = Utilities.GetRandomInt(5.5 * 60, 7.0 * 60)
    local CurrentTime = GetGameTimeSeconds()

    ScenarioFramework.CreateTimerTrigger(BuildNukeLauncher, 5 + 5, false)
end



function BuildNukeLauncher()
    local SecondLauncherTable = { }

    for i = 1, 3 do
        local SpawnNukeLauncher = ScenarioUtils.MarkerToPosition("nuke-" .. i)
        local NukeLauncher = CreateUnitHPR( 'XSB2401', Army, SpawnNukeLauncher[1], SpawnNukeLauncher[2], SpawnNukeLauncher[3] , 0, 0, 0)
        NukeLauncher:SetCanBeKilled(false)

        local NewPosition = VECTOR3(SpawnNukeLauncher[1] - 800, SpawnNukeLauncher[2], SpawnNukeLauncher[3] - 440)
        NukeLauncher:SetPosition(NewPosition, true)

        table.insert(SecondLauncherTable, NukeLauncher)
    end

    for i = 1, 3 do
        local SpawnNukeLauncher = ScenarioUtils.MarkerToPosition("nuke-" .. i)
        local NukeLauncher = CreateUnitHPR( 'XSB2305', Army, SpawnNukeLauncher[1], SpawnNukeLauncher[2], SpawnNukeLauncher[3], 0, 0, 0)
        NukeLauncher:SetCanBeKilled(false)

        local NewPosition = VECTOR3(SpawnNukeLauncher[1] - 810, SpawnNukeLauncher[2], SpawnNukeLauncher[3] - 450)
        NukeLauncher:SetPosition(NewPosition, true)

        table.insert(SecondLauncherTable, NukeLauncher)
    end


    FireNukeThread(SecondLauncherTable)
end

function FireNukeThread(SecondLauncherTable)
    
    local Counter = 0

    local DificultyMultiplier = ScenarioInfo.Options.Option_PlatoonWaveCount

    local NukeTempPosition = ScenarioUtils.MarkerToPosition("nuke-temp")
    local AttackPosition = ScenarioUtils.MarkerToPosition("defenceobject-1")

    local NukeLauncherTable = SecondLauncherTable
    local NukeLaunchersCount = table.getn(NukeLauncherTable)

    ForkThread(function()
        WaitSeconds(180)
        while true do 
            
            local RandomTime = Utilities.GetRandomInt(3.5 * 60, 4.5 * 60)   -- Min 210 Max 270
            local AddDifficulty = DificultyMultiplier * 5                   -- Difficulty Easy = 2.5 / Moderate = 5 / Hard = 15
            local RandomInterval = RandomTime - AddDifficulty - Counter     -- Counter = 0 / up to 180 
                                                                            -- Shortest time between nuke = 25/85 on Moderate

            if LogStats == true then
                LOG("NukeEvent: RandomIntervalSeconds: " .. repr(RandomInterval))
            end
            



            local WaitSecondsTillNextNuke = RandomInterval

            local RandomNumber = math.floor(Random() * NukeLaunchersCount) + 1


            local TheChosenOne = NukeLauncherTable[RandomNumber]
            TheChosenOne:GiveNukeSiloAmmo(1)

            local Direction = Random(1,4)

            local PickRandomOffset1 = Random(15,65)
            local PickRandomOffset2 = Random(15,65)

            if Direction == 1 then 
                RandomOffsetTarget = VECTOR3(   AttackPosition[1] + PickRandomOffset1, 
                                                AttackPosition[2], 
                                                AttackPosition[3] + PickRandomOffset2)

            end
            if Direction == 2 then 
                RandomOffsetTarget = VECTOR3(   AttackPosition[1] - PickRandomOffset1, 
                                                AttackPosition[2], 
                                                AttackPosition[3] - PickRandomOffset2)

            end
            if Direction == 3 then 
                RandomOffsetTarget = VECTOR3(   AttackPosition[1] + PickRandomOffset1, 
                                                AttackPosition[2], 
                                                AttackPosition[3] - PickRandomOffset2)

            end
            if Direction == 4 then 
                RandomOffsetTarget = VECTOR3(   AttackPosition[1] - PickRandomOffset1, 
                                                AttackPosition[2], 
                                                AttackPosition[3] + PickRandomOffset2)

            end

            local CacheMainPosition = TheChosenOne:GetPosition()
            
            TheChosenOne:SetPosition(NukeTempPosition, true)

            IssueNuke({TheChosenOne}, RandomOffsetTarget)

            WaitSeconds(1)
            TheChosenOne:SetPosition(CacheMainPosition, true)

            
            
            WaitSeconds(RandomInterval)


            if Counter <= 180 then
                Counter = Counter + 20
            end
        end
    end)
end