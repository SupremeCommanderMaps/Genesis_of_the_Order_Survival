-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local Objectives = import('/lua/ScenarioFramework.lua').Objectives
local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local Utilities = import('/lua/utilities.lua')

local Statistics = import(ScenarioInfo.MapPath .. 'Events/Statistics.lua')

local GameSetup = import(ScenarioInfo.MapPath .. 'Functionality/GameSetup.lua')

local BroadcastMsg = import(ScenarioInfo.MapPath .. 'Utilities/BroadcastMsg.lua')
local CircularPointGenerator = import(ScenarioInfo.MapPath .. 'Utilities/CircularPointGenerator.lua')
local PingMarker = import(ScenarioInfo.MapPath .. 'Utilities/PingMarker.lua')
local PlayDialogue = import(ScenarioInfo.MapPath .. 'Utilities/PlayDialogue.lua')

local DialogueList = import(ScenarioInfo.MapPath .. 'Resources/DialogueList.lua')

-- RecallState 
-- 0 = Do nothing 
-- 1 = Next Stage 
-- 2 = Player Victory 

RecallState = 0
RecallActive = false

local EnemyArmies = GameSetup.EnemyArmies
local PlayerArmies = GameSetup.PlayerArmies

local InsideRecall = { }


local FirstRecallDialog = true

-- RecallNumber to chose which thread should start
-- 0 = Recall
-- 1 = Endless recall

function StartRecall(RecallNumber)
    ForkThread(function()
        while true do 
            if RecallActive == false then
                RecallActive = true
                -- Reset Value's
                RecallStop = 0
                RecallState = 0

                    local RecallPosition = ScenarioUtils.MarkerToPosition('recallposition-1')
                local RecallDistance = 12
                local RecallBeacons = 16

                    --Spanws beacons
                SpawnBeaconsThread(RecallPosition, RecallDistance, RecallBeacons, RecallNumber)
                -- Which Commanders are alive and where
                ForkThread(PlayerLocationThread, RecallPosition, RecallDistance, PlayerArmies)
                -- Recall
                ForkThread(RecallThread, PlayerArmies, RecallNumber) 
                break
            end
            WaitSeconds(1)
        end
    end)
end

function SpawnBeaconsThread(RecallPosition, RecallDistance, RecallBeacons, RecallNumber)

    local DialogueCount = 0

    local Army = "ARMY_ALLY_UEF"
    local ArmyNumber = table.getn(ListArmies()) - 4
    local UnitTable = {'ueb5103'}
    local Count = 0
    local MaxCount = 20
    local CenterUnit = CreateUnitHPR('ueb5102', Army, RecallPosition[1], RecallPosition[2], RecallPosition[3], 0, 0, 0)
    CenterUnit.CanBeKilled = false

    
    local DecalTexture = (ScenarioInfo.MapPath .. '/Resources/textures/markers/beacon-quantum-gate_btn_up.dds')
    if RecallNumber == 0 then
        CreateDecal(RecallPosition, 0, DecalTexture, '', 'Albedo', 28, 28, 10000, 70, Army, 0) 
    end    
    if RecallNumber == 1 then
        CreateDecal(RecallPosition, 0, DecalTexture, '', 'Albedo', 28, 28, 10000, 0, Army, 0) 
    end

    PingMarker.getAlertMarkerLong(RecallPosition, ArmyNumber)

    ForkThread(
        function()
            while true do 

                -- make beacons over and over for visual effect
                if Count <= MaxCount then
                    local Beacons = CircularPointGenerator.CircularSpawner(UnitTable, Army, RecallBeacons, RecallDistance, RecallPosition)
                end
              
                local Beacons = GetArmyBrain(Army):GetListOfUnits(categories.ueb5103 , false, false)

                for i, Beacon in Beacons do
                    Beacon:SetDoNotTarget(true)
                    Beacon.CanBeKilled = false
                end  

                -- visual for center of recall
                if RecallState == 0 then
                    if not CenterUnit.Dead then
                        CenterUnit:CreateProjectile('/effects/entities/UnitTeleport01/UnitTeleport01_proj.bp', 0, 1.35, 0, nil, nil, nil):SetCollision(false)
                        WaitSeconds(1.5)
                        CenterUnit:CreateProjectile('/effects/entities/UnitTeleport01/UnitTeleport01_proj.bp', 0, 1.35, 0, nil, nil, nil):SetCollision(false)

                    end
                end

                -- if recallstop then kill all
                if RecallStop == 1 then
                    if RecallNumber == 0 then
                        CenterUnit.CanBeKilled = true
                        for i, Beacon in Beacons do
                            Beacon:SetDoNotTarget(false)
                            Beacon.CanBeKilled = true
                        end    
                        WaitSeconds(1)
                        -- kill all units
                        IssueDestroySelf(Beacons)
                        IssueDestroySelf(CenterUnit)
                        -- spawn 1 more beacon 
                        local Beacons = CircularPointGenerator.CircularSpawner(UnitTable, Army, RecallBeacons, RecallDistance, RecallPosition)
                        WaitSeconds(4)
                        local Beacons = GetArmyBrain(Army):GetListOfUnits(categories.ueb5103 , false, false)

           
                        
                        IssueKillSelf(Beacons)
                        if DialogueCount == 0 then
                            if RecallState < 2 then
                                PlayDialogue.Dialogue(DialogueList.Astrox_4, nil, false) --Astrox Hall: Do whatever it takes to survive, Commander. We can't afford to lose you, too. Hall out.
                            end
                        end
                        DialogueCount = DialogueCount + 1 
                        break
                    end
                end


                Count = Count + 1
                
                -- if beacon count is higher then max then destroy
                if Count == MaxCount then
                    IssueDestroySelf(Beacons)
                    -- spawn 1 more beacon 
                    local Beacons = CircularPointGenerator.CircularSpawner(UnitTable, Army, RecallBeacons, RecallDistance, RecallPosition)
                end

                
                if RecallStop == 1 then 
                    break
                end
                WaitSeconds(5)
            end
        end)
