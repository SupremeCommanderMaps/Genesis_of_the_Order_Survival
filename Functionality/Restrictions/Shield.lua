-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local Restrictions = import(ScenarioInfo.MapPath .. 'Functionality/Restrictions.lua')
local UnitAnalyzer = import(ScenarioInfo.MapPath .. 'Functionality/Restrictions/UnitAnalyzer/UnitAnalyzer.lua')

--[[
Cost/shield health 
]]

function IsShieldAllowed(PlayerArmies, UnitId, IncomeMultiplier, BuildCostMultiplier)
	TechLevel = UnitAnalyzer.GetUnitTech(UnitId)
	StructureOrMobile = UnitAnalyzer.GetUnitTech(UnitId)
	if TechLevel ~= "TECH_UNKNOWN" then
		if StructureOrMobile ~= "TECH_UNKNOWN" then
			CheckUnitStats(PlayerArmies, UnitId, IncomeMultiplier, BuildCostMultiplier, TechLevel, StructureOrMobile)
			return
		else
			LOG("Mod Restriction Shield: Failed to specify if Unit is Structure or Mobile: " ..repr(UnitId))
			AddBuildRestriction(PlayerArmies, UnitId)
		end
	else
		LOG("Mod Restriction Shield: Failed to specify Tech level: " ..repr(UnitId))
		AddBuildRestriction(PlayerArmies, UnitId)
		return
	end
end

function CheckUnitStats(PlayerArmies, UnitId, IncomeMultiplier, BuildCostMultiplier, TechLevel, StructureOrMobile)
	local CategoriesCount = 1
	ShieldHealthBaseLine = 0.000001
	ShieldRegenRateBaseLine = 0.00001
	if TechLevel == 'T1' then
		ShieldHealthBaseLine = ((4000 / (160 * BuildCostMultiplier)) * 1.20)				--CybranShield ED1: 4000/160 = 25.000000
		ShieldRegenRateBaseLine = ((45 / (160 * BuildCostMultiplier)) * 1.20) 				--CybranShield ED1: 45/160 = 0.281250
		ShieldRechargeTimeBaseLine = ((20 / (160 * BuildCostMultiplier)) * 1.20) 			--CybranShield ED1: 20/160 = 0.125000
		if StructureOrMobile == 'MOBILE' then
	
		end
	elseif TechLevel == 'T2' then 
		ShieldHealthBaseLine = ((13000 / (700 * BuildCostMultiplier)) * 1.20)				--SeraShieldT2: 13000/700 = 18.571428
		ShieldRegenRateBaseLine = ((153 / (700 * BuildCostMultiplier)) * 1.20) 				--SeraShieldT2: 153/700 = 0.218571
		ShieldRechargeTimeBaseLine = ((25 / (700 * BuildCostMultiplier)) * 1.20) 			--SeraShieldT2: 25/700 = 0.035714
		if StructureOrMobile == 'MOBILE' then
			ShieldHealthBaseLine = ((3500 / (220 * BuildCostMultiplier)) * 1.20)		--AeonMobileT2Shield: 3500/220 = 15.909090
			ShieldRegenRateBaseLine = ((58 / (220 * BuildCostMultiplier)) * 1.20) 		--AeonMobileT2Shield: 58/220 = 0.263636
			ShieldRechargeTimeBaseLine = ((26 / (220 * BuildCostMultiplier)) * 1.20) 	--AeonMobileT2Shield: 26/220 = 0.118181
		end	
	elseif TechLevel == 'T3' then 	
		ShieldHealthBaseLine = ((21000 / (3600 * BuildCostMultiplier)) * 1.20)				--SeraShieldT3: 21000/3600 = 5.833333
		ShieldRegenRateBaseLine = ((168 / (3600 * BuildCostMultiplier)) * 1.20) 			--SeraShieldT3: 168/3600 = 0.046666
		ShieldRechargeTimeBaseLine = ((25 / (3600 * BuildCostMultiplier)) * 1.20) 			--SeraShieldT3: 25/3600 = 0.034722
		if StructureOrMobile == 'MOBILE' then
			ShieldHealthBaseLine = ((10000 / (720 * BuildCostMultiplier)) * 1.20)		--SeraMobileShieldT3: 10000/720 = 13.888888
			ShieldRegenRateBaseLine = ((133 / (720 * BuildCostMultiplier)) * 1.20) 		--SeraMobileShieldT3: 133/720 = 0.184722
			ShieldRechargeTimeBaseLine = ((40 / (720 * BuildCostMultiplier)) * 1.20) 	--SeraMobileShieldT3: 40/720 = 0.055555	
		end	
	elseif TechLevel == 'T4' then 	
		ShieldHealthBaseLine = ((71400 / (11000 * BuildCostMultiplier)) * 1.20)				--SeraShieldT4: 71400/11000 = 6.490909 T4 Ultra Shield Tweaked MOD -- Seems unbalenced
		ShieldRegenRateBaseLine = ((450 / (11000 * BuildCostMultiplier)) * 1.20) 			--SeraShieldT4: 450/11000 = 0.040909 T4 Ultra Shield Tweaked MOD -- Seems unbalenced
		ShieldRechargeTimeBaseLine = ((35 / (11000 * BuildCostMultiplier)) * 1.20) 			--SeraShieldT4: 35/30000 = 0.001166 --Survival mayhem balance mod
		if StructureOrMobile == 'MOBILE' then
			ShieldHealthBaseLine = ((140000 / (30000 * BuildCostMultiplier)) * 1.20)	--AeonFlyingFortressT4: 140000/30000 = 4.666666 --Survival mayhem balance mod
			ShieldRegenRateBaseLine = ((790 / (30000 * BuildCostMultiplier)) * 1.20) 	--AeonFlyingFortressT4: 790/30000 = 0.026333 --Survival mayhem balance mod
			ShieldRechargeTimeBaseLine = ((35 / (30000 * BuildCostMultiplier)) * 1.20) 	--AeonFlyingFortressT4: 35/30000 = 0.001166 --Survival mayhem balance mod
		end
	end


	if GetShieldHealthRatio(UnitId) > ShieldHealthBaseLine then
		LOG("Mod Restriction Shield: "..TechLevel.." Shield Generator Exceeded Shield Max Health threshold UnitBpId: " ..repr(UnitId).." UnitName: ".. repr(__blueprints[UnitId].General.UnitName))
		LOG("Mod Restriction Shield:                   "..TechLevel.." Shield Max Health Threshold: " ..repr(string.format("%.8f", ShieldHealthBaseLine)).." Unit Threshold: " .. repr(string.format("%.8f", ShieldHealthRatio)))
		AddBuildRestriction(PlayerArmies, UnitId)
		return
	end
	if GetShieldRegenRateRatio(UnitId) > ShieldRegenRateBaseLine then
		LOG("Mod Restriction Shield: "..TechLevel.." Shield Generator Exceeded RegenRate threshold UnitBpId: " ..repr(UnitId).." UnitName: ".. repr(__blueprints[UnitId].General.UnitName))
		LOG("Mod Restriction Shield:                   "..TechLevel.." RegenRate Threshold: " ..repr(string.format("%.8f", ShieldRegenRateBaseLine)).." Unit Threshold: " .. repr(string.format("%.8f", ShieldRegenRateRatio)))
		AddBuildRestriction(PlayerArmies, UnitId)
		return
	end
	if GetShieldRechargeTimeRatio(UnitId) > ShieldRechargeTimeBaseLine then
		LOG("Mod Restriction Shield: "..TechLevel.." Shield Generator Exceeded RegenRate threshold UnitBpId: " ..repr(UnitId).." UnitName: ".. repr(__blueprints[UnitId].General.UnitName))
		LOG("Mod Restriction Shield:                   "..TechLevel.." RegenRate Threshold: " ..repr(string.format("%.8f", ShieldRegenRateBaseLine)).." Unit Threshold: " .. repr(string.format("%.8f", ShieldRechargeTimeRatio)))
		AddBuildRestriction(PlayerArmies, UnitId)
		return
	end
