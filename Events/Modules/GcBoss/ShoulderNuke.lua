-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')

local NukeLauncherThreadActive = false

function CreateModule(Army, MainUnit, Position, HealthMultiplier, DamageMultiplier, DificultyMultiplier, Stage)
	--NukeLaunchers on Shoulders
	-----------------------------------------------------------------------------------------------
	LeftShoulderNukeLauncher1 = CreateUnitHPR('UAB2305', Army, Position[1], Position[2], Position[3], 0, 0, 0)
	LeftShoulderNukeLauncher1.ImmuneToStun = true
	LeftShoulderNukeLauncher1:SetMaxHealth(69)
    LeftShoulderNukeLauncher1:SetDoNotTarget(true)
    LeftShoulderNukeLauncher1:SetCanBeKilled(false)
	LeftShoulderNukeLauncher1:SetCustomName("LeftNukeLauncher")
	LeftShoulderNukeLauncher1:AttachTo(MainUnit, 'Left_Arm_B01')
	-----------------------------------------------------------------------------------------------
	RightShoulderNukeLauncher1 = CreateUnitHPR('UAB2305', Army, Position[1], Position[2], Position[3], 0, 0, 0)
	RightShoulderNukeLauncher1.ImmuneToStun = true
	RightShoulderNukeLauncher1:SetMaxHealth(69)
    RightShoulderNukeLauncher1:SetDoNotTarget(true)
    RightShoulderNukeLauncher1:SetCanBeKilled(false)
	RightShoulderNukeLauncher1:SetCustomName("RightModuleNukeLauncher")
	RightShoulderNukeLauncher1:AttachTo(MainUnit, 'Right_Arm_B01')
	-----------------------------------------------------------------------------------------------
	LeftShoulderNukeLauncher2 = CreateUnitHPR('UAB2305', Army, Position[1], Position[2], Position[3], 0, 0, 0)
	LeftShoulderNukeLauncher2.ImmuneToStun = true
	LeftShoulderNukeLauncher2:SetMaxHealth(69)
    LeftShoulderNukeLauncher2:SetDoNotTarget(true)
    LeftShoulderNukeLauncher2:SetCanBeKilled(false)
	LeftShoulderNukeLauncher2:SetCustomName("LeftNukeLauncher")
	LeftShoulderNukeLauncher2:AttachTo(MainUnit, 'Left_Arm_B01')
	-----------------------------------------------------------------------------------------------
	RightShoulderNukeLauncher2 = CreateUnitHPR('UAB2305', Army, Position[1], Position[2], Position[3], 0, 0, 0)
	RightShoulderNukeLauncher2.ImmuneToStun = true
	RightShoulderNukeLauncher2:SetMaxHealth(69)
    RightShoulderNukeLauncher2:SetDoNotTarget(true)
    RightShoulderNukeLauncher2:SetCanBeKilled(false)
	RightShoulderNukeLauncher2:SetCustomName("RightModuleNukeLauncher")
	RightShoulderNukeLauncher2:AttachTo(MainUnit, 'Right_Arm_B01')
	-----------------------------------------------------------------------------------------------

    FireNukeLaunchersThread(MainUnit)

    KillUnitThread(MainUnit, LeftShoulderNukeLauncher1)
    KillUnitThread(MainUnit, RightShoulderNukeLauncher1)
    KillUnitThread(MainUnit, LeftShoulderNukeLauncher2)
    KillUnitThread(MainUnit, RightShoulderNukeLauncher2)
end

function FireNukeLaunchersThread(MainUnit)
	
	local Interval = 180 / (ScenarioInfo.Options.Option_PlatoonWaveCount * ScenarioInfo.Options.Option_HealthMultiplier)

	ForkThread(function()
		WaitSeconds(20)
		LOG("AeonBoss: Nuke Interval: " ..  repr(Interval))
		while true do
			if not MainUnit:IsDead() then
				LeftShoulderNukeLauncher1:GiveNukeSiloAmmo(1)
				RightShoulderNukeLauncher1:GiveNukeSiloAmmo(1)
                LeftShoulderNukeLauncher2:GiveNukeSiloAmmo(1)
				RightShoulderNukeLauncher2:GiveNukeSiloAmmo(1)

				IssueNuke({LeftShoulderNukeLauncher1}, ScenarioUtils.MarkerToPosition('defenceobject-1'))
				IssueNuke({RightShoulderNukeLauncher1}, ScenarioUtils.MarkerToPosition('defenceobject-1'))
				WaitSeconds(Interval)
                IssueNuke({LeftShoulderNukeLauncher2}, ScenarioUtils.MarkerToPosition('defenceobject-1'))
				IssueNuke({RightShoulderNukeLauncher2}, ScenarioUtils.MarkerToPosition('defenceobject-1'))
				WaitSeconds(Interval)
			end
			if MainUnit:IsDead() then
				break
			end
		WaitSeconds(0.25)
		end
	end)
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