end

function RecallThread(PlayerArmies, RecallNumber)
    local AllPlayersInsideRecall = false
    local RecallTimer = 10
    local CountDownTimer = 60
    
    if FirstRecallDialog == false then--[[All Recall Dialog]]--
        Dialog = {
            {displayTime = 80, text =
            "All Main Commanders to Recall Zone.\n\n\n\nThis is a OPTIONAL recall.\n Next recall is in 10 minutes",}
        }
    end    
    if FirstRecallDialog == true then --[[First time Dialog]]--
        Dialog = {
            {displayTime = 80, text =
            "All Main Commanders to Recall Zone. \nSeraphim invasion is imminent!!!\n\n\nThis is a OPTIONAL recall.\n Next recall is in 10 minutes",}
        }
        FirstRecallDialog = false
    end

    if RecallNumber == 1 then --[[When All Seraphim Rifts are killed Dialog]]--
        Dialog = {
            {displayTime = 900, text =
            "\n\n\n\n\n\n\n",}
        }
        BroadcastMsg.DisplayDialogBox("right", Dialog, false)
        Dialog = {
            {displayTime = 900, text =
            "It seems like all Rifts are sealed. \n\nYou can recall safely now.\n\nBut I am afraid we haven't seen the last of ZanGoattheZeGary!!. \n\n",}
        }
    end

    BroadcastMsg.DisplayDialogBox("right", Dialog, false)
    
    if RecallNumber ~= 1 then 
        BroadcastMsg.TextMsg(string.rep(" ", 29) .. "Game will continue in: ", 45, 'e80a0a', 75, 'lefttop')
    end



    while true do 
        -- All Commanders inside recallarea start recall timer
        if CheckAll(InsideRecall) == true then
            if RecallTimer >= 0 then
                BroadcastMsg.TextMsg("Recall in: " .. RecallTimer .. string.rep(" ", 200), 30, 'e80a0a', 0.29, 'center')
            end
            RecallTimer = RecallTimer - 1
            if CountDownTimer == 0 then
                CountDownTimer = CountDownTimer + 1
            end
        -- When false reset recall timer    
        else
            RecallTimer = 10
        end

        -- If timer = 0 then Players win
        if RecallTimer == - 1 then
            
            VictoryWooopWooop()             
            
            -- Update Status to Player Victory
            RecallStop = 1
            RecallState = 2
            break
        end

        -- Text and Timer for Optional Recall
        if RecallNumber == 0 then
            BroadcastMsg.TextMsg(string.rep(" ", 45) , 20, 'e80a0a', 0.5, 'lefttop')
            BroadcastMsg.TextMsg(string.rep(" ", 40) .. "" .. CountDownTimer, 50, 'e80a0a', 0.20, 'lefttop')

            -- If timer = 0 then Stop Recall
            if CountDownTimer <= 0 then
                RecallStop = 1 
                RecallActive = false
                -- Update Status to Next Stage
                RecallState = 1
                NextRecallTimer()
                break
            end

            CountDownTimer = CountDownTimer - 1
        end
        
        WaitSeconds(1.2)
    end
end

