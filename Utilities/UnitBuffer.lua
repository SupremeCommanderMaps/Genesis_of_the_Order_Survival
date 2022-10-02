-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

function HealthMultiplier(Unit)
	if ScenarioInfo.Options.Option_HealthMultiplier ~= 1 then
		local BaseHealthUnit = Unit:GetMaxHealth()
		Unit:SetVeterancy(1)
		Unit:SetVeterancy(1)
		Unit:SetVeterancy(1)
		Unit:SetVeterancy(1)
		Unit:SetVeterancy(1)
		Unit:SetMaxHealth(BaseHealthUnit * ScenarioInfo.Options.Option_HealthMultiplier)
		Unit:SetHealth(Unit, Unit:GetMaxHealth())
	end
	return Unit
end

function DamageMultiplier(Unit)
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
