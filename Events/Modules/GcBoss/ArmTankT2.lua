-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

function CreateModule(Army, MainUnit, Position, HealthMultiplier, DamageMultiplier, DificultyMultiplier, Stage)
	--Tanks on Arms
	-----------------------------------------------------------------------------------------------
	Arm1 = CreateUnitHPR('UAL0202', Army, Position[1], Position[2], Position[3], 1, 0, 0)
	Arm1:SetCustomName("LefttArmModule")
	Arm1.ImmuneToStun = true
	Arm1.MyShield:TurnOff()
	Arm1:SetCanBeKilled(false)
	Arm1:SetCanTakeDamage(false)
	Arm1:SetDoNotTarget(true)
	Arm1:AttachTo(MainUnit, 'Left_Arm_Muzzle01')
	Arm1:GetWeaponCount()
	Arm1Weapon1 = Arm1:GetWeapon(1)
	Arm1Weapon1:ChangeMaxRadius(19 + 12 * Stage)
	Arm1Weapon1:ChangeDamage(120 * DificultyMultiplier * DamageMultiplier * Stage)
	Arm1Weapon1:SetFiringRandomness(0)
	Arm1Weapon1:ChangeRateOfFire(4 * Stage)
	-----------------------------------------------------------------------------------------------
	Arm2 = CreateUnitHPR('UAL0202', Army, Position[1], Position[2], Position[3], 1, 0, 0)
	Arm2:SetCustomName("RightArmModule")
	Arm2.ImmuneToStun = true
	Arm2.MyShield:TurnOff()
	Arm2:SetCanBeKilled(false)
	Arm2:SetCanTakeDamage(false)
	Arm1:SetDoNotTarget(true)
	Arm2:AttachTo(MainUnit, 'Right_Arm_Muzzle01')
	Arm2:GetWeaponCount()
	Arm2Weapon1 = Arm1:GetWeapon(1)
	Arm2Weapon1:ChangeMaxRadius(19 + 12 * Stage)
	Arm2Weapon1:ChangeDamage(120 * DificultyMultiplier * DamageMultiplier * Stage)
	Arm2Weapon1:SetFiringRandomness(0)
	Arm2Weapon1:ChangeRateOfFire(4 * Stage)

	local OldCreateProjectileAtMuzzle = Arm1Weapon1.CreateProjectileAtMuzzle
	function CustomCreateProjectileAtMuzzle(self, muzzle)
		local Projectile = OldCreateProjectileAtMuzzle(self, muzzle)
		Projectile:SetLifetime(10)		
	end
	Arm1Weapon1.CreateProjectileAtMuzzle = CustomCreateProjectileAtMuzzle
	Arm2Weapon1.CreateProjectileAtMuzzle = CustomCreateProjectileAtMuzzle

    KillUnitThread(MainUnit, Arm1)
    KillUnitThread(MainUnit, Arm2)
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