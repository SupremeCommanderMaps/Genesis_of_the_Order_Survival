-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

function CreateModule(Army, MainUnit, Position, HealthMultiplier, DamageMultiplier, DificultyMultiplier, Stage)
	-- Shield Disruptor on Head
	-----------------------------------------------------------------------------------------------
	Head1 = CreateUnitHPR('DAL0310', Army, Position[1], Position[2], Position[3], 1, 0, 0)
	Head1.ImmuneToStun = true
	Head1:SetCustomName("ShieldDisruptorModule")
	Head1:AttachTo(MainUnit, 'Head')
	Head1:SetCanBeKilled(false)
	Head1:SetDoNotTarget(true)
	
	Head1:GetWeaponCount()
	Head1Weapon1 = Head1:GetWeapon(1)
	Head1Weapon1:SetFiringRandomness(0.0)
	Head1Weapon1:ChangeRateOfFire(10)
	Head1Weapon1:ChangeMaxRadius(88)

	Head1Weapon1:AddDamageMod(1250 * DificultyMultiplier * DamageMultiplier)

    KillUnitThread(MainUnit, Head1)
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