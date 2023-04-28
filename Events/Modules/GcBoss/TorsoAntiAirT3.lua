-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

function CreateModule(Army, MainUnit, Position, HealthMultiplier, DamageMultiplier, DificultyMultiplier, Stage)
	-- Sam in Torso
    local Count = 2 * Stage
    for _ = 1, Count do
	    Torso2 = CreateUnitHPR('UAB2304', Army, Position[1], Position[2], Position[3], 1, 0, 0)
	    Torso2.ImmuneToStun = true
	    Torso2:SetCustomName("ArtyModule")
	    Torso2:AttachTo(MainUnit, 'Torso')
	    Torso2:SetCanBeKilled(false)
	    Torso2:SetDoNotTarget(true)
	    Torso2:GetWeaponCount()
	    Torso2Weapon1 = Torso2:GetWeapon(1)
	    Torso2Weapon1:SetFiringRandomness(0.0)
	    Torso2Weapon1:ChangeRateOfFire(50)
	    Torso2Weapon1:ChangeMaxRadius(100)
	    Torso2Weapon1:AddDamageMod(75 * DificultyMultiplier * DamageMultiplier)

	    local OldCreateProjectileAtMuzzle = Torso2Weapon1.CreateProjectileAtMuzzle
	    function CustomCreateProjectileAtMuzzle(self, muzzle)
	    	local Projectile = OldCreateProjectileAtMuzzle(self, muzzle)
	    	Projectile:SetLifetime(20)		
	    end
	    Torso2Weapon1.CreateProjectileAtMuzzle = CustomCreateProjectileAtMuzzle

        KillUnitThread(MainUnit, Torso2)
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