-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

function CreateModule(Army, MainUnit, Position, HealthMultiplier, DamageMultiplier, DificultyMultiplier, Stage)
	--Anti Air on Shoulder
	local Count = 2 * Stage
	-----------------------------------------------------------------------------------------------	
	for _ = 1, Count do
		Shoulder1 = CreateUnitHPR('UAL0205', Army, Position[1], Position[2], Position[3], 1, 0, 0)
		Shoulder1.ImmuneToStun = true
		Shoulder1:SetCustomName("LeftShoulderAAModule")
		Shoulder1:SetCanBeKilled(false)
		Shoulder1:SetCanTakeDamage(false)
		Shoulder1:SetDoNotTarget(true)
		Shoulder1:AttachTo(MainUnit, 'Left_Arm_B01')
		Shoulder1:GetWeaponCount()

		Shoulder1Weapon1 = Shoulder1:GetWeapon(2)
		Shoulder1Weapon1:ChangeMaxRadius(60)
		Shoulder1Weapon1:ChangeDamage(144 * DificultyMultiplier * DamageMultiplier * Stage)
		Shoulder1Weapon1:SetFiringRandomness(0)
		Shoulder1Weapon1:ChangeRateOfFire(15 * DificultyMultiplier)

		local OldCreateProjectileAtMuzzle = Shoulder1Weapon1.CreateProjectileAtMuzzle
		function CustomCreateProjectileAtMuzzle(self, muzzle)
			local Projectile = OldCreateProjectileAtMuzzle(self, muzzle)
			Projectile:SetLifetime(20)		
		end
		Shoulder1Weapon1.CreateProjectileAtMuzzle = CustomCreateProjectileAtMuzzle

        KillUnitThread(MainUnit, Shoulder1)
	end
	-----------------------------------------------------------------------------------------------
	for _ = 1, Count do
		Shoulder2 = CreateUnitHPR('UAL0205', Army, Position[1], Position[2], Position[3], 1, 0, 0)
		Shoulder2.ImmuneToStun = true
		Shoulder2:SetCustomName("RightShoulderAAModule")
		Shoulder2:SetCanBeKilled(false)
		Shoulder2:SetCanTakeDamage(false)
		Shoulder2:SetDoNotTarget(true)
		Shoulder2:AttachTo(MainUnit, 'Right_Arm_B01')
		Shoulder2:GetWeaponCount()

		Shoulder2Weapon1 = Shoulder2:GetWeapon(2)
		Shoulder2Weapon1:ChangeMaxRadius(60)
		Shoulder2Weapon1:ChangeDamage(144 * DificultyMultiplier * DamageMultiplier * Stage)
		Shoulder2Weapon1:SetFiringRandomness(0)
		Shoulder2Weapon1:ChangeRateOfFire(15 * DificultyMultiplier)

		local OldCreateProjectileAtMuzzle = Shoulder2Weapon1.CreateProjectileAtMuzzle
		function CustomCreateProjectileAtMuzzle(self, muzzle)
			local Projectile = OldCreateProjectileAtMuzzle(self, muzzle)
			Projectile:SetLifetime(20)		
		end
		Shoulder2Weapon1.CreateProjectileAtMuzzle = CustomCreateProjectileAtMuzzle

        KillUnitThread(MainUnit, Shoulder2)
	end
end

function KillUnitThread(MainUnit, AttachedUnit)
    ForkThread(function()
        while true do 
            WaitSeconds(0.5)
            if MainUnit:IsDead() then 
                if not AttachedUnit:IsDead() then
                    AttachedUnit:SetCanBeKilled(true)
                    KillUnit(AttachedUnit)
                    break
                end
            end
        end
    end)
end

function KillUnit(AttachedUnit)
    ForkThread(function()
        WaitSeconds(5)
        if not AttachedUnit:IsDead() then
            AttachedUnit:DestroyUnit()
        end
    end)
end