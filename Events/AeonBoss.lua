-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local Utilities = import('/lua/utilities.lua')

local AeonBoss = import(ScenarioInfo.MapPath .. 'Events/AeonBoss.lua')

local GameSetup = import(ScenarioInfo.MapPath .. 'Functionality/GameSetup.lua')

local DialogueList = import(ScenarioInfo.MapPath .. 'Resources/DialogueList.lua')

local CircularPointGenerator = import(ScenarioInfo.MapPath .. 'Utilities/CircularPointGenerator.lua')
local PlayDialogue = import(ScenarioInfo.MapPath .. 'Utilities/PlayDialogue.lua')
local Markers = import(ScenarioInfo.MapPath .. 'Utilities/Markers.lua')
local PlatoonOrders = import(ScenarioInfo.MapPath .. 'Utilities/PlatoonOrders.lua')
local UnitCreator = import(ScenarioInfo.MapPath .. 'Utilities/UnitCreator.lua')


BossDeath = 0



local PlayerArmies = GameSetup.PlayerArmies

local DificultyMultiplier = (ScenarioInfo.Options.Option_PlatoonWaveCount * 0.5)
local HealthMultiplier = ScenarioInfo.Options.Option_HealthMultiplier
local DamageMultiplier = ScenarioInfo.Options.Option_DamageMultiplier
local Scaling = 1
local Stage = 1 --[[Default = 1]]--


local SetCanBeKilledTable = { }

local ShieldBlueprint = {
	ImpactEffects = 'SeraphimShieldHit01',
	ImpactMesh = '/effects/entities/ShieldSection01/ShieldSection01_mesh',
	Mesh = '/effects/entities/cybranphalanxsphere01/cybranphalanxsphere01_mesh',
	MeshZ = '/effects/entities/Shield01/Shield01z_mesh',
	RegenAssistMult = 60,
	ShieldEnergyDrainRechargeTime = 60,
	ShieldMaxHealth = 4000 * HealthMultiplier * DificultyMultiplier,
	ShieldRechargeTime = 20,
	ShieldRegenRate = 100,
	ShieldSize = 11,
	ShieldVerticalOffset = 0.0,
}

local FinalDestination = ScenarioUtils.MarkerToPosition('defenceobject-1')

local Location1 = Markers.GetRandomPosition(Markers.PathWay)
local Location2 = Markers.GetRandomPosition(Markers.PathWay)
local Location3 = Markers.GetRandomPosition(Markers.PathWay)
local Location4 = Markers.GetRandomPosition(Markers.PathWay)
local Location5 = Markers.GetRandomPosition(Markers.PathWay)
local Location6 = Markers.GetRandomPosition(Markers.PathWay)


local BuildTime = ScenarioInfo.Options.Option_BuildTime

local TimeSpawnBoss1 = Utilities.GetRandomInt(8.0 * 60, 9.0 * 60)
local TimeSpawnBoss2 = Utilities.GetRandomInt(15.5 * 60, 18.0 * 60)
local TimeSpawnBoss3 = Utilities.GetRandomInt(27.5 * 60, 28.0 * 60)


function LittleBehemoth()
 	ScenarioFramework.CreateTimerTrigger(SpawnBoss, BuildTime + TimeSpawnBoss1, false) -- TimeSpawnBoss1
	ScenarioFramework.CreateTimerTrigger(SpawnBoss, BuildTime + TimeSpawnBoss2, false) -- TimeSpawnBoss2
	ScenarioFramework.CreateTimerTrigger(SpawnBoss, BuildTime + TimeSpawnBoss3, false) -- TimeSpawnBoss3
end

