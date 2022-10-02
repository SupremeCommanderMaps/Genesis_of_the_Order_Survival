-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local Restrictions = import(ScenarioInfo.MapPath .. 'Functionality/Restrictions.lua')
local UnitAnalyzer = import(ScenarioInfo.MapPath .. 'Functionality/Restrictions/UnitAnalyzer/UnitAnalyzer.lua')

-- Allowed Mass production = Vanilla production/buildcost * 1.10
function IsMassFabricatorAllowed(PlayerArmies, UnitId, IncomeMultiplier, BuildCostMultiplier)
	TechLevel = UnitAnalyzer.GetUnitTech(UnitId)
	if TechLevel ~= "TECH_UNKNOWN" then
		CheckUnitStats(PlayerArmies, UnitId, IncomeMultiplier, BuildCostMultiplier, TechLevel)
		return
	else
		LOG("Mod Restriction Mass Fabricator: Failed to specify Tech level: " ..repr(UnitId))
		AddBuildRestriction(PlayerArmies, UnitId)
		return
	end
end

function CheckUnitStats(PlayerArmies, UnitId, IncomeMultiplier, BuildCostMultiplier, TechLevel)
	local CategoriesCount = 1
	baseline = 0.000001
	if TechLevel == 'T1' then 
		BaseLine = ((0.055555 * BuildCostMultiplier) * 1.10) * IncomeMultiplier 		--VanillaMasExtT1: 2/36 = 0.055555
	end
	if TechLevel == 'T2' then 
		BaseLine = ((0.006666 * BuildCostMultiplier) * 1.10) * IncomeMultiplier 		--VanillaMasExtT2: 6/90 = 0.006666 -- MasFabT2: 1/200 = 0.004999
	end
	if TechLevel == 'T3' then 
		BaseLine = ((0.003913 * BuildCostMultiplier) * 1.10) * IncomeMultiplier 		--VanillaMasExtT3: 18/4600 = 0.003913  -- MasFabT3: 16/4000 = 0.004000  --RasSacu: 11/6525 = 0.001685
	end
	if TechLevel == 'T4' then 
		BaseLine = ((0.002250 * BuildCostMultiplier) * 1.10) * IncomeMultiplier 		--MasExtT4: should be 27/12000 = 0.002250 Maby Make Mod??? 
	end

	for z, Category in __blueprints[UnitId].Categories do
		if Category == 'MASSEXTRACTION' then 
			if GetMassRatio(UnitId) > BaseLine then
				LOG("Mod Restriction Mass Fabricator: "..TechLevel.." Mass Extractor Exceeded Mass threshold UnitBpId: " ..repr(UnitId))
				LOG("Mod Restriction Mass Fabricator:          "..TechLevel.." Mass Threshold: " ..repr(string.format("%.8f", BaseLine)).." Unit Threshold: " .. repr(string.format("%.8f", MassRatio)))
				AddBuildRestriction(PlayerArmies, UnitId)
			end
		elseif CategoriesCount == table.getn(__blueprints[UnitId].Categories) then
			LOG("Mod Restriction Mass Fabricator: "..TechLevel.." Can not find MassExtraction Category Mass Fabricator UnitBpId: " ..repr(UnitId))
			AddBuildRestriction(PlayerArmies, UnitId)
		else
			CategoriesCount = CategoriesCount + 1
		end
	end
end

function GetMassRatio(UnitId)
	local MassProductionPerSecond = __blueprints[UnitId].Economy.ProductionPerSecondMass

	local MassFabricatorBuildCost = 0.1
	if __blueprints[UnitId].Economy.BuildCostMass ~= nil then
		if __blueprints[UnitId].Economy.BuildCostMass > 0 then 
			MassFabricatorBuildCost = __blueprints[UnitId].Economy.BuildCostMass
		else 
		MassFabricatorBuildCost = 0.1 --Asume its Free
		end
	end

	MassRatio = MassProductionPerSecond/MassFabricatorBuildCost
	return MassRatio
end

function AddBuildRestriction(PlayerArmies, UnitId)
	for i, Army in PlayerArmies do
		ScenarioFramework.AddRestriction(Army, categories[UnitId])
	end
	Count = 1
	Restrictions.RestrictionCounter(Count, UnitId)
end

