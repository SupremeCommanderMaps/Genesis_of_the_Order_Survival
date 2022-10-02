-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local Restrictions = import(ScenarioInfo.MapPath .. 'Functionality/Restrictions.lua')

function IsResouceGeneratorAllowed(PlayerArmies, UnitId, IncomeMultiplier, BuildCostMultiplier)

	local CategoriesCount = 1
	local ResouceGeneratorBuildCostMass = 0.1 --Asume its Free
	if __blueprints[UnitId].Economy.BuildCostMass ~= nil then
		ResouceGeneratorBuildCostMass = __blueprints[UnitId].Economy.BuildCostMass
	end

	local ResouceGeneratorBuildCostEnergy = 0.1 --Asume its Free
	if __blueprints[UnitId].Economy.BuildCostEnergy ~= nil then
		ResouceGeneratorBuildCostEnergy = __blueprints[UnitId].Economy.BuildCostEnergy
	end

    local MaxMassProduction = 1
    if __blueprints[UnitId].Economy.MaxMass ~= nil then 
        MaxMassProduction = __blueprints[UnitId].Economy.MaxMass
    end
	local MaxEnergyProduction = 1
    if __blueprints[UnitId].Economy.MaxEnergy ~= nil then 
        MaxEnergyProduction = __blueprints[UnitId].Economy.MaxEnergy
    end

	local MassRatio = MaxMassProduction/ResouceGeneratorBuildCostMass
	local EnergyRatio = MaxEnergyProduction/ResouceGeneratorBuildCostEnergy
	local UnitCategories = __blueprints[UnitId].Categories
	local MaxCategoriesCount = table.getn(UnitCategories)

	--[[
		Resource Gen 10000/250200 Mass income/ buildcost Mass = 0.039968
		Resource Gen 1000000/7506000 Energy income / buildcost Energy = 0.133226
	]]
	for z, Categories in UnitCategories do -- Select what Tech level UnitId Compare to Vanilla Units
		if Categories == 'TECH1' then
			LOG("Mod Restriction Resource Generator: Tech1 UnitBpId: " ..repr(UnitId))	 				
			AddBuildRestriction(PlayerArmies, UnitId)
			return
		elseif Categories == 'TECH2' then 
			LOG("Mod Restriction Resource Generator: Tech2 UnitBpId: " ..repr(UnitId))
			AddBuildRestriction(PlayerArmies, UnitId)
			return
		elseif Categories == 'TECH3' then  
			LOG("Mod Restriction Resource Generator: Tech3 UnitBpId: " ..repr(UnitId))
			AddBuildRestriction(PlayerArmies, UnitId)
			return
		elseif Categories == 'EXPERIMENTAL' then
			local BaseLineMass = ((0.039968 * BuildCostMultiplier) * 1.25)
			local BaseLineEnergy = ((0.133226 * BuildCostMultiplier) * 1.25)
			if MassRatio > BaseLineMass then 
				LOG("Mod Restriction Resource Generator: Tech4 UnitBpId: " ..repr(UnitId))
				LOG("Mod Restriction Resource Generator:                   T4 MassThreshold: " ..repr(string.format("%.8f", BaseLineMass)).." Unit Threshold: " .. repr(string.format("%.8f", MassRatio)))
				AddBuildRestriction(PlayerArmies, UnitId)
				return
			end
			if EnergyRatio > BaseLineEnergy then 
				LOG("Mod Restriction Resource Generator: Tech4 UnitBpId: " ..repr(UnitId))
				LOG("Mod Restriction Resource Generator:                   T4 EnergyThreshold: " ..repr(string.format("%.8f", BaseLineEnergy)).." Unit Threshold: " .. repr(string.format("%.8f", EnergyRatio)))
				AddBuildRestriction(PlayerArmies, UnitId)
				return
			end
		elseif CategoriesCount == MaxCategoriesCount then
			LOG("Mod Restriction Resource Generator: Failed to specify Tech level: " ..repr(UnitId))
			AddBuildRestriction(PlayerArmies, UnitId)
		else
			CategoriesCount = CategoriesCount + 1
		end
	end
end

function AddBuildRestriction(PlayerArmies, UnitId)
	for i, Army in PlayerArmies do
		ScenarioFramework.AddRestriction(Army, categories[UnitId])
	end
	Count = 1
	Restrictions.RestrictionCounter(Count, UnitId)
end