function PlayerLocationThread(RecallPosition, RecallDistance, PlayerArmies)
    MakeFlashVisibleCommander(PlayerArmies)
    while true do 
        if RecallStop == 1 then 
            break
        end
        for i, Army in PlayerArmies do
            -- get commanders from player armies

            if ScenarioInfo.ArmySetup[Army].Human == true then 
                local Commander = GetArmyBrain(Army):GetListOfUnits(categories.COMMAND , false, false)[1]
                -- if he has commander then 
                if Commander then 
                    local Distance = VDist3(Commander:GetPosition(),RecallPosition)	
                    if InsideRecallArea(Commander, Distance, RecallDistance, Army) then
                        InsideRecall[i] = {Commander.UnitId, true}   
                    else 
                        InsideRecall[i] = {Commander.UnitId, false}
                    end
                end
                -- if commander is dead
                if not Commander then 
                    InsideRecall[i] = nil
                end
            end
        end
        WaitSeconds(2)
    end
end

function MakeFlashVisibleCommander(PlayerArmies)
    for i, Army in PlayerArmies do
        -- get commanders from player armies
        if ScenarioInfo.ArmySetup[Army].Human == true then 
            local Commander = GetArmyBrain(Army):GetListOfUnits(categories.COMMAND , false, false)[1]
            if Army == "ARMY_1" then 
                ScenarioInfo.MoveCommander1 = Objectives.Basic( -- Type, Complete, Title, Description, Image, Target
                    'secondary', 'incomplete', "Move to Recall Zone", "Move to Recall Zone", Objectives.GetActionIcon('Move'),           
                    { Units = {Commander}, MarkUnits = true, FlashVisible = true,})
                ForkThread(function() 
                    while true do 
                        if RecallState == 2 then 
                            ScenarioInfo.MoveCommander1:ManualResult( true )
                            break
                        end
                        if RecallStop == 1 then 
                            ScenarioInfo.MoveCommander1:ManualResult( false )
                            break
                        end
                        WaitSeconds(1)
                    end
                end) 
            end
            if Army == "ARMY_2" then
                ScenarioInfo.MoveCommander2 = Objectives.Basic( -- Type, Complete, Title, Description, Image, Target
                    'secondary', 'incomplete', "Move to Recall Zone", "Move to Recall Zone", Objectives.GetActionIcon('Move'),           
                    { Units = {Commander}, MarkUnits = true, FlashVisible = true,})
                ForkThread(function() 
                    while true do 
                        if RecallState == 2 then 
                            ScenarioInfo.MoveCommander2:ManualResult( true )
                            break
                        end
                        if RecallStop == 1 then 
                            ScenarioInfo.MoveCommander2:ManualResult( false )
                            break
                        end
                        WaitSeconds(1)
                    end
                end) 
            end
            if Army == "ARMY_3" then
                ScenarioInfo.MoveCommander3 = Objectives.Basic( -- Type, Complete, Title, Description, Image, Target
                    'secondary', 'incomplete', "Move to Recall Zone", "Move to Recall Zone", Objectives.GetActionIcon('Move'),           
                    { Units = {Commander}, MarkUnits = true, FlashVisible = true,})
                ForkThread(function() 
                    while true do 
                        if RecallState == 2 then 
                            ScenarioInfo.MoveCommander3:ManualResult( true )
                            break
                        end
                        if RecallStop == 1 then 
                            ScenarioInfo.MoveCommander3:ManualResult( false )
                            break
                        end
                        WaitSeconds(1)
                    end
                end) 
            end
            if Army == "ARMY_4" then
                ScenarioInfo.MoveCommander4 = Objectives.Basic( -- Type, Complete, Title, Description, Image, Target
                    'secondary', 'incomplete', "Move to Recall Zone", "Move to Recall Zone", Objectives.GetActionIcon('Move'),           
                    { Units = {Commander}, MarkUnits = true, FlashVisible = true,})
                ForkThread(function() 
                    while true do 
                        if RecallState == 2 then 
                            ScenarioInfo.MoveCommander4:ManualResult( true )
                            break
                        end
                        if RecallStop == 1 then 
                            ScenarioInfo.MoveCommander4:ManualResult( false )
                            break
                        end
                        WaitSeconds(1)
                    end
                end) 
            end
            if Army == "ARMY_5" then
                ScenarioInfo.MoveCommander5 = Objectives.Basic( -- Type, Complete, Title, Description, Image, Target
                    'secondary', 'incomplete', "Move to Recall Zone", "Move to Recall Zone", Objectives.GetActionIcon('Move'),           
                    { Units = {Commander}, MarkUnits = true, FlashVisible = true,})
                ForkThread(function() 
                    while true do 
                        if RecallState == 2 then 
                            ScenarioInfo.MoveCommander5:ManualResult( true )
                            break
                        end
                        if RecallStop == 1 then 
                            ScenarioInfo.MoveCommander5:ManualResult( false )
                            break
                        end
                        WaitSeconds(1)
                    end
                end) 
            end
        end
    end