function SpawnBoss()
	local SpawnLocation = Markers.GetRandomPosition(Markers.LandSpawn)


	-- Main Unit
	local EndBossUnitBp = 'ual0401'
	local Army = "ARMY_ENEMY_AEON_BOSS"
	local Position = ScenarioUtils.MarkerToPosition("prop-3")

	EndBoss = CreateUnitHPR(EndBossUnitBp, Army, SpawnLocation[1], SpawnLocation[2], SpawnLocation[3], 0, 0, 0)
	EndBoss:SetReclaimable(false)
	EndBoss.ImmuneToStun = true
	
	EndBoss:SetVeterancy(1)
	EndBoss:SetVeterancy(1)
	EndBoss:SetVeterancy(1)
	EndBoss:SetVeterancy(1)
	EndBoss:SetVeterancy(1)

	EndBoss:SetSpeedMult(0.85)

	EndBoss:SetIntelRadius('Omni', 500)
	EndBoss:SetCustomName("For the Order")
	
	IssueAggressiveMove({EndBoss}, Location1)
	IssueAggressiveMove({EndBoss}, Location2)
	IssueAggressiveMove({EndBoss}, Location3)
	IssueAggressiveMove({EndBoss}, Location4)
	IssueAggressiveMove({EndBoss}, Location5)
	IssueAggressiveMove({EndBoss}, Location6)
	IssueAggressiveMove({EndBoss}, FinalDestination)

	if Stage == 1 then
		EndBoss:SetMaxHealth((20000 * HealthMultiplier) * DificultyMultiplier)
		EndBoss:SetHealth(nil, EndBoss:GetMaxHealth())
		EndBoss:SetRegen(5 * HealthMultiplier * DificultyMultiplier)

		EndBoss:SetAllWeaponsEnabled()
		LegModule(Army, Position)				--TransportShipArmor
		ArmModule(Army, Position)				--Tanks
		ShoulderModule2(Army, Position) 		--AntiAir


		EndBossThread(Stage)					--MainThread
		ShieldThread()							--ShieldThread
		DistanceCheckToDefenceObject()			--DistanceThread

		CreateVisibleAreaAtUnit(20, EndBoss, 0, PlayerArmies)
	end
	if Stage == 2 then
		EndBoss:SetMaxHealth((80000 * HealthMultiplier) * DificultyMultiplier)
		EndBoss:SetHealth(nil, EndBoss:GetMaxHealth())
		EndBoss:SetRegen(50 * HealthMultiplier * DificultyMultiplier)

		LegModule(Army, Position)				--TransportShipArmor
		ArmModule(Army, Position)				--Tanks
		ShoulderModule2(Army, Position) 		--AntiAir
		HeadModule(Army, Position)				--ShielDisruptor

		EndBossThread(Stage)					--MainThread
		DistanceCheckToDefenceObject()			--DistanceThread

		CreateVisibleAreaAtUnit(20, EndBoss, 0, PlayerArmies)
	end
	if Stage >= 3 then
		EndBoss:SetMaxHealth((300000 * HealthMultiplier) * DificultyMultiplier)
		EndBoss:SetHealth(nil, EndBoss:GetMaxHealth())
		EndBoss:SetRegen(250 * HealthMultiplier * DificultyMultiplier)

		LegModule(Army, Position)				--TransportShipArmor
		ArmModule(Army, Position)				--Tanks
		TorsoModule(Army, Position)				--Arty
		TorsoModule2(Army, Position)			--AntiAirSam
		ShoulderModule1(Army, Position)			--Nuke
		ShoulderModule2(Army, Position) 		--AntiAir
		HeadModule(Army, Position)				--ShielDisruptor
	

		EndBossThread(Stage)					--MainThread
		ProtectionStormThread(Army)				--RegenStorm
		NukeLaunchersThread()					--NukeThread
		DistanceCheckToDefenceObject()			--DistanceThread

		if ScenarioInfo.Options.Option_PlatoonWaveCount == 3 then
			ArmModule(Army, Position)			--Tanks
		end

		CreateVisibleAreaAtUnit(20, EndBoss, 0, PlayerArmies)

		ForkThread(function()
			WaitSeconds(90)
			PlayDialogue.Dialogue(DialogueList.Gary_6, nil, false) -- ZanGoattheZeGary: Language Not Recognized
		end)
	end


	--LegModule(Army, Position)					--TransportShipArmor
	--ArmModule(Army, Position)					--Tanks
	--TorsoModule(Army, Position)				--Arty
	--ShoulderModule1(Army, Position)			--Nuke
	--ShoulderModule2(Army, Position) 			--AntiAir
	--HeadModule(Army, Position)				--ShielDisruptor

	--EndBossThread()							--MainThread
	--ProtectionStormThread(Army)				--RegenStorm
	--NukeLaunchersThread()						--NukeThread
	--ShieldThread()							--ShieldThread
	
	
	Stage = Stage + 1


end


