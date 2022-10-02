-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local Utilities = import('/lua/utilities.lua')

local AeonBoss = import(ScenarioInfo.MapPath .. 'Events/AeonBoss.lua')
local NukeEvent = import(ScenarioInfo.MapPath .. 'Events/NukeEvent.lua')
local Recall = import(ScenarioInfo.MapPath .. 'Events/Recall.lua')
local SeraphimRifts = import(ScenarioInfo.MapPath .. 'Events/SeraphimRifts.lua')
local SeraphimInvasion = import(ScenarioInfo.MapPath .. 'Events/SeraphimInvasion.lua')

local GameSetup = import(ScenarioInfo.MapPath .. 'Functionality/GameSetup.lua')

local BroadcastMsg = import(ScenarioInfo.MapPath .. 'Utilities/BroadcastMsg.lua')
local CircularPointGenerator = import(ScenarioInfo.MapPath .. 'Utilities/CircularPointGenerator.lua')
local PlayDialogue = import(ScenarioInfo.MapPath .. 'Utilities/PlayDialogue.lua')

local DialogueList = import(ScenarioInfo.MapPath .. 'Resources/DialogueList.lua')


local PlayerArmies = GameSetup.PlayerArmies
local EnemyArmies = GameSetup.EnemyArmies

local FirstRecall = false
local FinalRecallActive = false
local StartSeraWaves = false

function DoOrDoNotThereIsNoTry()
    ForkThread(function()
        while true do 
            local AeonBossStatus = AeonBoss.BossDeath
            local RecallState = Recall.RecallState

            -- Start First Recall
            if AeonBossStatus == 1 then --[[Default = 1]]--  0 = Do nothing / when 1 = Start Recall
                if FirstRecall == false then 
                    WaitSeconds(10)
                    --Entropy: All operational objectives have been completed. Begin preparations to recall. We're getting you off that rock. HQ out.
                    PlayDialogue.Dialogue(DialogueList.Entropy_6, nil, false) 
                    WaitSeconds(10)
                    -- Entropy: Commander, stay within the area of your base. If you stray too far, we won\'t be able to get a recall lock. HQ out.
                    PlayDialogue.Dialogue(DialogueList.Entropy_7, nil, false)
                    local RecallNumber = 0
                    Recall.StartRecall(RecallNumber)
                    FirstRecall = true
                end
            end

            -- Start Seraphim Attack.
            if RecallState == 1 then --[[Default = 1]]--  0 = Do nothing / when 1 = Start  
                if StartSeraWaves == false then 
                    SeraphimRifts.CreateRifts()
                    SeraphimInvasion.StartInvasionThread()
                    NukeEvent.StartSecondNukeEvent()
                    StartSeraWaves = true
                    InitializeRecall()
                    break
                end
            end
            WaitSeconds(1)
        end
    end)
end

RecallActive = false

function InitializeRecall()
    local Count = 1
    local MaxOptionalRecall = 99999
    local Interval1 = 10 * 60 -- Default = 10 min


    ForkThread(function()
        WaitSeconds(Interval1)
        BroadcastMsg.TextMsg(string.rep(" ", 35) .. "Survived Round: " .. Count, 30, 'e80a0a', 5, 'leftcenter')
        while true do 
            local Interval2 = 10 * 60 -- Default = 10 min
            local SeraAttackState = SeraphimRifts.GameState
            if SeraAttackState == 1 then
                -- If all rifts are killed a recall is olready activated  
                break
            end

            if Count < MaxOptionalRecall then
                if RecallActive == false then
                    RecallActive = true
                    local RecallNumber = 0 -- Optional Recall
                    Recall.StartRecall(RecallNumber)
                    Count = Count + 1
                    RecallInterval(Interval2, Count)
                    
                end
            end

            if Count >= MaxOptionalRecall then
                if RecallActive == false then
                    RecallActive = true
                    local RecallNumber = 1 -- Endless Recall
                    Recall.StartRecall(RecallNumber)
                    break
                end
            end    
            WaitSeconds(5)
        end
    end)
end

function RecallInterval(Interval, Count)
    ForkThread(function()
        WaitSeconds(Interval)
        RecallActive = false
        BroadcastMsg.TextMsg(string.rep(" ", 35) .. "Survived Stage: " .. Count, 30, 'e80a0a', 5, 'leftcenter')
    end)
end






