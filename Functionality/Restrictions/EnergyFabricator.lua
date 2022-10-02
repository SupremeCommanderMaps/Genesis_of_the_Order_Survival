-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local Restrictions = import(ScenarioInfo.MapPath .. 'Functionality/Restrictions.lua')
local UnitAnalyzer = import(ScenarioInfo.MapPath .. 'Functionality/Restrictions/UnitAnalyzer/UnitAnalyzer.lua')

-- Allowed Energy production = Vanilla production/buildcost * 1.25

function IsEnergyFabricatorAllowed(PlayerArmies, UnitId, IncomeMultiplier, BuildCostMultiplier)
	TechLevel = UnitAnalyzer.GetUnitTech(UnitId)
	if TechLevel ~= "TECH_UNKNOWN" then
		CheckUnitStats(PlayerArmies, UnitId, IncomeMultiplier, BuildCostMultiplier, TechLevel)
		return
	else
		LOG("Mod Restriction Energy Fabricator: Failed to specify Tech level: " ..repr(UnitId))
		AddBuildRestriction(PlayerArmies, UnitId)
		return
	end
end

function CheckUnitStats(PlayerArmies, UnitId, IncomeMultiplier, BuildCostMultiplier, TechLevel)
	local CategoriesCount = 1
	baseline = 0.000001
	if TechLevel == 'T1' then
		BaseLine = ((0.266666 * BuildCostMultiplier) * 1.10) * IncomeMultiplier 		--EngGenT1: 20/75 = 0.266666  
		for y, Category in __blueprints[UnitId].Categories do
			if Category == 'HYDROCARBON' then
				BaseLine = (0.625000 * 1.50) * IncomeMultiplier   --HydroT1 = 100/160				= 0.625000
			end
		end
	elseif TechLevel == 'T2' then 
		BaseLine = ((0.416666 * BuildCostMultiplier) * 1.10) * IncomeMultiplier 		--EngGenT2: 500/1200 = 0.416666

	elseif TechLevel == 'T3' then 
		BaseLine = ((0.771604 * BuildCostMultiplier) * 1.10) * IncomeMultiplier 		--EngGenT3: 2500/3240 = 0.771604
	
	elseif TechLevel == 'T4' then 
		BaseLine = ((1.1111111 * BuildCostMultiplier) * 1.10) * IncomeMultiplier 		--EngGenT4: 10000/9000 = 1.1111111 T4 Energy Generators MOD 
	end


	if GetEnergyRatio(UnitId) > BaseLine then
		LOG("Mod Restriction Energy Fabricator: "..TechLevel.." Power Generator Exceeded Energy threshold UnitBpId: " ..repr(UnitId))
		LOG("Mod Restriction Energy Fabricator:          "..TechLevel.." Energy Threshold: " ..repr(string.format("%.8f", BaseLine)).." Unit Threshold: " .. repr(string.format("%.8f", EnergyRatio)))
		AddBuildRestriction(PlayerArmies, UnitId)
	end
end

function GetEnergyRatio(UnitId)
	local EnergyProductionPersSecond = __blueprints[UnitId].Economy.ProductionPerSecondEnergy

	local EnergyFabricatorBuildCost = 0.1
	if __blueprints[UnitId].Economy.BuildCostMass ~= nil then
		if __blueprints[UnitId].Economy.BuildCostMass > 0 then 
			EnergyFabricatorBuildCost = __blueprints[UnitId].Economy.BuildCostMass
		else 
		EnergyFabricatorBuildCost = 0.1 --Asume its Free
		end
	end

	EnergyRatio = EnergyProductionPersSecond/EnergyFabricatorBuildCost
	return EnergyRatio
end

function AddBuildRestriction(PlayerArmies, UnitId)
	for i, Army in PlayerArmies do
		ScenarioFramework.AddRestriction(Army, categories[UnitId])
	end
	Count = 1
	Restrictions.RestrictionCounter(Count, UnitId)
end