-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local Restrictions = import(ScenarioInfo.MapPath .. 'Functionality/Restrictions.lua')
local UnitAnalyzer = import(ScenarioInfo.MapPath .. 'Functionality/Restrictions/UnitAnalyzer/UnitAnalyzer.lua')
local OgStats = import(ScenarioInfo.MapPath .. 'Tables/OgStats.lua')


PlayerArmies = { }
IncomeMultiplier = 1
BuildCostMultiplier = 1

	--LOG("Report ....::::" .. repr(OgStats.T3PD.HpBuildCostRatio))
	--LOG("Report ....::::" .. repr(OgStats.T3PD.Dps))
	--LOG("Report ....::::" .. repr(UnitId))

function IsUnitAllowed(PlayerArmies, UnitId, IncomeMultiplier, BuildCostMultiplier)

	PlayerArmies = PlayerArmies
	IncomeMultiplier = IncomeMultiplier
	BuildCostMultiplier = BuildCostMultiplier

	TechLevel = UnitAnalyzer.GetUnitTech(UnitId)
	if TechLevel ~= 'TECH_UNKNOWN' then 
		--LOG("Mod Restriction Weapon: " .. repr(TechLevel) .. " UnitId: "  ..repr(UnitId) .." UnitName: ".. repr(__blueprints[UnitId].General.UnitName))
		GetUnitType(UnitId, TechLevel)
	else 
		LOG("Mod Restriction Weapon: Failed to specify Tech level: Restrict Unit: "  ..repr(UnitId) .." UnitName: ".. repr(__blueprints[UnitId].General.UnitName))
		AddBuildRestriction(UnitId)
	end
end

function GetUnitType(UnitId, TechLevel)
	UnitType = UnitAnalyzer.GetUnitType(UnitId)
	if UnitType ~= 'TYPE_UNKNOWN' then
		if UnitType == 'STRUCTURE' then 
			--UnitAnalyzer.GetWeaponsStats(bp)
			--LOG("Mod Restriction Weapon: " .. repr(UnitType) .. " UnitId: "  ..repr(UnitId) .." UnitName: ".. repr(__blueprints[UnitId].General.UnitName))
		elseif UnitType == 'AIR' then 
			--LOG("Mod Restriction Weapon: " .. repr(UnitType) .. " UnitId: "  ..repr(UnitId) .." UnitName: ".. repr(__blueprints[UnitId].General.UnitName))
		elseif UnitType == 'LAND' then 
			--LOG("Mod Restriction Weapon: " .. repr(UnitType) .. " UnitId: "  ..repr(UnitId) .." UnitName: ".. repr(__blueprints[UnitId].General.UnitName))
		elseif UnitType == 'NAVAL' then 
			--LOG("Mod Restriction Weapon: " .. repr(UnitType) .. " UnitId: "  ..repr(UnitId) .." UnitName: ".. repr(__blueprints[UnitId].General.UnitName))
		elseif UnitType == 'HOVER' then 
			--LOG("Mod Restriction Weapon: " .. repr(UnitType) .. " UnitId: "  ..repr(UnitId) .." UnitName: ".. repr(__blueprints[UnitId].General.UnitName))
		end
	else 
		LOG("Mod Restriction Weapon: Failed to specify UnitType: must be STRUCTURE, AIR, LAND, NAVAL, HOVER. Restrict Unit: "  ..repr(UnitId) .." UnitName: ".. repr(__blueprints[UnitId].General.UnitName))
		AddBuildRestriction(UnitId)
	end
end





function AddBuildRestriction(UnitId)
	for i, Army in PlayerArmies do
		ScenarioFramework.AddRestriction(Army, categories[UnitId])
	end
	Count = 1
	Restrictions.RestrictionCounter(Count, UnitId)
end


function GetUnitStructureOrMobile(PlayerArmies, UnitId, UnitCategories, MaxCategoriesCount)
	local CategoriesCount = 1
	for z, Category in UnitCategories do -- Check For 'STRUCTURE' OR 'MOBILE'
		if Category == 'STRUCTURE' then 
			CategoryStructure = Category
			return CategoryStructure
		elseif Category == 'MOBILE' then 
			CategoryMobile = Category
			return CategoryMobile
		elseif CategoriesCount == MaxCategoriesCount then
			CategoryFailed = 'NOSTRUCTUREORMOBILE'
			LOG("Mod Restriction Weapon: Failed to specify if Unit is Structure or Mobile: Restrict Unit:  "   ..repr(UnitId) .." UnitName: ".. repr(__blueprints[UnitId].General.UnitName))
			AddBuildRestriction(PlayerArmies, UnitId)
			return CategoryFailed
		else
			CategoriesCount = CategoriesCount + 1
		end
	end
end