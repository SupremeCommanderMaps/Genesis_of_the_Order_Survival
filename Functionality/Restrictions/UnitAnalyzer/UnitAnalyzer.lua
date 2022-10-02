-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

-- Gets unit's faction based on categories of given blueprint
function GetUnitFaction(bp)
    local factionCategory = nil
    local factionName = bp.General.FactionName

    for _, faction in Factions do
        if bp.CategoriesHash[faction.Name] then
            factionCategory = faction.Name
            break
        end
    end
    -- validate if factionCategory and factionName are the same
    if not factionCategory then
        Show('WARNING', bp.Info..' - missing FACTION in bp.Categories')
    elseif not factionName then
        Show('WARNING', bp.Info..' - missing bp.General.FactionName')
    else
        if factionCategory ~= string.upper(factionName) then
            Show('WARNING', bp.Info..' - mismatch between ' .. factionCategory .. '  in bp.Categories and ' .. factionName .. ' in bp.General.FactionName')
        end
        return factionCategory
    end
    return 'UNKNOWN'
end

-- Gets units tech level based on categories of given blueprint
function GetUnitTech(UnitId)
    for z, Category in __blueprints[UnitId].Categories do 
        if Category == 'COMMAND' then return 'T0' end        
        if Category == 'TECH1' then return 'T1' end
        if Category == 'TECH2' then return 'T2' end
        if Category == 'TECH3' then return 'T3' end
        if Category == 'EXPERIMENTAL' then return 'T4' end
    end

    return "TECH_UNKNOWN"
end

function GetUnitStructureOrMobile(UnitId)
    for z, Category in __blueprints[UnitId].Categories do 
        if Category == 'STRUCTURE' then return 'STRUCTURE' end        
        if Category == 'MOBILE' then return 'MOBILE' end
    end
    return "TECH_UNKNOWN"
end

-- Gets units type based on categories of given blueprint
function GetUnitType(UnitId)
    for z, Category in __blueprints[UnitId].Categories do 
        if Category == 'STRUCTURE' then return 'STRUCTURE' end
        if Category == 'AIR' then return 'AIR' end
        if Category == 'LAND' then return 'LAND' end
        if Category == 'NAVAL' then return 'NAVAL' end
        if Category == 'HOVER' then return 'HOVER' end
    end

    return "TYPE_UNKNOWN"
end

local function init(value)
    return value >= 1 and value or 0
end


-- Some calculation based on this code
-- https://github.com/spooky/unitdb/blob/master/app/js/dps.js
-- Gets shots per second of specified weapon (inverse of RateOfFire)
function GetWeaponRatePerSecond(bp, weapon)
    local rate = weapon.RateOfFire or 1
    return math.round(10 / rate) / 10 -- Ticks per second
end

function GetWeaponDefaults(bp, w)
    local weapon = table.deepcopy(w)
    weapon.Category = w.WeaponCategory or '<MISSING_CATEGORY>'
    weapon.DisplayName = weapon.DisplayName or '<MISSING_DISPLAYNAME>'
    weapon.Info = string.format("%s (%s)", weapon.DisplayName, weapon.Category)

    weapon.BuildCostEnergy = bp.Economy.BuildCostEnergy or 0
    weapon.BuildCostMass = bp.Economy.BuildCostMass or 0
    weapon.BuildTime = 0 -- Not including built time of the unit

    weapon.Count = 1
    weapon.Multi = 1
    weapon.Range = math.round(weapon.MaxRadius or 0)
    weapon.Damage = GetWeaponDamage(weapon)
    weapon.RPS = GetWeaponRatePerSecond(bp, weapon)
    weapon.DPS = -1

    return weapon
end

-- Get damage of nuke weapon or normal weapon
function GetWeaponDamage(weapon)
    local damage = 0
    if weapon.NukeWeapon then -- Stack nuke damages
        damage = (weapon.NukeInnerRingDamage or 0)
        damage = (weapon.NukeOuterRingDamage or 0) + damage
    else -- Normal weapon
        damage = (weapon.Damage or 0)
    end

    return damage
end

-- Get specs for a weapon with projectiles
function GetWeaponProjectile(bp, weapon)
    -- Multipliers is needed to properly calculate split projectiles.
    -- Unfortunately these numbers hard-coded here are not available in the blueprint,
    -- but specified in the .lua files for corresponding projectiles.
    local multipliers = {
        -- Lobo
        ['/projectiles/TIFFragmentationSensorShell01/TIFFragmentationSensorShell01_proj.bp'] = 4,
        -- Zthuee
        ['/projectiles/SIFThunthoArtilleryShell01/SIFThunthoArtilleryShell01_proj.bp'] = 5
    }

    if weapon.ProjectileId then
       weapon.Multi = multipliers[weapon.ProjectileId] or 1
    end

    -- NOTE that weapon.ProjectilesPerOnFire is not used at all in FA game
    if weapon.MuzzleSalvoSize > 1 then
       weapon.Multi = weapon.Multi * weapon.MuzzleSalvoSize
    end

    local projID = string.lower(weapon.ProjectileId or '')
    local proj = projectiles.All[projID]
    if proj and proj.Economy then
        weapon.BuildCostEnergy = weapon.BuildCostEnergy + (proj.Economy.BuildCostEnergy or 0)
        weapon.BuildCostMass = weapon.BuildCostMass + (proj.Economy.BuildCostMass or 0)

        if proj.Economy.BuildTime and bp.Economy.BuildRate then
            weapon.RPS = proj.Economy.BuildTime / bp.Economy.BuildRate
        end
    end

    weapon.DPS = (weapon.Multi * weapon.Damage) / weapon.RPS
    weapon.DPS = math.round(weapon.DPS)

    return weapon
