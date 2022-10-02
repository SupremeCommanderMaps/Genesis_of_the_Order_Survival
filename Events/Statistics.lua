-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local Utilities = import('/lua/utilities.lua')

local BroadcastMsg = import(ScenarioInfo.MapPath .. 'Utilities/BroadcastMsg.lua')

IsActive = false

function Setup()

    local Dialogue1 = ""
    local Dialogue2 = ""
    local Dialogue3 = ""
    local Dialogue4 = ""
    local Dialogue5 = ""

    if IsActive == false then
        IsActive = true
        ForkThread(function()
            WaitSeconds(0.1)
            while true do 
                for i, Army in ListArmies() do
                    if Army == "ARMY_1" then 
                        Dialogue1 = GetExtendedDialogue(Army)
                    end
                    if Army == "ARMY_2" then
                        Dialogue2 = GetExtendedDialogue(Army)
                    end
                    if Army == "ARMY_3" then
                        Dialogue3 = GetExtendedDialogue(Army)
                    end
                    if Army == "ARMY_4" then
                        Dialogue4 = GetExtendedDialogue(Army)
                    end
                    if Army == "ARMY_5" then
                        Dialogue5 = GetExtendedDialogue(Army)
                    end
                end

                Dialog = {
                    {displayTime = 10, text = 
                    "" .. Dialogue1.. "" .. Dialogue2 .. "" .. Dialogue3 .. "" .. Dialogue4 .. "" .. Dialogue5 .. ""},
                }
                BroadcastMsg.DisplayDialogBox("left", Dialog, false)
                WaitSeconds(10)
                IsActive = false
                break
            end
        end)
    end
end

function ShortDialogue(Army)
    local Nickname = GetArmyBrain(Army).Nickname
    local Name = string.sub(Nickname, 1, 18)
    local Kill = GetArmyBrain(Army):GetArmyStat("Enemies_Killed", 0).Value
    
    local IncomeMass = GetArmyBrain(Army):GetArmyStat("Economy_Income_Mass", 0).Value
    local ProducedMass = GetArmyBrain(Army):GetArmyStat("Economy_TotalProduced_Mass", 0).Value
    local ReclaimedMass = GetArmyBrain(Army):GetArmyStat("Economy_Reclaimed_Mass", 0).Value

    Dialogue = {""..Name..
                "\n       Kills: "..Kill..
                "\n       Income Ⓜ: "..Formatt1(IncomeMass,1)..
                "\n       Reclaimed Ⓜ: "..Formatt(ReclaimedMass)..
                "\n       Produced Ⓜ: "..Formatt(ProducedMass)..
                "\n"}
    return Dialogue[1]
end

function GetExtendedDialogue(Army)
    local CalculateBrainScore = import('/lua/sim/score.lua').CalculateBrainScore

    local Nickname = GetArmyBrain(Army).Nickname
    local Name = string.sub(Nickname, 1, 18)
    local Kill = GetArmyBrain(Army):GetArmyStat("Enemies_Killed", 0).Value

    local IncomeMass = GetArmyBrain(Army):GetArmyStat("Economy_Income_Mass", 0).Value
    local ReclaimedMass = GetArmyBrain(Army):GetArmyStat("Economy_Reclaimed_Mass", 0).Value    
    local ProducedMass = GetArmyBrain(Army):GetArmyStat("Economy_TotalProduced_Mass", 0).Value

    local IncomeEnergy = GetArmyBrain(Army):GetArmyStat("Economy_Income_Energy", 0).Value
    local ReclaimedEnergy = GetArmyBrain(Army):GetArmyStat("Economy_Reclaimed_Energy", 0).Value    
    local ProducedEnergy = GetArmyBrain(Army):GetArmyStat("Economy_TotalProduced_Energy", 0).Value

    local Score = CalculateBrainScore(GetArmyBrain(Army))
    local UnitCap = GetArmyBrain(Army):GetArmyStat("UnitCap_Current", 0.0).Value    
    local UnitMaxCap = GetArmyBrain(Army):GetArmyStat("UnitCap_MaxCap", 0.0).Value

    Dialogue = {""..Name..
                "\n   Income      M: "..FormattMass(IncomeMass,1)..
                "   E: "..FormattEnergy(IncomeEnergy,1)..

                "\n   Produced  M: "..FormattMass(ProducedMass,2).. 
                "   E: "..FormattEnergy(ProducedEnergy,2)..

                "\n   Reclaimed M: "..FormattMass(ReclaimedMass,2)..
                "   E: "..FormattEnergy(ReclaimedEnergy,1)..                

                "\n   Kills: "..Kill..
                "\n   Score: "..FormattScore(Score,1)..
                "   Units: "..UnitCap.."/"..UnitMaxCap..
                "\n"}
    return Dialogue[1]
end

function FormattMass(Value, Type) -- 1/2
    if Type == 1 then -- IncomeMass
        local z = Value * 10
        local a = math.round(z)
        return a
    end
    if Type == 2 then -- ReclaimedMass / ProducedMass
        local z = math.round(Value)
        if z > 9999 then 
            if z < 1000000 then 
                local a = z * 0.001
                local b = (string.format("%.1f", a))
                local c = b .. "k"
                return c
            end
        end
        if z > 999999 then
            local a = z * 0.000001
            local b = (string.format("%.2f", a))
            local c = b .. "m"
            return c
        end
        return z
    end
end

function FormattEnergy(Value, Type) 
    if Type == 1 then -- IncomeEnergy / ReclaimedEnergy
        z = Value * 10
        y = math.round(z)
        if y > 1000 then
            if y < 1000000 then
                local a = y * 0.001
                local b = math.round(a)
                c = b .. "k"
                return c
            end
        end
        if y > 999999 then
            local a = y * 0.00001
            local b = math.round(a)
            local c = b * 0.1
            local d = (string.format("%.1f", c))
            e = d .. "m"
            return e
        end
        return y
    end
    if Type == 2 then -- ProducedEnergy 
        z = Value * 10
        y = math.round(Value) - 3900
        if y > 1000 then
            if y < 1000000 then
                local a = y * 0.001
                local b = math.round(a)
                c = b .. "k"
                return c
            end
        end
        if y > 999999 then
            if y < 999999999 then
                local a = y * 0.00001
                local b = math.round(a)
                local c = b * 0.1
                local d = (string.format("%.1f", c))
                e = d .. "m"
                return e
            end
        end
        if y > 1000000000 then
            local a = y * 0.00000001
            local b = math.round(a)
            local c = b * 0.1
            local d = (string.format("%.1f", c))
            e = d .. "b"
            return e
        end
        return y
    end
end

function FormattScore(Value, Type)
    if Type == 1 then 
        local z = math.round(Value)
        if z > 9999 then 
            if z < 1000000 then 
                local a = z * 0.001
                local b = (string.format("%.1f", a))
                local c = b .. "k"
                return c
            end
        end
        if z > 999999 then
            local a = z * 0.000001
            local b = (string.format("%.2f", a))
            local c = b .. "m"
            return c
        end
        return z
    end
end