function LegModule(Army, Position)
	--TransportShips on legs
	-----------------------------------------------------------------------------------------------
	Leg1 = CreateUnitHPR('UAA0104', Army, Position[1], Position[2], Position[3], 1, 0, 0)
	Leg1:SetCustomName("LegArmor1")
	Leg1:SetMaxHealth((Stage * 4) * ((2700 * HealthMultiplier) * DificultyMultiplier))
	Leg1:SetHealth(nil, (Stage * 4) * ((2700 * HealthMultiplier) * DificultyMultiplier))
	Leg1:AttachTo(EndBoss, 'Left_Footfall')
	-----------------------------------------------------------------------------------------------
	Leg2 = CreateUnitHPR('UAA0104', Army, Position[1], Position[2], Position[3], 1, 0, 0)
	Leg2:SetCustomName("LegArmor2")
	Leg2:SetMaxHealth((Stage * 4) * ((2700 * HealthMultiplier) * DificultyMultiplier))
	Leg2:SetHealth(nil, (Stage * 4) * ((2700 * HealthMultiplier) * DificultyMultiplier))
	Leg2:AttachTo(EndBoss, 'Right_Footfall')
	
	table.insert(SetCanBeKilledTable, Leg1)
	table.insert(SetCanBeKilledTable, Leg2)
end

function ArmModule(Army, Position)
	--Tanks on Arms
	-----------------------------------------------------------------------------------------------
	Arm1 = CreateUnitHPR('UAL0202', Army, Position[1], Position[2], Position[3], 1, 0, 0)
	Arm1:SetCustomName("LefttArmModule")
	Arm1.ImmuneToStun = true
	Arm1.MyShield:TurnOff()
	Arm1:SetCanBeKilled(false)
	Arm1:SetCanTakeDamage(false)
	Arm1:SetDoNotTarget(true)
	Arm1:AttachTo(EndBoss, 'Left_Arm_Muzzle01')
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
	Arm2:AttachTo(EndBoss, 'Right_Arm_Muzzle01')
	Arm2:GetWeaponCount()
	Arm2Weapon1 = Arm2:GetWeapon(1)
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

	table.insert(SetCanBeKilledTable, Arm1)
	table.insert(SetCanBeKilledTable, Arm2)
end


function TorsoModule(Army, Position)
	-- Mobile Arty in Torso
	-----------------------------------------------------------------------------------------------
	ArtyPriorityTable = {'STRUCTURE', 'ALLUNITS'}

	Torso1 = CreateUnitHPR('UAL0304', Army, Position[1], Position[2], Position[3], 1, 0, 0)
	Torso1.ImmuneToStun = true
	Torso1:SetCustomName("ArtyModule")
	Torso1:AttachTo(EndBoss, 'Torso')
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

	table.insert(SetCanBeKilledTable, Torso1)
end

function TorsoModule2(Army, Position)
	-- Sam in Torso
	-----------------------------------------------------------------------------------------------
	Torso2 = CreateUnitHPR('UAB2304', Army, Position[1], Position[2], Position[3], 1, 0, 0)
	Torso2.ImmuneToStun = true
	Torso2:SetCustomName("ArtyModule")
	Torso2:AttachTo(EndBoss, 'Torso')
	Torso2:SetCanBeKilled(false)
	Torso2:SetDoNotTarget(true)
	Torso2:GetWeaponCount()
	Torso2Weapon1 = Torso2:GetWeapon(1)
	Torso2Weapon1:SetFiringRandomness(0.0)
	Torso2Weapon1:ChangeRateOfFire(50)
	Torso2Weapon1:ChangeMaxRadius(100)
	Torso2Weapon1:AddDamageMod(105 * DificultyMultiplier * DamageMultiplier)

	table.insert(SetCanBeKilledTable, Torso2)
end

