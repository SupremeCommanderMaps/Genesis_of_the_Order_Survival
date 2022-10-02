-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

--Original Game Stats
-- NOTE that weapon.ProjectilesPerOnFire is not used at all in FA game

-- Rateoffire = 1/RateOfFire
-- dps = ProjectilesPerOnFire*Damage*RateOfFire
-- or (BeamLifetime*10 there are 10 ticks in 1 second)*Damage*RateOfFire

--[[ 
    DefaultProjectile
        dps = (ProjectilesPerOnFire * Damage) * RateOfFire

    BeamWeapon
        dps  = ((10 * BeamLifetime) * Damage) * RateOfFire

    ContinousBeamWeapon -- Check BeamLifetime = 0 
        dps  = (10 * Damage)
]]




T1PD = { -- uef
    MaxHealth =  1800,
    BuildCostMass = 250,
    HpBuildCostRatio = 1800/250, -- 7.1999998092651

    ProjectilesPerOnFire = 1,
    Damage = 50,
    RateOfFire = 3,

    DamageRadius = 0,    
    MaxRadius = 26,
}

T2PD = { -- uef triade structure weapon Aeon oblivion
    MaxHealth =  2250,
    BuildCostMass = 540,
    HpBuildCostRatio = 2250/540, -- :4.1666665077209

    ProjectilesPerOnFire = 1, 
    Damage = 600,    
    RateOfFire = 0.25,

    DamageRadius = 2,    
    MaxRadius = 50,
    -- w.
    Dps = ((1*600*0.25) * 1.2) -- *1.2 becuase of the DamageRadius
}

T3PD = { -- uef triade structure weapon Aeon oblivion
    MaxHealth =  6500,
    BuildCostMass = 2000,
    HpBuildCostRatio = 6500/2000, -- :4.1666665077209

    ProjectilesPerOnFire = 1, 
    Damage = 175,    
    RateOfFire = 1,

    DamageRadius = 2,    
    MaxRadius = 70,

    Dps = ((1*600*0.25) * 1.2) -- *1.2 becuase of the DamageRadius
}