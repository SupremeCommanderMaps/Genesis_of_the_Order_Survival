-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local ScenarioFramework = import('/lua/ScenarioFramework.lua')

function SetArea()
    local ArmyAlly = "ARMY_ALLY_UEF"
    local ArmyEnemy = "ARMY_ENEMY_AEON"
    local ArmyHq = "ARMY_ALLY_UEF_HQ"

    ScenarioFramework.SetPlayableArea('AREA_2', false)

    ScenarioFramework.SetIgnorePlayableRect(ArmyAlly, true)
    ScenarioFramework.SetIgnorePlayableRect(ArmyEnemy, true)
    ScenarioFramework.SetIgnorePlayableRect(ArmyHq, true)

    if 	ScenarioInfo.Debug then
        ScenarioFramework.SetPlayableArea('AREA_1', false)
    end
end