function ShoulderModule1(Army, Position)
	--NukeLaunchers on Shoulders
	-----------------------------------------------------------------------------------------------
	LeftShoulderNukeLauncher1 = CreateUnitHPR('UAB2305', Army, Position[1], Position[2], Position[3], 0, 0, 0)
	LeftShoulderNukeLauncher1.ImmuneToStun = true
	LeftShoulderNukeLauncher1:SetMaxHealth(69)
    LeftShoulderNukeLauncher1:SetDoNotTarget(true)
    LeftShoulderNukeLauncher1:SetCanBeKilled(false)
	LeftShoulderNukeLauncher1:SetCustomName("LeftNukeLauncher1")
	LeftShoulderNukeLauncher1:AttachTo(EndBoss, 'Left_Arm_B01')
	-----------------------------------------------------------------------------------------------
	LeftShoulderNukeLauncher2 = CreateUnitHPR('UAB2305', Army, Position[1], Position[2], Position[3], 0, 0, 0)
	LeftShoulderNukeLauncher2.ImmuneToStun = true
	LeftShoulderNukeLauncher2:SetMaxHealth(69)
    LeftShoulderNukeLauncher2:SetDoNotTarget(true)
    LeftShoulderNukeLauncher2:SetCanBeKilled(false)
	LeftShoulderNukeLauncher2:SetCustomName("LeftNukeLauncher2")
	LeftShoulderNukeLauncher2:AttachTo(EndBoss, 'Left_Arm_B01')
	-----------------------------------------------------------------------------------------------
	LeftShoulderNukeLauncher3 = CreateUnitHPR('UAB2305', Army, Position[1], Position[2], Position[3], 0, 0, 0)
	LeftShoulderNukeLauncher3.ImmuneToStun = true
	LeftShoulderNukeLauncher3:SetMaxHealth(69)
    LeftShoulderNukeLauncher3:SetDoNotTarget(true)
    LeftShoulderNukeLauncher3:SetCanBeKilled(false)
	LeftShoulderNukeLauncher3:SetCustomName("leftNukeLauncher3")
	LeftShoulderNukeLauncher3:AttachTo(EndBoss, 'Left_Arm_B01')
	-----------------------------------------------------------------------------------------------
	LeftShoulderNukeLauncher4 = CreateUnitHPR('UAB2305', Army, Position[1], Position[2], Position[3], 0, 0, 0)
	LeftShoulderNukeLauncher4.ImmuneToStun = true
	LeftShoulderNukeLauncher4:SetMaxHealth(69)
    LeftShoulderNukeLauncher4:SetDoNotTarget(true)
    LeftShoulderNukeLauncher4:SetCanBeKilled(false)
	LeftShoulderNukeLauncher4:SetCustomName("LeftNukeLauncher4")
	LeftShoulderNukeLauncher4:AttachTo(EndBoss, 'Left_Arm_B01')
	-----------------------------------------------------------------------------------------------
	RightShoulderNukeLauncher1 = CreateUnitHPR('UAB2305', Army, Position[1], Position[2], Position[3], 0, 0, 0)
	RightShoulderNukeLauncher1.ImmuneToStun = true
	RightShoulderNukeLauncher1:SetMaxHealth(69)
    RightShoulderNukeLauncher1:SetDoNotTarget(true)
    RightShoulderNukeLauncher1:SetCanBeKilled(false)
	RightShoulderNukeLauncher1:SetCustomName("RightModuleNukeLauncher1")
	RightShoulderNukeLauncher1:AttachTo(EndBoss, 'Right_Arm_B01')
	-----------------------------------------------------------------------------------------------
	RightShoulderNukeLauncher2 = CreateUnitHPR('UAB2305', Army, Position[1], Position[2], Position[3], 0, 0, 0)
	RightShoulderNukeLauncher2.ImmuneToStun = true
	RightShoulderNukeLauncher2:SetMaxHealth(69)
    RightShoulderNukeLauncher2:SetDoNotTarget(true)
    RightShoulderNukeLauncher2:SetCanBeKilled(false)
	RightShoulderNukeLauncher2:SetCustomName("RightModuleNukeLauncher2")
	RightShoulderNukeLauncher2:AttachTo(EndBoss, 'Right_Arm_B01')
	-----------------------------------------------------------------------------------------------
	RightShoulderNukeLauncher3 = CreateUnitHPR('UAB2305', Army, Position[1], Position[2], Position[3], 0, 0, 0)
	RightShoulderNukeLauncher3.ImmuneToStun = true
	RightShoulderNukeLauncher3:SetMaxHealth(69)
    RightShoulderNukeLauncher3:SetDoNotTarget(true)
    RightShoulderNukeLauncher3:SetCanBeKilled(false)
	RightShoulderNukeLauncher3:SetCustomName("RightModuleNukeLauncher3")
	RightShoulderNukeLauncher3:AttachTo(EndBoss, 'Right_Arm_B01')
	-----------------------------------------------------------------------------------------------
	RightShoulderNukeLauncher4 = CreateUnitHPR('UAB2305', Army, Position[1], Position[2], Position[3], 0, 0, 0)
	RightShoulderNukeLauncher4.ImmuneToStun = true
	RightShoulderNukeLauncher4:SetMaxHealth(69)
    RightShoulderNukeLauncher4:SetDoNotTarget(true)
    RightShoulderNukeLauncher4:SetCanBeKilled(false)
	RightShoulderNukeLauncher4:SetCustomName("RightModuleNukeLauncher4")
	RightShoulderNukeLauncher4:AttachTo(EndBoss, 'Right_Arm_B01')

	table.insert(SetCanBeKilledTable, LeftShoulderNukeLauncher1)
	table.insert(SetCanBeKilledTable, LeftShoulderNukeLauncher2)
	table.insert(SetCanBeKilledTable, LeftShoulderNukeLauncher3)
	table.insert(SetCanBeKilledTable, LeftShoulderNukeLauncher4)
	table.insert(SetCanBeKilledTable, RightShoulderNukeLauncher1)
	table.insert(SetCanBeKilledTable, RightShoulderNukeLauncher2)
	table.insert(SetCanBeKilledTable, RightShoulderNukeLauncher3)
	table.insert(SetCanBeKilledTable, RightShoulderNukeLauncher4)
