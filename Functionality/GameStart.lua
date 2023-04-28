-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local AeonBoss = import(ScenarioInfo.MapPath .. 'Events/AeonBoss.lua')
local NukeEvent = import(ScenarioInfo.MapPath .. 'Events/NukeEvent.lua')
local ReinforcementDrop = import(ScenarioInfo.MapPath .. 'Events/ReinforcementDrop.lua')

local DefenceObject = import(ScenarioInfo.MapPath .. 'Functionality/DefenceObject.lua')
local Dialogue = import(ScenarioInfo.MapPath .. 'Functionality/Dialogue.lua')
local EmergencyShield = import(ScenarioInfo.MapPath .. 'Functionality/EmergencyShield.lua')

local SpawnEnemyAir = import(ScenarioInfo.MapPath .. 'Generator/SpawnEnemyAir.lua')
local SpawnEnemyLand = import(ScenarioInfo.MapPath .. 'Generator/SpawnEnemyLand.lua')
local SpawnEnemyNavy = import(ScenarioInfo.MapPath .. 'Generator/SpawnEnemyNavy.lua')

function WhySoSerious()
    if not ScenarioInfo.Debug then
	    Dialogue.GetTimedDialogue()
	    DefenceObject.SpawnDefenceObject()
	    EmergencyShield.SpawnEmergencyBeacon()
    end


	AeonBoss.LittleBehemoth()
	NukeEvent.StartNukeEvent()
	ReinforcementDrop.StartReinforcementDrop()
    ForkThread(SpawnEnemyLand.GreasingTheWheels)
	ForkThread(SpawnEnemyNavy.IDontGiveAShip)
	ForkThread(SpawnEnemyAir.TakeFlight)
end