end


function InsideRecallArea(Commander, Distance, RecallDistance, Army)
    -- if inside return true
    WriteTextDistanceCommanderToRecall(Commander, Distance, RecallDistance, Army)
    if Distance <= RecallDistance then 
        return true
    end
    -- not inside return false
    if Distance >= RecallDistance then 
        return false
    end
end


function WriteTextDistanceCommanderToRecall(Commander, Distance, RecallDistance, Army)
    local DistanceToRecall = Distance - RecallDistance
    local DistanceRound = math.round(DistanceToRecall * 19.5)
    if DistanceRound < 0 then 
        DistanceRound = 0
    end

    local Nickname = GetArmyBrain(Army).Nickname
    local Name = "Error"
    if Nickname ~= nil then 
         Name = string.sub(Nickname, 1, 6)
    end

    local ComFaction = Commander.factionCategory
    local Faction = "Error"
    if ComFaction ~= nil then
        Faction = string.sub(ComFaction, 1, 4)
    end

    local BrainColour = import('/lua/GameColors.lua').GameColors.ArmyColors[ScenarioInfo.ArmySetup[Army].PlayerColor]
    local Formatt = "Error"
    if BrainColour ~= nil then
        Formatt = string.sub(BrainColour, 3)
    end

    BroadcastMsg.TextMsg(string.rep(" ", 90) .. Name .. ": " .. Faction .. " Acu " .. DistanceRound .. " m", 20, Formatt, 1.0, 'centertop')
end

function CheckAll(Table)
    -- Check if all commanders are inside recall area
    for _, Commander in Table do
        if not Commander[2] then
            return 
        end
    end
    -- if all true then return true
    return true
end

function VictoryWooopWooop()
    ScenarioInfo.ProtectObject1:ManualResult( true )
    ForkThread(function()
        PlayDialogue.Dialogue(DialogueList.Entropy_10, nil, false) --Entropy: We've got a lock on your ACU. Almost there.
        for i, Army in PlayerArmies do
            TeleportCommander(Army)
        end

        PlayDialogue.Dialogue(DialogueList.Entropy_11, nil, false) --Entropy: That was damn close, Commander. Glad we got you out of there in one piece.
        WaitSeconds(5)
        for i, Army in PlayerArmies do
            -- Score should be visable now
            GetArmyBrain(Army):OnVictory()

        end
        Dialog1 = {
            {displayTime = 80, text =
            " \n\n\n\n\n\n\n\n\n ",}
        }
        Dialog2 = {
            {displayTime = 80, text =
            "Good job, Commanders.\nRecall was successful.\nThe Order's project has bin destroyed.\n\n\n I hope you enjoyed the game.\nPlease give me a Review in the Map Vault.\n                  Commander Jammer out!",}
        }

        for z = 1, 5 do 
            BroadcastMsg.DisplayDialogBox("right", Dialog1, false)
        end
        BroadcastMsg.DisplayDialogBox("right", Dialog2, false)


        for i, Army in EnemyArmies do 
            GetArmyBrain(Army):OnDefeat()
        end 
        Statistics.Setup()
        WaitSeconds(5)
        EndGame()
    end)
end

function TeleportCommander(Army)
    -- Teleport Commanders
    local Commander = GetArmyBrain(Army):GetListOfUnits(categories.COMMAND , false, false)[1]
    if Commander then
        ScenarioFramework.FakeTeleportUnit(Commander, true)
    end
end

function NextRecallTimer()
    local NextRecallTimer = 595
    ForkThread(function()
        WaitSeconds(5)
        BroadcastMsg.TextMsg(string.rep(" ", 90) .. "Next Recall in: ", 25, 'e80a0a', 595, 'lefttop')
        while true do 
            if NextRecallTimer > 59 then
                local Minutes = math.round((NextRecallTimer/60) - 0.5) 
                local TotalSecondsMinutes = Minutes * 60
                local Seconds = NextRecallTimer - TotalSecondsMinutes
                if Seconds < 10 then
                    Seconds = "0"..Seconds
                end
                Time = Minutes..":"..Seconds
            end
            if NextRecallTimer < 60 then
                Time = NextRecallTimer
            end

            BroadcastMsg.TextMsg(string.rep(" ", 97) .. "" .. Time, 25, 'e80a0a', 0.00001, 'lefttop')
            NextRecallTimer = NextRecallTimer - 1
            if NextRecallTimer < 0 then 
                break
            end
            WaitSeconds(1)        
        end
    end)
end