end

function ShoulderModule2(Army, Position)
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
		Shoulder1:AttachTo(EndBoss, 'Left_Arm_B01')
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

		table.insert(SetCanBeKilledTable, Shoulder1)
	end
	-----------------------------------------------------------------------------------------------
	for _ = 1, Count do
		Shoulder2 = CreateUnitHPR('UAL0205', Army, Position[1], Position[2], Position[3], 1, 0, 0)
		Shoulder2.ImmuneToStun = true
		Shoulder2:SetCustomName("RightShoulderAAModule")
		Shoulder2:SetCanBeKilled(false)
		Shoulder2:SetCanTakeDamage(false)
		Shoulder2:SetDoNotTarget(true)
		Shoulder2:AttachTo(EndBoss, 'Right_Arm_B01')
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

		table.insert(SetCanBeKilledTable, Shoulder2)
	end
end

function HeadModule(Army, Position)
	-- Shield Disruptor on Head
	-----------------------------------------------------------------------------------------------
	Head1 = CreateUnitHPR('DAL0310', Army, Position[1], Position[2], Position[3], 1, 0, 0)
	Head1.ImmuneToStun = true
	Head1:SetCustomName("ShieldDisruptorModule")
	Head1:AttachTo(EndBoss, 'Head')
	Head1:SetCanBeKilled(false)
	Head1:SetDoNotTarget(true)
	
	Head1:GetWeaponCount()
	Head1Weapon1 = Head1:GetWeapon(1)
	Head1Weapon1:SetFiringRandomness(0.0)
	Head1Weapon1:ChangeRateOfFire(10)
	Head1Weapon1:ChangeMaxRadius(88)

	Head1Weapon1:AddDamageMod(1250 * DificultyMultiplier * DamageMultiplier)

	table.insert(SetCanBeKilledTable, Head1)

end



