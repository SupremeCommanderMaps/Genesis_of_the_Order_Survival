-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local LogStats = false 


function HealthMultiplier(Unit)
	if Unit:GetBlueprint().General.UnitName == nil then 
		return Unit
	end
	if ScenarioInfo.Options.Option_HealthMultiplier ~= 1 then
		local BaseHealthUnit = Unit:GetMaxHealth()
		if not Unit:IsDead() then
			if LogStats == true then 
				LOG("UnitBuffer: Unit not IsDead: UnitName:" .. repr(Unit:GetBlueprint().General.UnitName))
				LOG("UnitBuffer: UnitBP Has VetranLevels:" .. repr(Unit:GetBlueprint().Veteran))
				LOG("UnitBuffer: UnitCurrent VetLevel:" .. repr(Unit.Sync.VeteranLevel))
			end

			if Unit:GetBlueprint().Veteran ~= nil then -- Look for VeteranTable -- Airscouts dont have Vet levels
				if Unit.Sync.VeteranLevel < 5 then -- if less then 5 then Set Veterancy
					VetLevelLeft = 5 - Unit.Sync.VeteranLevel
					for i = 1 , VetLevelLeft do
						Unit:SetVeterancy(1)
					end
				end
			end
			Unit:SetMaxHealth(BaseHealthUnit * ScenarioInfo.Options.Option_HealthMultiplier)
			Unit:SetHealth(Unit, Unit:GetMaxHealth())
		end
		if Unit.MyShield then
			if not Unit:IsDead() then
				Unit:CreateShield(CreateNewShield(Unit))	
			end
		end
	end
	return Unit
end

function DamageMultiplier(Unit)
	DamageAndRateBuffValue = (ScenarioInfo.Options.Option_DamageMultiplier) -- Defualt 1.00
	RangeBuff = 0
	if ScenarioInfo.Options.Option_DamageMultiplier > 1 then 
		RangeBuff =  0.0000 + (7.500 * (ScenarioInfo.Options.Option_DamageMultiplier * 0.1)) 		-- 0.000 + Min +0.8250 to Max of +5.6250 Range 
	end
	if ScenarioInfo.Options.Option_DamageMultiplier > 9 then 
		RangeBuff =  5.6250 + (1.500 * (ScenarioInfo.Options.Option_DamageMultiplier * 0.05))  		-- 5.625 + Min +0.7500 to Max of +1.8750 Range 
	end
	if ScenarioInfo.Options.Option_DamageMultiplier > 99 then 
		RangeBuff =  7.5000 + (0.7500 * (ScenarioInfo.Options.Option_DamageMultiplier * 0.01)) 		-- 7.500 + Min +0.7500 to Max of +3.7500 Range 
	end
	if ScenarioInfo.Options.Option_DamageMultiplier > 999 then 
		RangeBuff = 11.2500 + (0.5625 * (ScenarioInfo.Options.Option_DamageMultiplier * 0.005)) 	-- 11.25 + Min +2.8125 to Max of +2.8125 Range 
	end
	if ScenarioInfo.Options.Option_DamageMultiplier > 9999 then 
		RangeBuff = 14.0625 + (0.500 * (ScenarioInfo.Options.Option_DamageMultiplier * 0.00075)) 	-- 15.00 + Min +3.7500 to Max of +3.7500 Range
	end
	
	--local RangeBuffValue = (1 + (ScenarioInfo.Options.opt_Survival_EnemiesPerMinute * 0.01))

	for i = 1, Unit:GetWeaponCount() do
		local Weapon = Unit:GetWeapon(i)
		if Weapon.Label ~= 'DeathWeapon' and Weapon.Label ~= 'DeathImpact' then
				Weapon:AddDamageMod(Weapon:GetBlueprint().Damage * (DamageAndRateBuffValue - 1)) -- -1 Because of Adding Damage insted of replacing
				local MaxRadius = Weapon:GetBlueprint().MaxRadius
				if MaxRadius ~= nil then
					Weapon:ChangeMaxRadius(MaxRadius + RangeBuff)
				end
				local MaxRateOfFire = Weapon:GetBlueprint().RateOfFire
				if MaxRateOfFire ~= nil then
					Weapon:ChangeRateOfFire(MaxRateOfFire * DamageAndRateBuffValue)
				end
				local OldCreateProjectileAtMuzzle = Weapon.CreateProjectileAtMuzzle
				function CustomCreateProjectileAtMuzzle(self, muzzle)
					local Projectile = OldCreateProjectileAtMuzzle(self, muzzle)
						
						Projectile:SetLifetime(10)	
	
				end
				Weapon.CreateProjectileAtMuzzle = CustomCreateProjectileAtMuzzle
		end
	end

	if ScenarioInfo.Options.Option_DamageMultiplier ~= 1 then
		for i = 1, Unit:GetWeaponCount() do
			local Weapon = Unit:GetWeapon(i)
			if Weapon.Label ~= 'DeathWeapon' and Weapon.Label ~= 'DeathImpact' then
				Weapon:AddDamageMod(Weapon:GetBlueprint().Damage * (ScenarioInfo.Options.Option_DamageMultiplier - 1))
			end
		end
	end
	return Unit
