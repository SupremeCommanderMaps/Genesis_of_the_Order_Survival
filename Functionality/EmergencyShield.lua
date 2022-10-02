-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local util = import('/lua/utilities.lua')

local BroadcastMsg = import(ScenarioInfo.MapPath .. 'Utilities/BroadcastMsg.lua')
local DefenceObject = import(ScenarioInfo.MapPath .. 'Functionality/DefenceObject.lua')


local ShieldBlueprint = {
	ImpactEffects = 'SeraphimShieldHit01',
	ImpactMesh = '/effects/entities/ShieldSection01/ShieldSection01_mesh',
	Mesh = '/effects/entities/cybranphalanxsphere01/cybranphalanxsphere02_mesh',
	MeshZ = '/effects/entities/Shield01/Shield01z_mesh',
	RegenAssistMult = 60,
	ShieldEnergyDrainRechargeTime = 60,
	ShieldMaxHealth = 2300,
	ShieldRechargeTime = 20,
	ShieldRegenRate = 300,
	ShieldRegenStartTime = 1,
	ShieldSize = 16,
	ShieldVerticalOffset = -2,
}


function EmergencyShield()
    local Count = 1
    local MaxCount = 3

	while true do    
        if Count > MaxCount then 
            break
        end
        
        if EmergencyBeacon:ShieldIsOn() ~= true then
            if not EmergencyBeacon.Dead then
                if DefenceObject.DefenceObject:GetHealth() < (DefenceObject.DefenceObject:GetMaxHealth() * 0.15) then           
                    EmergencyBeacon:CreateShield(ShieldBlueprint)
                    EmergencyBeacon:ShieldIsOn()
                    EmergencyBeacon.MyShield:SetShieldRegenRate(300)
                    BroadcastMsg.TextMsg(string.rep(" ", 50) .. "", 25, '00D5FF', 3, 'centertop')
                    BroadcastMsg.TextMsg(string.rep(" ", 50) .. "Emergency shield active:" .. Count .. "/" .. MaxCount , 25, '00D5FF', 3, 'centertop')
                    Count = Count + 1
                end
            end
		end
	WaitSeconds(1.0)	
    end
end

function SpawnEmergencyBeacon()
    local POS = ScenarioUtils.MarkerToPosition("prop-1")
	EmergencyBeacon = CreateUnitHPR('UEB5103', "ARMY_ALLY_UEF", POS[1], POS[2], POS[3], 0, 0.785398,0)
	EmergencyBeacon:SetCustomName("HEX: 48 69 20 47 61 72 72 79")
    EmergencyBeacon:SetMaxHealth(42)
    EmergencyBeacon:SetHealth(nil, 42)
	EmergencyBeacon:SetReclaimable(false)
    EmergencyBeacon:SetRegenRate(100)
	EmergencyBeacon:SetCapturable(false)
    EmergencyBeacon:SetDoNotTarget(true)
    EmergencyBeacon.CanBeKilled = false

    ForkThread(EmergencyShield)
end