function EndBossThread(Stage)
	ForkThread(
		function()
			if Stage == 1 then
				PlayDialogue.Dialogue(DialogueList.Custom_Gari_5, nil, false) -- Gari: You are an abomination. I will take great pleasure in exterminating you.
				PlayDialogue.Dialogue(DialogueList.Astrox_1, nil, false) -- Astrox Hall: Commander, defeat the Order commander ASAP! Hall out.
			end
			if Stage == 2 then
				PlayDialogue.Dialogue(DialogueList.Custom_Gari_4, nil, false) -- Gari: The Order is eternal. There is no stopping us.
				PlayDialogue.Dialogue(DialogueList.Jip_10, nil, false) -- Jip: You waiting for that scumbag to come over and introduce himself? Attack and destroy him.
			end
			if Stage == 3 then
				PlayDialogue.Dialogue(DialogueList.Custom_Gari_6, nil, false) -- Gari: Now you will taste the fury of the Order of the Illuminate.
				WaitSeconds(20)
				PlayDialogue.Dialogue(DialogueList.Jip_7, nil, false) -- Jip: I see it! Commander, hit that thing with whatever you've got!							
			end



    		while true do

    		    local POS = EndBoss:GetPosition()
				--ScenarioFramework.CreateVisibleAreaLocation(vizRadius, vizLocation, vizLifetime, vizArmy)

				if EndBoss:IsDead() then
					if Stage == 2 then
						PlayDialogue.Dialogue(DialogueList.Jip_8, nil, false) -- Jip: You looking for a medal or something? This fight ain't over yet.
					end
					if Stage == 3 then
						PlayDialogue.Dialogue(DialogueList.Custom_Gari_3, nil, false) -- Gari: Ha-ha-ha!
						PlayDialogue.Dialogue(DialogueList.Custom_Gari_7, nil, false) -- Gari: You may have stopped me, but you have no hope of defeating the Seraphim.

						PlayDialogue.Dialogue(DialogueList.Gary_8, nil, false) -- ZanGoattheZeGary: Humanity's time is at an end. You will be rendered extinct.

						BossDeath = BossDeath + 1
					end
				
				
					for Every, Unit in SetCanBeKilledTable do 
						Unit:SetCanBeKilled(true)
					end

					if Stage == 3 then
						Paragon = CreateUnitHPR('XAB1401', "ARMY_ENEMY_AEON", POS[1], POS[2], POS[3], 0, 0, 0)
						IssueKillSelf({Paragon})
					end

					WaitSeconds(5.5)
					for Every, Unit in SetCanBeKilledTable do 
						if not IsDestroyed(Unit) then
							Unit:DestroyUnit()
						end
					end			
					break
				end 
    		WaitSeconds(0.5)
    		end
		end)
end 

function ProtectionStormThread(Army)

	local UnitTable = {'xsl0402'}
	local CircleSpawnPoints = (8 * DificultyMultiplier)
	local CircleRadius = 22

	local MinHealth = (EndBoss:GetMaxHealth() * 0.55)

	local CountTillMove = 0

	local StormHasBinActive = false

	ForkThread(
		function()
			while true do
				if EndBoss:IsDead() then
					break
				end
				local CurrentHealth = EndBoss:GetHealth()
				local CircleCenter = EndBoss:GetPosition()
				local ProtectionStormCount = 1

				if CurrentHealth < MinHealth  then
					

					if StormHasBinActive == false then
						PlayDialogue.Dialogue(DialogueList.Jip_9, nil, false)
						CircularPointGenerator.CircularSpawner(UnitTable, Army, CircleSpawnPoints, CircleRadius, CircleCenter)
						StormHasBinActive = true
					end
					
					IssueClearCommands({EndBoss})

					local UnitTable = "xsl0402"
					local OldDoTakeDamage = EndBoss.DoTakeDamage
					function CustomDoTakeDamge(self, instagator, amount, vector, damageType)

						local ArmyInQuestion = instagator:GetArmy()

						OldDoTakeDamage(self, instagator, amount, vector, damageType)

						if GetArmyBrain(ArmyInQuestion).Name == Army then
							if instagator:GetBlueprint().BlueprintId == UnitTable then
								self:AdjustHealth(instagator, 50)
							end
						end
					end
					EndBoss.DoTakeDamage = CustomDoTakeDamge





				end

				if StormHasBinActive == true then
					CountTillMove = CountTillMove + 1
				end


				if CountTillMove == 40 then


					IssueAggressiveMove({EndBoss}, Location1)
					IssueAggressiveMove({EndBoss}, Location2)
					IssueAggressiveMove({EndBoss}, Location3)
					IssueAggressiveMove({EndBoss}, Location4)
					IssueAggressiveMove({EndBoss}, Location5)
					IssueAggressiveMove({EndBoss}, Location6)
					IssueAggressiveMove({EndBoss}, FinalDestination)
					break
				end

				WaitSeconds(0.5)
			end
		end)
end

