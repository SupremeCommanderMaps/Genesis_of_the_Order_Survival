-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local Restrictions = import(ScenarioInfo.MapPath .. 'Functionality/Restrictions.lua')

function IsMassStorageAllowed(PlayerArmies, UnitId, IncomeMultiplier, BuildCostMultiplier)
	local CategoriesCount = 1
	local MassFabricatorBuildCost = 0.1 --Asume its Free
	if __blueprints[UnitId].Economy.BuildCostMass ~= nil then
		MassFabricatorBuildCost = __blueprints[UnitId].Economy.BuildCostMass
	end

    local AdjacentMassProductionMod = 1
    if __blueprints[UnitId].Economy.AdjacentMassProductionMod ~= nil then 
        AdjacentMassProductionMod = __blueprints[UnitId].Economy.AdjacentMassProductionMod
    end

	local MassRatio = AdjacentMassProductionMod/MassFabricatorBuildCost
	local UnitCategories = __blueprints[UnitId].Categories
	local MaxCategoriesCount = table.getn(UnitCategories)
	 
	--[[
		Vanilla Units
		MasStorageT1 = 0.25/200 	= 0.00125
	]]
	for z, Categories in UnitCategories do -- Select what Tech level UnitId Compare to Vanilla Units
		if Categories == 'TECH1' then 				
			local BaseLine = ((0.00125 * BuildCostMultiplier) * 1.25)
			if MassRatio > BaseLine then 
				LOG("Mod Restriction Mass Storage: Tech1 Exceeded Mass threshold UnitBpId: " ..repr(UnitId))
				LOG("Mod Restriction Mass Storage:          T1 Threshold: " ..repr(string.format("%.8f", BaseLine)).." Unit Threshold: " .. repr(string.format("%.8f", MassRatio)))
				AddBuildRestriction(PlayerArmies, UnitId)
				return
			end
		elseif Categories == 'TECH2' then 
			LOG("Mod Restriction Mass Storage: Tech2 UnitBpId: " ..repr(UnitId))
			AddBuildRestriction(PlayerArmies, UnitId)
			return
		elseif Categories == 'TECH3' then  
			LOG("Mod Restriction Mass Storage: Tech3 UnitBpId: " ..repr(UnitId))
			AddBuildRestriction(PlayerArmies, UnitId)
			return
		elseif Categories == 'EXPERIMENTAL' then
			LOG("Mod Restriction Mass Storage: Tech4 UnitBpId: " ..repr(UnitId))
			AddBuildRestriction(PlayerArmies, UnitId)
			return
		elseif CategoriesCount == MaxCategoriesCount then
			LOG("Mod Restriction Mass Storage: Failed to specify Tech level: " ..repr(UnitId))
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