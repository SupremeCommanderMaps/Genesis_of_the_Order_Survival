-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------


local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local util = import('/lua/utilities.lua')



------ Default Shield Mesh ---------------------------------------------------------------------
-- Shield mesh 
-- Seraphim                     	'/effects/entities/SeraphimShield01/SeraphimShield01_mesh'
-- Aeon                         	'/effects/entities/AeonShield01/AeonShield01_mesh'
-- Uef                          	'/effects/entities/Shield01/Shield01_mesh'
-- Cybran                       	'/effects/entities/CybranShield01/CybranShield01_mesh'

------ Optional Shield Mesh --------------------------------------------------------------------
-- Green whirl                  	'/effects/entities/cybranphalanxsphere01/cybranphalanxsphere01_mesh'
-- Red whirl                    	'/effects/entities/cybranphalanxsphere01/cybranphalanxsphere02_mesh'
-- Red upward 2 times           	'/effects/Entities/CybranTeleport/CybranTeleport_mesh'


------ Personal Shields Set size to 1 -----------------------------------------------------------------------
-- Seraphim Support Commander   	'/units/xsl0301/XSL0301_PersonalShield_mesh'

-- Aeon Com                     	'/units/ual0001/UAL0001_PhaseShield_mesh' 
-- Aeon Rambo com               	'/units/ual0301/ual0301_personalshield_mesh'
-- Aeon Obsidian                	'/units/ual0202/ual0202_personalshield_mesh'

-- Uef Commander                	'/units/uel0001/UEL0001_PhaseShield_mesh'
-- Uef Support Commander        	'/units/uel0301/UEL0301_PersonalShield_mesh'
-- Uef Titan                    	'/units/uel0303/UEL0303_PersonalShield_mesh'

-- Big Cybran Commander         	'/units/url0001/URL0001_PhaseShield_mesh'

------ Projectiles mesh ----------------------------------------------------------------------------
-- Aeon border rectangle			'/meshes/game/map-border_hor_aeon_a_mesh'
-- Aeon under layer rectangle		'/meshes/game/map-border_hor_aeon_mesh'

-- Sera border rectangle			'/meshes/game/map-border_hor_sera_a_mesh',
-- Sera under layer rectangele		'/meshes/game/map-border_hor_sera_mesh',

-- Uef under layer rectangel		

-- Cybran border square				'/meshes/game/map-border_squ_cybran_a_mesh'
-- Cybran under layer square		'/meshes/game/map-border_squ_cybran_mesh'

-- Protjectile                  	'/projectiles/CAANanoDart01/CAANanoDartUnPacked01_mesh'


-- red black stripes				'/meshes/explosions/oblivion_explosion01_mesh'
-- Aeon build effect				'/effects/entities/AeonBuildEffect/AeonBuildEffect01_mesh'
-- Baloon 							'/effects/entities/AeonAdjacencyNode/AeonAdjacencyNode_mesh'
-- Red pointing Arrow small			'/meshes/projectiles/missile_antiair_cybran01_mesh'
-- Arrow							'/meshes/game/arrow_mesh'
-- Torpedo							'/meshes/projectiles/torpedo_default_mesh'
-- Tml								'/meshes/projectiles/missile_default_mesh'
-- Tml								'/meshes/projectiles/missile_cruise01_mesh'
-- Depthcharge 						'/meshes/projectiles/depthcharge_default_mesh'
-- Debris	1 to 5					'/meshes/projectiles/debris_misc_05_mesh'


-- 0
-- -0.785398    45
-- -1.570796    90
-- -2.356194    135
-- -3.141593    180
-- -3.926990    225
-- -4.712389    270
-- -5.497786    315

local shield = {
	ImpactEffects = 'SeraphimShieldHit01',
	ImpactMesh = '/effects/entities/ShieldSection01/ShieldSection01_mesh',
	Mesh = '/effects/entities/SeraphimShield01/SeraphimShield01_mesh',
	MeshZ = '/effects/entities/Shield01/Shield01z_mesh',
	RegenAssistMult = 60,
	ShieldEnergyDrainRechargeTime = 60,
	ShieldMaxHealth = 55000,
	ShieldRechargeTime = 20,
	ShieldRegenRate = 300,
	ShieldRegenStartTime = 1,
	ShieldSize = 16,
	ShieldVerticalOffset = -2,
}

function EmergencyShield()
	Prop1:CreateShield(shield)
	while true do
		if Prop1:IsDead() then
			LOG("Tread has bin broken")
			break
		end
		if Prop1:ShieldIsOn() == false then
			WaitSeconds(20)
			Prop1:ShieldIsOn()
			Prop1:CreateShield(shield)
			shield:UpdateShieldRatio(1)
		end
	WaitSeconds(2.0)	
    end
end

function SpawnProps()
    -- Emergency Beacon
    local POS = ScenarioUtils.MarkerToPosition("prop-1")
	Prop1 = CreateUnitHPR('UEB5103', "ARMY_ALLY_UEF", POS[1], POS[2], POS[3], 0, -1.185398,0)
	Prop1:SetCustomName("HEX:  46552c4761727279")
    Prop1:SetMaxHealth(8000)
    Prop1:SetHealth(nil, 5000)
	Prop1:SetReclaimable(false)
	Prop1:SetCapturable(false)
    Prop1:ShieldIsOn()


    ForkThread(EmergencyShield)
end
