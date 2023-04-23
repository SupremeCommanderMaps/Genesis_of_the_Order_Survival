-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

ScenarioInfo.MapPath = '/maps/genesis_of_the_order_survival.v0020/'

local Statistics = import(ScenarioInfo.MapPath .. 'Events/Statistics.lua')

local GameSetup = import(ScenarioInfo.MapPath .. 'Functionality/GameSetup.lua')
local GameStart = import(ScenarioInfo.MapPath .. 'Functionality/GameStart.lua')
local GameProgression = import(ScenarioInfo.MapPath .. 'Functionality/GameProgression.lua')

local BroadcastMsg = import(ScenarioInfo.MapPath .. 'Utilities/BroadcastMsg.lua')
local WelcomeMessage = import(ScenarioInfo.MapPath .. 'Functionality/WelcomeMessage.lua')

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local Utilities = import('/lua/utilities.lua')


local PlayDialogue = import(ScenarioInfo.MapPath .. 'Utilities/PlayDialogue.lua')
local DialogueList = import(ScenarioInfo.MapPath .. 'Resources/DialogueList.lua')

ScenarioUtils.CreateResources = function() end

function OnPopulate()
	Sync.CampaignMode = true
	ScenarioInfo.Debug = false
	ScenarioInfo.Options.Victory = 'sandbox'
	ScenarioUtils.InitializeArmies()
	GameSetup.TheRedOrTheBluePill()
end

function OnStart()
	GameStart.WhySoSerious()
	GameProgression.DoOrDoNotThereIsNoTry()
end






















































function OnShiftF3()
	Statistics.Setup()
end

function OnCtrlF3()

end

function OnShiftF4()
	WelcomeMessage.ShowWelcomeMessage()
end

function OnCtrlF4()
	WelcomeMessage.ShowBriefing()
end

function OnShiftF5()
	if ScenarioInfo.Options.Option_HealthMultiplier < 4.95 then
		ScenarioInfo.Options.Option_HealthMultiplier = ScenarioInfo.Options.Option_HealthMultiplier + 0.1
	elseif ScenarioInfo.Options.Option_HealthMultiplier < 9.95 then
		ScenarioInfo.Options.Option_HealthMultiplier = ScenarioInfo.Options.Option_HealthMultiplier + 2.5
	elseif ScenarioInfo.Options.Option_HealthMultiplier < 24.95 then
		ScenarioInfo.Options.Option_HealthMultiplier = ScenarioInfo.Options.Option_HealthMultiplier + 15
	elseif ScenarioInfo.Options.Option_HealthMultiplier < 99.95 then
		ScenarioInfo.Options.Option_HealthMultiplier = ScenarioInfo.Options.Option_HealthMultiplier + 75
	elseif ScenarioInfo.Options.Option_HealthMultiplier < 499.95 then
		ScenarioInfo.Options.Option_HealthMultiplier = ScenarioInfo.Options.Option_HealthMultiplier + 400
	elseif ScenarioInfo.Options.Option_HealthMultiplier < 999.95 then
		ScenarioInfo.Options.Option_HealthMultiplier = ScenarioInfo.Options.Option_HealthMultiplier + 500
	elseif ScenarioInfo.Options.Option_HealthMultiplier < 9999.95 then
		ScenarioInfo.Options.Option_HealthMultiplier = ScenarioInfo.Options.Option_HealthMultiplier + 9000
	end
	
	local Formatted = string.format("%.1f", ScenarioInfo.Options.Option_HealthMultiplier)
	BroadcastMsg.TextMsg(string.rep(" ", 100) .. "Health multiplier increased to " .. Formatted .. "X", 30, 'e80a0a', 3, 'centertop')
end

function OnCtrlF5()
	if ScenarioInfo.Options.Option_HealthMultiplier > 0.1 then
		if ScenarioInfo.Options.Option_HealthMultiplier > 1000.1 then
			ScenarioInfo.Options.Option_HealthMultiplier = ScenarioInfo.Options.Option_HealthMultiplier - 9000
		elseif ScenarioInfo.Options.Option_HealthMultiplier > 500.1 then
			ScenarioInfo.Options.Option_HealthMultiplier = ScenarioInfo.Options.Option_HealthMultiplier - 500
		elseif ScenarioInfo.Options.Option_HealthMultiplier > 100.1 then
			ScenarioInfo.Options.Option_HealthMultiplier = ScenarioInfo.Options.Option_HealthMultiplier - 400
		elseif ScenarioInfo.Options.Option_HealthMultiplier > 25.1 then
			ScenarioInfo.Options.Option_HealthMultiplier = ScenarioInfo.Options.Option_HealthMultiplier - 75
		elseif ScenarioInfo.Options.Option_HealthMultiplier > 10.1 then
			ScenarioInfo.Options.Option_HealthMultiplier = ScenarioInfo.Options.Option_HealthMultiplier - 15
		elseif ScenarioInfo.Options.Option_HealthMultiplier > 5.1 then
			ScenarioInfo.Options.Option_HealthMultiplier = ScenarioInfo.Options.Option_HealthMultiplier - 2.5
		elseif ScenarioInfo.Options.Option_HealthMultiplier > 0.1 then
			ScenarioInfo.Options.Option_HealthMultiplier = ScenarioInfo.Options.Option_HealthMultiplier - 0.1
		end
	end

	local Formatted = string.format("%.1f", (ScenarioInfo.Options.Option_HealthMultiplier))
	BroadcastMsg.TextMsg(string.rep(" ", 100) .. "Health multiplier decreased to " .. Formatted .. "X", 30, 'e80a0a', 3, 'centertop')
end

