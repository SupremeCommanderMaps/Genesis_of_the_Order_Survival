-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

FinalBossDeath = false

local DialogueList = import(ScenarioInfo.MapPath .. 'Resources/DialogueList.lua')
local PlayDialogue = import(ScenarioInfo.MapPath .. 'Utilities/PlayDialogue.lua')

function Initialize(MainUnit, Stage)
	ForkThread(function()
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

    	    local POS = MainUnit:GetPosition()
			if MainUnit:IsDead() then
				if Stage == 2 then
					PlayDialogue.Dialogue(DialogueList.Jip_8, nil, false) -- Jip: You looking for a medal or something? This fight ain't over yet.
				end
				if Stage == 3 then
					PlayDialogue.Dialogue(DialogueList.Custom_Gari_3, nil, false) -- Gari: Ha-ha-ha!
					PlayDialogue.Dialogue(DialogueList.Custom_Gari_7, nil, false) -- Gari: You may have stopped me, but you have no hope of defeating the Seraphim.
					PlayDialogue.Dialogue(DialogueList.Gary_8, nil, false) -- ZanGoattheZeGary: Humanity's time is at an end. You will be rendered extinct.
					FinalBossDeath = true
				end
			
				if Stage == 3 then
					Paragon = CreateUnitHPR('XAB1401', "ARMY_ENEMY_AEON", POS[1], POS[2], POS[3], 0, 0, 0)
					IssueKillSelf({Paragon})
				end		
				break
			end 
    	WaitSeconds(0.5)
    	end
	end)
end 