end

function GetShieldHealthRatio(UnitId) -- shieldmax health / Buildcost
	local ShieldMaxHealth = 9999999999999999999999
	if __blueprints[UnitId].Defense.Shield.ShieldMaxHealth ~= nil then
		if __blueprints[UnitId].Defense.Shield.ShieldMaxHealth > 0 then 
			ShieldMaxHealth = __blueprints[UnitId].Defense.Shield.ShieldMaxHealth
		else 
			ShieldMaxHealth = 9999999999999999999999 --Asume its infinite
		end
	end
	ShieldHealthRatio = ShieldMaxHealth/GetBuildCostMass(UnitId)
	return ShieldHealthRatio
end

function GetShieldRegenRateRatio(UnitId) -- shieldmax regenrate / BuildCost
	local ShieldRegenRate = 9999999999999999999999
	if __blueprints[UnitId].Defense.Shield.ShieldRegenRate ~= nil then
		if __blueprints[UnitId].Defense.Shield.ShieldRegenRate > 0 then 
			ShieldRegenRate = __blueprints[UnitId].Defense.Shield.ShieldRegenRate
		else 
			ShieldRegenRate = 9999999999999999999999 --Asume its infinite
		end
	end
	ShieldRegenRateRatio = ShieldRegenRate/GetBuildCostMass(UnitId)
	return ShieldRegenRateRatio
end

function GetShieldRechargeTimeRatio(UnitId)
	local ShieldRechargeTime = 0
	if __blueprints[UnitId].Defense.Shield.ShieldRechargeTime ~= nil then 
		if __blueprints[UnitId].Defense.Shield.ShieldRechargeTime > 0 then 

		else 
			ShieldRechargeTime = 0.1 --Asume there is not rechargetime
		end
	end
	ShieldRechargeTimeRatio = ShieldRechargeTime/GetBuildCostMass(UnitId)
	return ShieldRechargeTimeRatio
end

function GetBuildCostMass(UnitId)
	local ShieldBuildCost = 0.1
	if __blueprints[UnitId].Economy.BuildCostMass ~= nil then
		if __blueprints[UnitId].Economy.BuildCostMass > 0 then 
			ShieldBuildCost = __blueprints[UnitId].Economy.BuildCostMass
		else 
			ShieldBuildCost = 0.1 --Asume its Free
		end
	end
	return ShieldBuildCost
end

function AddBuildRestriction(PlayerArmies, UnitId)
	for i, Army in PlayerArmies do
		ScenarioFramework.AddRestriction(Army, categories[UnitId])
	end
	Count = 1
	Restrictions.RestrictionCounter(Count, UnitId)
end