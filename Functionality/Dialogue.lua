-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local Utilities = import('/lua/utilities.lua')

local PlayDialogue = import(ScenarioInfo.MapPath .. 'Utilities/PlayDialogue.lua')
local DialogueList = import(ScenarioInfo.MapPath .. 'Resources/DialogueList.lua')

function GetTimedDialogue()
    local BuildTime = ScenarioInfo.Options.Option_BuildTime
    local RandomTime1 = Utilities.GetRandomInt(9.0 * 60, 10.0 * 60)
    local RandomTime2 = Utilities.GetRandomInt(23.0 * 60, 24.0 * 60)

    local CurrentTime =  math.floor(GetGameTimeSeconds())   

    ForkThread(
        function()
            while true do

                local GameTime = math.floor(GetGameTimeSeconds()) 
            
                if (CurrentTime < GameTime) then

                    if GameTime == 1 then 
                        PlayDialogue.Dialogue(DialogueList.Jip_3, nil, false) -- Jip: Commander, I could use a hand over here. I'm getting hit pretty hard.
                        PlayDialogue.Dialogue(DialogueList.Jip_4, nil, false) -- Jip: You just gated into a hell of a mess, Colonel, but I'm glad you're here.
                    end
                    if GameTime ==  BuildTime - 25 then 
                        PlayDialogue.Dialogue(DialogueList.Custom_Gari_1, nil, false) -- Gari: At long last, the end of the UEF is within my sights. This day has been a long time coming.
                    end
                    if GameTime ==  BuildTime - 15 then 
                        PlayDialogue.Dialogue(DialogueList.Entropy_2, nil, false) -- Entropy: Another attack is vectoring towards your position. HQ out.
                    end
                    if GameTime ==  BuildTime - 5 then 
                        PlayDialogue.Dialogue(DialogueList.Entropy_4, nil, false) -- Entropy: Enemy assault inbound. HQ out.
                    end
                    if GameTime ==  BuildTime + 0 then 
                        PlayDialogue.Dialogue(DialogueList.Custom_Gari_2, nil, false) -- Gari: I shall cleanse everyone on this planet! You are fools to stand against our might!
                    end
                    if GameTime ==  BuildTime + RandomTime1 then 
                        PlayDialogue.Dialogue(DialogueList.Gary_1, nil, false) -- ZanGoattheZeGary: Language Not Recognized
                    end
                    if GameTime ==  BuildTime + RandomTime1 then 
                        PlayDialogue.Dialogue(DialogueList.Astrox_2, nil, false) -- Astrox Hall: Looks like something big is going down in Illuminate space. Sensors are registering numerous nuclear detonations and several Quantum Wakes. No idea what's happening, but it's a safe bet that it's tied to Burke reappearing. Hall out.
                    end
                    if GameTime ==  BuildTime + RandomTime2 then 
                        PlayDialogue.Dialogue(DialogueList.Gary_2, nil, false) -- ZanGoattheZeGary: Language Not Recognized
                    end
                    if GameTime ==  BuildTime + RandomTime2 then 
                        PlayDialogue.Dialogue(DialogueList.Gary_7, nil, false) -- ZanGoattheZeGary: Laughter
                    end
                end

                CurrentTime = GameTime  
            
                WaitSeconds(1.0)   
            end
        end)
end
