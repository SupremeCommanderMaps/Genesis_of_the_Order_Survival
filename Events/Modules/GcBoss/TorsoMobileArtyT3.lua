-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

function CreateModule(Army, MainUnit, Position, HealthMultiplier, DamageMultiplier, DificultyMultiplier, Stage)
    -- Mobile Arty in Torso. Made a Thread for rebuilding arty for alternative to Torso1Weapon1:OnEnableWeapon(Torso1Weapon1:ResetTarget())
    -- Hopefully faster retargeting
	-----------------------------------------------------------------------------------------------
    CreateArtyThread(Army, MainUnit, Position, HealthMultiplier, DamageMultiplier, DificultyMultiplier, Stage)
end

function CreateArtyThread(Army, MainUnit, Position, HealthMultiplier, DamageMultiplier, DificultyMultiplier, Stage)
    ForkThread(function()
        while true do 
            WaitSeconds(0.1)
	        ArtyPriorityTable = {'STRUCTURE', 'ALLUNITS'}

	        Torso1 = CreateUnitHPR('UAL0304', Army, Position[1], Position[2], Position[3], 1, 0, 0)
	        Torso1.ImmuneToStun = true
	        Torso1:SetCustomName("ArtyModule")
	        Torso1:AttachTo(MainUnit, 'Torso')
	        Torso1:SetCanBeKilled(false)
	        Torso1:SetDoNotTarget(true)
	        Torso1:GetWeaponCount()
	        Torso1Weapon1 = Torso1:GetWeapon(1)
	        Torso1Weapon1:SetFiringRandomness(10.0)
	        Torso1Weapon1:ChangeRateOfFire(12)
	        Torso1Weapon1:ChangeMaxRadius(117)
	        Torso1Weapon1:ChangeMinRadius(4)
	        Torso1Weapon1:SetWeaponPriorities(ArtyPriorityTable)

	        local OldCreateProjectileAtMuzzle = Torso1Weapon1.CreateProjectileAtMuzzle
	        function CustomCreateProjectileAtMuzzle(self, muzzle)
	        	local Projectile = OldCreateProjectileAtMuzzle(self, muzzle)
	        	Projectile:SetLifetime(20)		
	        end
	        Torso1Weapon1.CreateProjectileAtMuzzle = CustomCreateProjectileAtMuzzle
        
	        Torso1Weapon1:AddDamageMod(250 * DificultyMultiplier * DamageMultiplier)
            KillUnitThread(MainUnit, Torso1)
            WaitSeconds(10)
            if not Torso1:IsDead() then
                Torso1:SetCanBeKilled(true)
                KillUnit(Torso1)
            end
        end
    end)
end

function KillUnitThread(MainUnit, AttachedUnit)
    ForkThread(function()
        while true do 
            WaitSeconds(0.5)
            if AttachedUnit:IsDead() then
                break
            end
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