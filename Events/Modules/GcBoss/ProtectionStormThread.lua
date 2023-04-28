-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local CircularPointGenerator = import(ScenarioInfo.MapPath .. 'Utilities/CircularPointGenerator.lua')

local DialogueList = import(ScenarioInfo.MapPath .. 'Resources/DialogueList.lua')
local PlayDialogue = import(ScenarioInfo.MapPath .. 'Utilities/PlayDialogue.lua')

function Initialize(Army, MainUnit, HealthMultiplier, DamageMultiplier, DificultyMultiplier, Stage)

    local UnitTable = {'xsl0402'}
    local CircleSpawnPoints = (8 * DificultyMultiplier)
    local CircleRadius = 22

    local MinHealth = (MainUnit:GetMaxHealth() * 0.55)

    local CountTillMove = 0

    local StormHasBinActive = false

    ForkThread(function()
        while true do
            if MainUnit:IsDead() then
                break
            end
            local CurrentHealth = MainUnit:GetHealth()
            local CircleCenter = MainUnit:GetPosition()
            local ProtectionStormCount = 1

            if CurrentHealth < MinHealth  then
                local CurrentMoveLocation = MainUnit:GetCurrentMoveLocation()
                if StormHasBinActive == false then
                    PlayDialogue.Dialogue(DialogueList.Jip_9, nil, false)
                    CircularPointGenerator.CircularSpawner(UnitTable, Army, CircleSpawnPoints, CircleRadius, CircleCenter)
                    StormHasBinActive = true
                end
                
                IssueClearCommands({MainUnit})

                local UnitTable = "xsl0402"
                local OldDoTakeDamage = MainUnit.DoTakeDamage
                function CustomDoTakeDamge(self, instagator, amount, vector, damageType)

                    local ArmyInQuestion = instagator:GetArmy()

                    OldDoTakeDamage(self, instagator, amount, vector, damageType)

                    if GetArmyBrain(ArmyInQuestion).Name == Army then
                        if instagator:GetBlueprint().BlueprintId == UnitTable then
                            self:AdjustHealth(instagator, 50)
                        end
                    end
                end
                MainUnit.DoTakeDamage = CustomDoTakeDamge
            end

            if StormHasBinActive == true then
                CountTillMove = CountTillMove + 1
            end

            if CountTillMove == 40 then
                IssueAggressiveMove({MainUnit}, CurrentMoveLocation)
                break
            end

            WaitSeconds(0.5)
        end
    end)
end