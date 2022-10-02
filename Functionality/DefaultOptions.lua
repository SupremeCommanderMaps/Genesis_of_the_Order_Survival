-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------
 
-- Not used currently

function GetDefaultOptions()
	if (ScenarioInfo.Options.Option_BuildTime == nil) then
		ScenarioInfo.Options.Option_BuildTime = 30
	end

	if (ScenarioInfo.Options.opt_Survival_EnemiesPerMinute == nil) then
		ScenarioInfo.Options.opt_Survival_EnemiesPerMinute = 36
	end

	if (ScenarioInfo.Options.opt_Survival_WaveFrequency == nil) then
		ScenarioInfo.Options.opt_Survival_WaveFrequency = 10
	end

	if (ScenarioInfo.Options.opt_Survival_HealthMultiplier == nil) then
		ScenarioInfo.Options.opt_Survival_HealthMultiplier = 1
	end

	if (ScenarioInfo.Options.opt_Survival_DamageMultiplier == nil) then
		ScenarioInfo.Options.opt_Survival_DamageMultiplier = 1
	end

	if (ScenarioInfo.Options.opt_Survival_AutoReclaim == nil) then
		ScenarioInfo.Options.opt_Survival_AutoReclaim = 0
	end

	if (ScenarioInfo.Options.opt_SurvivalAllFactions == nil) then
		ScenarioInfo.Options.opt_SurvivalAllFactions = 0
	end

	if (ScenarioInfo.Options.opt_GameBreaker == nil) then
		ScenarioInfo.Options.opt_GameBreaker = 0
	end
end