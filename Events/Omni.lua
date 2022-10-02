-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

-- Not used on map

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')

function SpawnOmni()
	for i, Army in ListArmies() do
		if (Army == "ARMY_1" or Army == "ARMY_4" or Army == "ARMY_6" or Army == "ARMY_8" or Army == "ARMY_10") then 
			local POS = ScenarioUtils.MarkerToPosition("Omni1")
			Omni1 = CreateUnitHPR('UAB3201', "ARMY_NEUTRAL", POS[1], POS[2], POS[3], 0,0,0)
			
			UpgradeOmni1 = function()
				local upgradeBP = Omni1:GetBlueprint().General.UpgradesTo
				IssueUpgrade({Omni1}, upgradeBP)
				WaitSeconds(1.0)
				Omni1:SetPaused(true)
				while true do
					WaitSeconds(10.0)
					if Omni1:IsDead() then
						local armyNeutral = GetArmyBrain("ARMY_NEUTRAL")
						local Omni = armyNeutral:GetListOfUnits(categories.STRUCTURE * categories.OMNI, false)[1];
						WaitSeconds(1.0)
						Omni:SetConsumptionPerSecondEnergy(0);
						break
					end
				end
			end
			ForkThread(UpgradeOmni1)
		end
		if (Army == "ARMY_2" or Army == "ARMY_3" or Army == "ARMY_5" or Army == "ARMY_7" or Army == "ARMY_9") then 
			local POS = ScenarioUtils.MarkerToPosition("Omni2")
			Omni2 = CreateUnitHPR('UAB3201', "ARMY_NEUTRAL", POS[1], POS[2], POS[3], 0,0,0)
			
			UpgradeOmni2 = function()
				local upgradeBP = Omni2:GetBlueprint().General.UpgradesTo
				IssueUpgrade({Omni2}, upgradeBP)
				WaitSeconds(1.0)
				Omni2:SetPaused(true)
				while true do
					WaitSeconds(10.0)
					if Omni2:IsDead() then
						local armyNeutral = GetArmyBrain("ARMY_NEUTRAL")
						local Omni = armyNeutral:GetListOfUnits(categories.STRUCTURE * categories.OMNI, false)[2];
						WaitSeconds(1.0)
						Omni:SetConsumptionPerSecondEnergy(0);
						break
					end
				end
			end
			ForkThread(UpgradeOmni2)
			end
		end
end