function NukeLaunchersThread()
	
	local Interval = 180 / (ScenarioInfo.Options.Option_PlatoonWaveCount * ScenarioInfo.Options.Option_HealthMultiplier)

	ForkThread(
		function()
			WaitSeconds(20)
			LOG("IntervalCheck" ..  repr(Interval))
			while true do
				if not EndBoss:IsDead() then
					local POS = EndBoss:GetPosition()
				
					LeftShoulderNukeLauncher1:GiveNukeSiloAmmo(1)
					LeftShoulderNukeLauncher2:GiveNukeSiloAmmo(1)
					LeftShoulderNukeLauncher3:GiveNukeSiloAmmo(1)
					LeftShoulderNukeLauncher4:GiveNukeSiloAmmo(1)
				
					RightShoulderNukeLauncher1:GiveNukeSiloAmmo(1)
					RightShoulderNukeLauncher2:GiveNukeSiloAmmo(1)
					RightShoulderNukeLauncher3:GiveNukeSiloAmmo(1)
					RightShoulderNukeLauncher4:GiveNukeSiloAmmo(1)
				
					IssueNuke({LeftShoulderNukeLauncher1}, ScenarioUtils.MarkerToPosition('defenceobject-1'))
					IssueNuke({RightShoulderNukeLauncher1}, ScenarioUtils.MarkerToPosition('defenceobject-1'))
					WaitSeconds(Interval)
					IssueNuke({LeftShoulderNukeLauncher2}, ScenarioUtils.MarkerToPosition('defenceobject-1'))
					IssueNuke({RightShoulderNukeLauncher2}, ScenarioUtils.MarkerToPosition('defenceobject-1'))
					WaitSeconds(Interval)
					IssueNuke({LeftShoulderNukeLauncher3}, ScenarioUtils.MarkerToPosition('defenceobject-1'))
					IssueNuke({RightShoulderNukeLauncher3}, ScenarioUtils.MarkerToPosition('defenceobject-1'))
					WaitSeconds(Interval)
					IssueNuke({LeftShoulderNukeLauncher4}, ScenarioUtils.MarkerToPosition('defenceobject-1'))
					IssueNuke({RightShoulderNukeLauncher4}, ScenarioUtils.MarkerToPosition('defenceobject-1'))
					WaitSeconds(Interval)
				end
				if EndBoss:IsDead() then
					break
				end
			WaitSeconds(0.25)
			end
		end)
end

function ShieldThread()
	EndBoss:CreateShield(ShieldBlueprint)
	EndBoss:ShieldIsOn()

	ForkThread(
		function()
			while true do 
				if EndBoss:IsDead() then

					break
				end
				if EndBoss:ShieldIsOn() == false then

					WaitSeconds(30)
					EndBoss:ShieldIsOn()
					EndBoss:CreateShield(ShieldBlueprint)
				end
				WaitSeconds(0.5)
			end
		end)

end

function CreateVisibleAreaAtUnit(Radius, Unit, Duration, VisibleArmy)

    local VisibleAreaTable = { }

    for i, Army in VisibleArmy do 
        local VisibleArea = ScenarioFramework.CreateVisibleAreaAtUnit(Radius, Unit, Duration, GetArmyBrain(Army))
        VisibleArea:AttachBoneTo(-1, Unit, -1)
        table.insert(VisibleAreaTable, VisibleArea)
    end

    Unit.OldOnKilled = Unit.OnKilled

    Unit.OnKilled = function(self, instigator, type, overkillRatio)

        for x, VisibleArea in VisibleAreaTable do 
            VisibleArea:Destroy()
        end

        self.OldOnKilled(self, instigator, type, overkillRatio)
    end
end

function DistanceCheckToDefenceObject()
	local DefenceObjectLocation = ScenarioUtils.MarkerToPosition('defenceobject-1')

	ForkThread(
		function()
			while true do 
				if EndBoss:IsDead() then

					break
				end
				if not EndBoss:IsDead() then
					local CurrentBossPosition = EndBoss:GetPosition()
					local DistanceToDefenceObject = VDist3(CurrentBossPosition, DefenceObjectLocation)

					if DistanceToDefenceObject > 200 then
						SetSpeedMultiplier(DistanceToDefenceObject)
					end
				end

				WaitSeconds(1)
			end
		end)
end

function SetSpeedMultiplier(DistanceToDefenceObject)
	local Value = (DistanceToDefenceObject * 0.01) * (DistanceToDefenceObject * 0.01)
	EndBoss:SetSpeedMult(0.20375 * Value)
	IssueAggressiveMove({EndBoss}, Location1)
	IssueAggressiveMove({EndBoss}, Location2)
	IssueAggressiveMove({EndBoss}, Location3)
	IssueAggressiveMove({EndBoss}, Location4)
	IssueAggressiveMove({EndBoss}, Location5)
	IssueAggressiveMove({EndBoss}, Location6)
	IssueAggressiveMove({EndBoss}, FinalDestination)
end