-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

function CreateModule(Army, MainUnit, Position, HealthMultiplier, DamageMultiplier, DificultyMultiplier, Stage)
	--TransportShips on legs
	-----------------------------------------------------------------------------------------------
	Leg1 = CreateUnitHPR('UAA0104', Army, Position[1], Position[2], Position[3], 1, 0, 0)
	Leg1:SetCustomName("LegArmor1")
	Leg1:SetMaxHealth((Stage * 4) * ((2700 * HealthMultiplier) * DificultyMultiplier))
	Leg1:SetHealth(nil, (Stage * 4) * ((2700 * HealthMultiplier) * DificultyMultiplier))
	Leg1:AttachTo(MainUnit, 'Left_Footfall')
	-----------------------------------------------------------------------------------------------
	Leg2 = CreateUnitHPR('UAA0104', Army, Position[1], Position[2], Position[3], 1, 0, 0)
	Leg2:SetCustomName("LegArmor2")
	Leg2:SetMaxHealth((Stage * 4) * ((2700 * HealthMultiplier) * DificultyMultiplier))
	Leg2:SetHealth(nil, (Stage * 4) * ((2700 * HealthMultiplier) * DificultyMultiplier))
	Leg2:AttachTo(MainUnit, 'Right_Footfall')

    KillUnitThread(MainUnit, Leg1)
    KillUnitThread(MainUnit, Leg2)
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