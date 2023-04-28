-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

function CreateModule(Army, MainUnit, Position, HealthMultiplier, DamageMultiplier, DificultyMultiplier, Stage)
	-- Sacu in Upper Arms -- Tractor Claws
	-----------------------------------------------------------------------------------------------
	Arm3 = CreateUnitHPR('XSL0301', Army, Position[1], Position[2], Position[3], 1, 0, 0)
	Arm3.ImmuneToStun = true
	Arm3:SetCustomName("ArmModule3")
	Arm3:AttachTo(MainUnit, 'Left_Arm_B02')
	Arm3:SetCanBeKilled(false)
	Arm3:SetDoNotTarget(true)

	Arm3:HideBone(3, true)
	Arm3:HideBone(4, true)
	Arm3:HideBone(5, true)
	Arm3:HideBone(7, true)
	Arm3:HideBone(8, true)
	Arm3:HideBone(9, true)	
	Arm3:HideBone(10, true)	
	Arm3:HideBone(11, true)

	Arm3Weapon1 = Arm3:GetWeapon(1)
	Arm3Weapon1:SetFiringRandomness(0.0)
	Arm3Weapon1:ChangeRateOfFire(10 * Stage)
	Arm3Weapon1:ChangeMaxRadius(20 * Stage)
	Arm3Weapon1:AddDamageMod(125 * DificultyMultiplier * DamageMultiplier * Stage)
	-----------------------------------------------------------------------------------------------
	Arm4 = CreateUnitHPR('XSL0301', Army, Position[1], Position[2], Position[3], 1, 0, 0)
	Arm4.ImmuneToStun = true
	Arm4:SetCustomName("ArmModule4")
	Arm4:AttachTo(MainUnit, 'Right_Arm_B02')
	Arm4:SetCanBeKilled(false)
	Arm4:SetDoNotTarget(true)

	Arm4:HideBone(3, true)
	Arm4:HideBone(4, true)
	Arm4:HideBone(5, true)
	Arm4:HideBone(7, true)
	Arm4:HideBone(8, true)
	Arm4:HideBone(9, true)	
	Arm4:HideBone(10, true)	
	Arm4:HideBone(11, true)

	Arm4Weapon1 = Arm4:GetWeapon(1)
	Arm4Weapon1:SetFiringRandomness(0.0)
	Arm4Weapon1:ChangeRateOfFire(10 * Stage)
	Arm4Weapon1:ChangeMaxRadius(20 * Stage)
	Arm4Weapon1:AddDamageMod(125 * DificultyMultiplier * DamageMultiplier * Stage)

	local OldCreateProjectileAtMuzzle = Arm3Weapon1.CreateProjectileAtMuzzle
	function CustomCreateProjectileAtMuzzle(self, muzzle)
		local Projectile = OldCreateProjectileAtMuzzle(self, muzzle)
		Projectile:SetLifetime(10)		
	end
	Arm3Weapon1.CreateProjectileAtMuzzle = CustomCreateProjectileAtMuzzle
	Arm4Weapon1.CreateProjectileAtMuzzle = CustomCreateProjectileAtMuzzle

    KillUnitThread(MainUnit, Arm3)
    KillUnitThread(MainUnit, Arm4)
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