function OnCtrlAltF4()
	if ScenarioInfo.Options.Option_DamageMultiplier > 0.1 then
		if ScenarioInfo.Options.Option_DamageMultiplier > 1000.1 then
			ScenarioInfo.Options.Option_DamageMultiplier = ScenarioInfo.Options.Option_DamageMultiplier - 9000
		elseif ScenarioInfo.Options.Option_DamageMultiplier > 500.1 then
			ScenarioInfo.Options.Option_DamageMultiplier = ScenarioInfo.Options.Option_DamageMultiplier - 500
		elseif ScenarioInfo.Options.Option_DamageMultiplier > 100.1 then
			ScenarioInfo.Options.Option_DamageMultiplier = ScenarioInfo.Options.Option_DamageMultiplier - 400
		elseif ScenarioInfo.Options.Option_DamageMultiplier > 25.1 then
			ScenarioInfo.Options.Option_DamageMultiplier = ScenarioInfo.Options.Option_DamageMultiplier - 75
		elseif ScenarioInfo.Options.Option_DamageMultiplier > 10.1 then
			ScenarioInfo.Options.Option_DamageMultiplier = ScenarioInfo.Options.Option_DamageMultiplier - 15
		elseif ScenarioInfo.Options.Option_DamageMultiplier > 5.1 then
			ScenarioInfo.Options.Option_DamageMultiplier = ScenarioInfo.Options.Option_DamageMultiplier - 2.5
		elseif ScenarioInfo.Options.Option_DamageMultiplier > 0.1 then
			ScenarioInfo.Options.Option_DamageMultiplier = ScenarioInfo.Options.Option_DamageMultiplier - 0.1
		end
	end

	local Formatted = string.format("%.1f", ScenarioInfo.Options.Option_DamageMultiplier)
	BroadcastMsg.TextMsg(string.rep(" ", 100) .. "Damage multiplier decreased to " .. Formatted .. "X", 30, 'e80a0a', 3, 'centertop')
end

function OnCtrlAltF5()
	if ScenarioInfo.Options.Option_DamageMultiplier < 4.95 then
		ScenarioInfo.Options.Option_DamageMultiplier = ScenarioInfo.Options.Option_DamageMultiplier + 0.1
	elseif ScenarioInfo.Options.Option_DamageMultiplier < 9.95 then
		ScenarioInfo.Options.Option_DamageMultiplier = ScenarioInfo.Options.Option_DamageMultiplier + 2.5
	elseif ScenarioInfo.Options.Option_DamageMultiplier < 24.95 then
		ScenarioInfo.Options.Option_DamageMultiplier = ScenarioInfo.Options.Option_DamageMultiplier + 15
	elseif ScenarioInfo.Options.Option_DamageMultiplier < 99.95 then
		ScenarioInfo.Options.Option_DamageMultiplier = ScenarioInfo.Options.Option_DamageMultiplier + 75
	elseif ScenarioInfo.Options.Option_DamageMultiplier < 499.95 then
		ScenarioInfo.Options.Option_DamageMultiplier = ScenarioInfo.Options.Option_DamageMultiplier + 400
	elseif ScenarioInfo.Options.Option_DamageMultiplier < 999.95 then
		ScenarioInfo.Options.Option_DamageMultiplier = ScenarioInfo.Options.Option_DamageMultiplier + 500
	elseif ScenarioInfo.Options.Option_DamageMultiplier < 9999.95 then
		ScenarioInfo.Options.Option_DamageMultiplier = ScenarioInfo.Options.Option_DamageMultiplier + 9000
	end

	local Formatted = string.format("%.1f", ScenarioInfo.Options.Option_DamageMultiplier)
	BroadcastMsg.TextMsg(string.rep(" ", 100) .. "Damage multiplier increased to " .. Formatted .. "X", 30, 'e80a0a', 3, 'centertop')
end

--[[
Sending stats: {"stats":[
	{"blueprints":[],
	"type":"Human",
	"name":"FAF_Jammer",
	"faction":3,
	"resources":{"massin":{"total":0,"reclaimed":0,"reclaimRate":0,"rate":0},
	"energyout":{"total":0,"rate":0,"excess":0},
	"storage":{"storedEnergy":0,"maxEnergy":0,"maxMass":0,"storedMass":0},
	"energyin":{"total":0,"reclaimed":0,"reclaimRate":0,"rate":0},
	"massout":{"total":0,"rate":0,"excess":0}},
	"general":{"lastupdatetick":0,"score":0,"currentcap":1000,
	"lost":{"mass":0,"count":0,"energy":0},
	"kills":{"mass":0,"count":0,"energy":0},
	"currentunits":0,"built":{"mass":0,"count":0,"energy":0}},
	"units":{"air":{"lost":0,"kills":0,"built":0},
	"tech3":{"lost":0,"kills":0,"built":0},
	"cdr":{"lost":0,"kills":0,"built":0},
	"tech2":{"lost":0,"kills":0,"built":0},
	"tech1":{"lost":0,"kills":0,"built":0},
	"transportation":{"lost":0,"kills":0,"built":0},
	"land":{"lost":0,"kills":0,"built":0},
	"experimental":{"lost":0,"kills":0,"built":0},
	"structures":{"lost":0,"kills":0,"built":0},
	"engineer":{"lost":0,"kills":0,"built":0},
	"naval":{"lost":0,"kills":0,"built":0},
	"sacu":{"lost":0,"kills":0,"built":0}}}
	,{"blueprints":[],
	"type":"AI",
	"name":"Bassima (AI: Easy)",
	"faction":2,
]]--
--import('/lua/victory.lua').CallEndGame()
--['toggle_score_screen'] = {action = 'UI_Lua import("/lua/ui/game/tabs.lua").ToggleScore()'