end

function CreateNewShield(Unit)
	ShieldSizeBuff = 0
	if ScenarioInfo.Options.Option_HealthMultiplier > 1 then 
		ShieldSizeBuff =  0.00 + (10 * (ScenarioInfo.Options.Option_HealthMultiplier * 0.1)) 		-- 0.00 + Min +1.10 to Max of +7.50 Shield size 
	end
	if ScenarioInfo.Options.Option_HealthMultiplier > 9 then 
		ShieldSizeBuff =  7.50 + (2 * (ScenarioInfo.Options.Option_HealthMultiplier * 0.05))  		-- 7.50 + Min +1.00 to Max of +2.50 Shield size 
	end
	if ScenarioInfo.Options.Option_HealthMultiplier > 99 then 
		ShieldSizeBuff = 10.00 + (1 * (ScenarioInfo.Options.Option_HealthMultiplier * 0.01)) 		-- 6.25 + Min +1 to Max of +5 Shield size 
	end
	if ScenarioInfo.Options.Option_HealthMultiplier > 999 then 
		ShieldSizeBuff = 15.00 + (0.75 * (ScenarioInfo.Options.Option_HealthMultiplier * 0.005)) 	-- 11.25 + Min +3.75 to Max of +3.75 Shield size 
	end
	if ScenarioInfo.Options.Option_HealthMultiplier > 9999 then 
		ShieldSizeBuff = 18.75 + (0.5 * (ScenarioInfo.Options.Option_HealthMultiplier * 0.00075)) 	-- 15.00 + Min +3.75 to Max of +3.75 Shield size
	end
	if Unit:GetBlueprint().Defense.Shield.PersonalShield then
		local PersonalShield = "Personal"
		local GetImpactEffects = Unit:GetBlueprint().Defense.Shield.ImpactEffects
		local GetImpactMesh = Unit:GetBlueprint().Defense.Shield.ImpactMesh
		local GetOwnerShieldMesh = Unit:GetBlueprint().Defense.Shield.OwnerShieldMesh -- only on personalshield
		local GetPersonalShield = Unit:GetBlueprint().Defense.Shield.PersonalShield -- only on personalshield
		local GetRegenAssist = Unit:GetBlueprint().Defense.Shield.RegenAssistMult
		local GetShieldEnergyDrainRechargeTime = Unit:GetBlueprint().Defense.Shield.ShieldEnergyDrainRechargeTime
		local GetShieldMaxHealth = Unit:GetBlueprint().Defense.Shield.ShieldMaxHealth * ScenarioInfo.Options.Option_HealthMultiplier
		local GetShieldRechargeTime = Unit:GetBlueprint().Defense.Shield.ShieldRechargeTime
		local GetShieldRegenRate = Unit:GetBlueprint().Defense.Shield.ShieldRegenRate * ScenarioInfo.Options.Option_HealthMultiplier
		local GetShieldRegenStartTime = Unit:GetBlueprint().Defense.Shield.ShieldRegenStartTime
		local GetShieldSize = Unit:GetBlueprint().Defense.Shield.ShieldSize + ShieldSizeBuff
		local GetShieldVerticalOffset = Unit:GetBlueprint().Defense.Shield.ShieldVerticalOffset

		local BpShield = {
            ImpactEffects = GetImpactEffects,
			ImpactMesh = GetImpactMesh,
            OwnerShieldMesh = GetOwnerShieldMesh,
            PersonalShield = GetPersonalShield,
            RegenAssistMult = GetRegenAssist,
            ShieldEnergyDrainRechargeTime = GetShieldEnergyDrainRechargeTime,
            ShieldMaxHealth = GetShieldMaxHealth,
            ShieldRechargeTime = GetShieldRechargeTime,
            ShieldRegenRate = GetShieldRegenRate,
            ShieldRegenStartTime = GetShieldRegenStartTime,
            ShieldSize = GetShieldSize,
            ShieldVerticalOffset = GetShieldVerticalOffset
        }
		ForkThreadShieldHpToCustomName(Unit, PersonalShield)
		return BpShield
	end

	if Unit:GetBlueprint().Defense.Shield.Mesh ~= nil then 
		local BubbleShield = "Bubble"
		local GetImpactEffects = Unit:GetBlueprint().Defense.Shield.ImpactEffects
		local GetImpactMesh = Unit:GetBlueprint().Defense.Shield.ImpactMesh
		local GetMesh = Unit:GetBlueprint().Defense.Shield.Mesh -- only on bubbleshield
		local GetMeshZ = Unit:GetBlueprint().Defense.Shield.MeshZ -- only on bubbleshield
		local GetRegenAssist = Unit:GetBlueprint().Defense.Shield.RegenAssistMult
		local GetShieldEnergyDrainRechargeTime = Unit:GetBlueprint().Defense.Shield.ShieldEnergyDrainRechargeTime
		local GetShieldMaxHealth = Unit:GetBlueprint().Defense.Shield.ShieldMaxHealth * ScenarioInfo.Options.Option_HealthMultiplier
		local GetShieldRechargeTime = Unit:GetBlueprint().Defense.Shield.ShieldRechargeTime
		local GetShieldRegenRate = Unit:GetBlueprint().Defense.Shield.ShieldRegenRate * ScenarioInfo.Options.Option_HealthMultiplier
		local GetShieldRegenStartTime = Unit:GetBlueprint().Defense.Shield.ShieldRegenStartTime
		local GetShieldSize = Unit:GetBlueprint().Defense.Shield.ShieldSize + ShieldSizeBuff
		local GetShieldSpillOverDamageMod = Unit:GetBlueprint().Defense.Shield.ShieldSpillOverDamageMod -- only on bubbleshield
		if EntityCategoryContains(categories.AIR, Unit) then 
			GetShieldVerticalOffset = Unit:GetBlueprint().Defense.Shield.ShieldVerticalOffset
		else
			GetShieldVerticalOffset = Unit:GetBlueprint().Defense.Shield.ShieldVerticalOffset - (ShieldSizeBuff * 0.15) -- decrease Height of shied 15% of size Buff
		end
		
		--if Unit:GetUnitId() == "xes0205" then 
		--	local SizeBuff = MovementAndShieldSizebuffValue * 0.5
		--	local OffsetBuff = HpAndRegenBuffValue * 0.5
		--	GetShieldSize = Unit:GetBlueprint().Defense.Shield.ShieldSize * SizeBuff
		--	GetShieldVerticalOffset = Unit:GetBlueprint().Defense.Shield.ShieldVerticalOffset - OffsetBuff
		--end

		local BpShield = {
            ImpactEffects = GetImpactEffects,
            ImpactMesh = GetImpactMesh,
            Mesh = GetMesh,
            MeshZ = GetMeshZ,
            RegenAssistMult = GetRegenAssist,
            ShieldEnergyDrainRechargeTime = GetShieldEnergyDrainRechargeTime,
            ShieldMaxHealth = GetShieldMaxHealth,
            ShieldRechargeTime = GetShieldRechargeTime,
            ShieldRegenRate = GetShieldRegenRate,
            ShieldRegenStartTime = GetShieldRegenStartTime,
            ShieldSize = GetShieldSize,
            ShieldSpillOverDamageMod = GetShieldSpillOverDamageMod,
            ShieldVerticalOffset = GetShieldVerticalOffset,
        }
		ForkThreadShieldHpToCustomName(Unit, BubbleShield)
		return BpShield
	end
end

function ForkThreadShieldHpToCustomName(Unit, Type)
	ForkThread(function()
		while true do 
			if Unit:IsDead() then
				break
			end
			local CurrentHpShield = Unit.MyShield:GetHealth()
			local MaxHpShield = Unit.MyShield:GetMaxHealth()
			Unit:SetCustomName("Shield HP: " .. string.format("%.0f", CurrentHpShield) .. "/" .. string.format("%.0f", MaxHpShield).. " ShieldType: " .. repr(Type))


			WaitSeconds(1)
		end
	end)
end