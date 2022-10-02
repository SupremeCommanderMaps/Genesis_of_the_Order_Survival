-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local BroadcastMsg = import(ScenarioInfo.MapPath .. 'Utilities/BroadcastMsg.lua')
local Restrictions = import(ScenarioInfo.MapPath .. 'Functionality/Restrictions.lua')


function ShowWelcomeMessage()
	
	local Difficulty = nil
	if ScenarioInfo.Options.Option_PlatoonWaveCount == 1 then
		Difficulty = "Easy"
	elseif ScenarioInfo.Options.Option_PlatoonWaveCount == 2 then
		Difficulty = "Moderate"
	elseif ScenarioInfo.Options.Option_PlatoonWaveCount == 3 then
		Difficulty = "Hard"
	end
	ForkThread(function()
		WaitSeconds(2.0) --WaitSeconds for GetModifiers to collect
		BroadcastMsg.TextMsg(string.rep(" ", 57) .. "", 20, '2F4607', 20, 'lefttop')



		BroadcastMsg.TextMsg(string.rep(" ", 53) .. "Genesis of the Order ", 36, '77F550', 20, 'lefttop')
		BroadcastMsg.TextMsg(string.rep(" ", 106) .. "Version " .. ScenarioInfo.map_version, 25, '77F550', 20, 'lefttop')

		BroadcastMsg.TextMsg(string.rep(" ", 85) .. "Difficulty " .. Difficulty, 20, '77F550', 20, 'lefttop')
		BroadcastMsg.TextMsg(string.rep(" ", 85) .. "Enemy health " .. (ScenarioInfo.Options.Option_HealthMultiplier * 100) .. "% Damage " .. (ScenarioInfo.Options.Option_DamageMultiplier * 100) .. "%", 20, '77F550', 20, 'lefttop')
	    BroadcastMsg.TextMsg(string.rep(" ", 85) .. "Enemies spawn in " .. ScenarioInfo.Options.Option_BuildTime .. " seconds", 20, '77F550', 20, 'lefttop')
		WaitSeconds(10.0)
		BroadcastMsg.TextMsg(string.rep(" ", 55) .. "", 20, '2F4607', 20, 'centertop')
		BroadcastMsg.TextMsg(string.rep(" ", 55) .. "" .. GetModifiers() .. "", 20, 'FF2D00', 20, 'centertop')
		BroadcastMsg.TextMsg(string.rep(" ", 55) .. "" .. GetBannedUnitsCount() .. "", 20, 'FF2D00', 20, 'centertop')

		


	end)
end

function ShowBriefing()
	ForkThread(function()
		WaitSeconds(1.0)
		Dialog = {
			{displayTime = 15, text = 
			"Commander, this objective is of utmost importance. \n We recieved intel about an Order project code-named: Little Behemoth. \n It seems the Order of the Illuminate are working on a new kind of Experimental. \n Admiral Jip's mission was to locate and destroy it. \n During the search he got overrun and is in need of assistance."},
		}
		BroadcastMsg.DisplayDialogBox("right", Dialog, false)

		WaitSeconds(15.5)
		Dialog = {
			{displayTime = 15, text = 
			"He got corned and had to sail his Summit onto the coast, protect it at all cost. \n The Order is still in the area and are preparing another attack. \n Your objective is to hold off all enemy attacks. \n On top of that, our long range radar is picking up Seraphim movement in Order territory. \n Be on your guard. Be courageous. HQ out!"},
		}
		BroadcastMsg.DisplayDialogBox("right", Dialog, false)
	end)
end

--function ShowBriefing()
--	ForkThread(function()
--		WaitSeconds(0.1)
--		BroadcastMsg.TextMsg(string.rep(" ", 5) .. "Commander, this objective is of utmost importance.", 											   	18, 'FFFFFF', 35, 'leftcenter')
--		BroadcastMsg.TextMsg(string.rep(" ", 5) .. "We recieved intel about an Order project code-named: Little Behemoth.", 						   	18, 'FFFFFF', 35, 'leftcenter')
--		BroadcastMsg.TextMsg(string.rep(" ", 5) .. "It seems the Order of the Illuminate are working on a new kind of Experimental." , 					18, 'FFFFFF', 35, 'leftcenter')
--		BroadcastMsg.TextMsg(string.rep(" ", 5) .. "Admiral Jip's mission was to locate and destroy it.", 										   	   	18, 'FFFFFF', 35, 'leftcenter')
--		BroadcastMsg.TextMsg(string.rep(" ", 5) .. "During the search he got overrun by the Order and is in need of assistance.", 					   	18, 'FFFFFF', 35, 'leftcenter')
--		BroadcastMsg.TextMsg(string.rep(" ", 5) .. "He got corned and had to sail his Summit onto the coast, protect it at all cost.", 			   		18, 'FFFFFF', 35, 'leftcenter')
--		BroadcastMsg.TextMsg(string.rep(" ", 5) .. "The Order is still in the area and are preparing another attack.", 							       	18, 'FFFFFF', 35, 'leftcenter')
--		BroadcastMsg.TextMsg(string.rep(" ", 5) .. "Your objective is to hold off all enemy attacks." , 											   	18, 'FFFFFF', 35, 'leftcenter')
--		BroadcastMsg.TextMsg(string.rep(" ", 5) .. "On top of that, our long range radar is picking up Seraphim movement in Order territory.", 	       	18, 'FFFFFF', 35, 'leftcenter')
--		BroadcastMsg.TextMsg(string.rep(" ", 5) .. "Be on your guard. Be courageous. HQ out!", 													   		18, 'FFFFFF', 35, 'leftcenter')
--	end)
--end

function GetModifiers()
	Dialogue = "Why are you looking here, go do something!!"

	DialogueIncomeMultiplier = ""
	DialogueStorageMultiplier = ""
	DialogueBuildRateMultiplier = ""
	DialogueBuildRangeMultiplier = ""
	DialogueBuildCostMultiplier = ""

	if Restrictions.IncomeMultiplier ~= 1 then
		DialogueIncomeMultiplier = "Income: " ..Restrictions.IncomeMultiplier.."x "
	end
	if Restrictions.StorageMultiplier ~= 1 then
		DialogueStorageMultiplier = "Storage: " ..Restrictions.StorageMultiplier.."x "
	end
	if Restrictions.BuildRateMultiplier ~= 1 then
		DialogueBuildRateMultiplier = "BuildRate: " ..Restrictions.BuildRateMultiplier.."x "
	end
	if Restrictions.BuildRangeMultiplier ~= 1 then
		DialogueBuildRangeMultiplier = "BuildRange: " ..Restrictions.BuildRangeMultiplier.."x "
	end
	if Restrictions.BuildCostMultiplier ~= 1 then
		DialogueBuildCostMultiplier = "UnitCost: " ..Restrictions.BuildCostMultiplier .."x"
	end

	Dialogue = ""..DialogueIncomeMultiplier..""..DialogueStorageMultiplier..""..DialogueBuildRateMultiplier..""..DialogueBuildRangeMultiplier..""..DialogueBuildCostMultiplier..""

	return Dialogue
end

function GetBannedUnitsCount()
	Dialogue = "Seriously, are you still here?"
	Counter = Restrictions.BannedUnitsCounter

	DialogueUnitBanCounter = ""

	if Counter > 0 then 
		DialogueUnitBanCounter = "Mod Build Restriction Count: " .. Counter .. ""
	end

	Dialogue = ""..DialogueUnitBanCounter..""
	return Dialogue
end