end

-- Get specs for a weapon with beam pulses
function GetWeaponBeamPulse(bp, weapon)
    if weapon.BeamLifetime then
        if weapon.BeamCollisionDelay > 0 then
           weapon.Multi = weapon.BeamCollisionDelay
        end

        if weapon.BeamLifetime > 0 then
           weapon.Multi = weapon.Multi * weapon.BeamLifetime * 10
        end

        -- Rate per second
        weapon.RPS = GetWeaponRatePerSecond(bp, weapon)
        weapon.DPS = (weapon.Multi * weapon.Damage) / weapon.RPS
        weapon.DPS = math.round(weapon.DPS)
    end

    return weapon
end

-- Get specs for a weapon with continuous beam
function GetWeaponBeamContinuous(bp, weapon)
    if weapon.ContinuousBeam then
       weapon.Multi = 10
       -- Rate per second
       weapon.RPS = weapon.BeamCollisionDelay == 0 and 1 or 2
       weapon.DPS = (weapon.Multi * weapon.Damage) / weapon.RPS
       weapon.DPS = math.round(weapon.DPS)
    end

    return weapon
end

-- Get specs for a weapon with dots per pulses
function GetWeaponDOT(bp, weapon)
    if weapon.DoTPulses then
        local initial = GetWeaponProjectile(bp, weapon)
        weapon.Multi = (weapon.MuzzleSalvoSize or 1) * weapon.DoTPulses
        -- Rate per second
        weapon.RPS = GetWeaponRatePerSecond(bp, weapon)
        weapon.DPS = (initial.DPS + weapon.Multi * weapon.Damage) / weapon.RPS
        weapon.DPS = math.round(weapon.DPS)
    end

    return weapon
end

-- Gets specs for a weapon
function GetWeaponSpecs(bp, weapon)
    weapon = GetWeaponDefaults(bp, weapon)

    if weapon.DoTPulses then
        weapon = GetWeaponDOT(bp, weapon)
    elseif weapon.ContinuousBeam then
        weapon = GetWeaponBeamContinuous(bp, weapon)
    elseif weapon.BeamLifetime then
        weapon = GetWeaponBeamPulse(bp, weapon)
    else
        weapon = GetWeaponProjectile(bp, weapon)
    end

    return weapon
end

-- Gets weapons stats in given blueprint, more accurate than in-game unitviewDetails.lua
function GetWeaponsStats(UnitId)

    -- TODO fix bug: SCU weapons (rate, damage, range) are not updated with values from enhancements!
    -- TODO fix bug: SCU presets for SERA faction, have all weapons from all enhancements!
    -- Check bp.EnhancementPresetAssigned.Enhancements table to get accurate stats
    for id, w in __blueprints[UnitId].Weapon do
        local damage = GetWeaponDamage(w)
        -- Skipping not important weapons, e.g. UEF shield boat fake weapon
        if w.WeaponCategory and
           w.WeaponCategory ~= 'Death' and
           w.WeaponCategory ~= 'Teleport' and
           damage > 0 then

           local weapon = GetWeaponSpecs(UnitId, w)
           weapon.DPM = weapon.Damage / weapon.BuildCostMass
           weapon.DPE = weapon.Damage / weapon.BuildCostEnergy
           weapon.Damage = math.round(weapon.Damage)
           weapons[id] = weapon
        end
    end
    return weapons
end

function GetWeaponsTotal(weapons)
    local total = {}
    total.Range = 100000
    total.Count = 0
    total.Damage = 0
    total.DPM = 0
    total.DPS = 0

    for i, weapon in weapons or {} do
        -- Including only important weapons
        if weapon.Category and
            weapon.Category ~= 'Death' and
            weapon.Category ~= 'Defense' and
            weapon.Category ~= 'Teleport' then
            total.Damage = total.Damage + weapon.Damage
            total.DPM = total.DPM + weapon.DPM
            total.DPS = total.DPS + weapon.DPS
            total.Count = total.Count + 1
            total.Range = math.min(total.Range, weapon.Range)
        end
    end

    total.Category = 'All Weapons'
    total.DisplayName = 'Total'
    total.Info = string.format("%s (%s)", total.DisplayName, total.Category)

    return total
end

--- Checks if a unit contains specified categories
function ContainsCategory(unit, value)
    if not value then return false end
    if not unit then return false end
    if not unit.CategoriesHash then return false end
    return unit.CategoriesHash[value]
end

