-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local DificultyMultiplier = (ScenarioInfo.Options.Option_PlatoonWaveCount * 0.5)
local HealthMultiplier = ScenarioInfo.Options.Option_HealthMultiplier
local DamageMultiplier = ScenarioInfo.Options.Option_DamageMultiplier

local ShieldBlueprint = {
	ImpactEffects = 'SeraphimShieldHit01',
	ImpactMesh = '/effects/entities/ShieldSection01/ShieldSection01_mesh',
	Mesh = '/effects/entities/cybranphalanxsphere01/cybranphalanxsphere01_mesh',
	MeshZ = '/effects/entities/Shield01/Shield01z_mesh',
	RegenAssistMult = 60,
	ShieldEnergyDrainRechargeTime = 30,
	ShieldMaxHealth = 4000 * HealthMultiplier * DificultyMultiplier,
	ShieldRechargeTime = 20,
	ShieldRegenRate = 100,
	ShieldSize = 11,
	ShieldVerticalOffset = 0.0,
}

function CreateModule(Army, MainUnit, Position, HealthMultiplier, DamageMultiplier, DificultyMultiplier, Stage)
    MainUnit:SetProductionPerSecondEnergy(10000)
    -- Shield
    ForkThread(function()
        WaitSeconds(5)
        MainUnit:SetProductionPerSecondEnergy(0)
        MainUnit:CreateShield(ShieldBlueprint)
        MainUnit:ShieldIsOn()
        while true do 
            if MainUnit:IsDead() then
                break
            end
            if MainUnit:ShieldIsOn() == false then

                WaitSeconds(22) -- "Recharge Time" --
                if not MainUnit:IsDead() then
                    if MainUnit:ShieldIsOn() == false then -- If still not On build new shield
                        MainUnit:ShieldIsOn()
                        MainUnit:CreateShield(ShieldBlueprint)
                    end
                end
            end
            WaitSeconds(0.5)
        end
    end)
end