-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local Utilities = import('/lua/utilities.lua')

local GameSetup = import(ScenarioInfo.MapPath .. 'Functionality/GameSetup.lua')

local WaveTableEnemyAir = import(ScenarioInfo.MapPath .. 'Tables/WaveTablesEnemyAir.lua')

local BroadcastMsg = import(ScenarioInfo.MapPath .. 'Utilities/BroadcastMsg.lua')
local Markers = import(ScenarioInfo.MapPath .. 'Utilities/Markers.lua')
local PlatoonOrders = import(ScenarioInfo.MapPath .. 'Utilities/PlatoonOrders.lua')
local UnitCreator = import(ScenarioInfo.MapPath .. 'Utilities/UnitCreator.lua')

WaveCount = 1 
MaxWaveCount = table.getn(WaveTableEnemyAir.Tables)





function TakeFlight()
    
    local WaveTable = WaveTableEnemyAir.Tables

    local BuildTime = ScenarioInfo.Options.Option_BuildTime
    local CurrentTime =  math.floor(GetGameTimeSeconds())

	local Armies = ListArmies()
	local PlayerCount = GameSetup.PlayerArmyCount
	local Count = ScenarioInfo.Options.Option_PlatoonWaveCount * PlayerCount

    local SpawnTime = WaveTable[WaveCount].SpawnTime

    local WaveType = "Air: "
    local WaveLayer = 'Air'


	local Army = "ARMY_ENEMY_AEON"

    while true do
		local GameTime = math.floor(GetGameTimeSeconds()) 

        if WaveCount > MaxWaveCount then
            break
        end

        if (CurrentTime < GameTime) then

            if (GameTime > (BuildTime + (SpawnTime * 60))) then
				for _ = 1, Count do

                    local OrderId = WaveTable[WaveCount].OrderId
                    local Formation = WaveTable[WaveCount].Formation
					local UnitTableData = WaveTable[WaveCount].UnitIds

					local SpawnLocation = Markers.GetRandomPosition(Markers.AmphibiousSpawn)
					local AttackLocation = Markers.GetRandomPosition(Markers.PathWay)                    
					local FinalDestination = ScenarioUtils.MarkerToPosition('defenceobject-1')   
                    
                    local Location1 = Markers.GetRandomPosition(Markers.PathWayAir)
                    local Location2 = Markers.GetRandomPosition(Markers.PathWayAir)
                    local Location3 = Markers.GetRandomPosition(Markers.PathWayAir)
                    local Location4 = Markers.GetRandomPosition(Markers.PathWayAir)
                    local Location5 = Markers.GetRandomPosition(Markers.PathWayAir)
                    local Location6 = Markers.GetRandomPosition(Markers.PathWayAir)

					local Units = UnitCreator.CreatePlatoonEnemy(UnitTableData, Army, SpawnLocation, WaveCount, MaxWaveCount, WaveType)
                    PlatoonOrders.GiveOrderAir(
                    Army, WaveLayer, OrderId, Units, 
                    SpawnLocation, AttackLocation, FinalDestination, 
                    Location1, Location2, Location3, Location4, Location5, Location6, 
                    Formation, 0)
				end
                WaveCount = WaveCount + 1
                SpawnTime = WaveTable[WaveCount].SpawnTime               
            end
        end
    CurrentTime = GameTime 
    WaitSeconds(0.5)  

    end
end
