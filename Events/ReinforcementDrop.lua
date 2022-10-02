-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local Utilities = import('/lua/utilities.lua')

local DialogueList = import(ScenarioInfo.MapPath .. 'Resources/DialogueList.lua')

local ReinforcementDropTable = import(ScenarioInfo.MapPath .. 'Tables/ReinforcementDropTable.lua')

local ArmyStrength = import(ScenarioInfo.MapPath .. 'Utilities/ArmyStrength.lua')
local CircularPointGenerator = import(ScenarioInfo.MapPath .. 'Utilities/CircularPointGenerator.lua')
local PlayDialogue = import(ScenarioInfo.MapPath .. 'Utilities/PlayDialogue.lua')
local Markers = import(ScenarioInfo.MapPath .. 'Utilities/Markers.lua')
local UnitCreator = import(ScenarioInfo.MapPath .. 'Utilities/UnitCreator.lua')

WaveTableNumber = 1 --[[Default = 1]]-- 
MaxWaveTableNumber = table.getn(ReinforcementDropTable.Tables)

local BuildTime = ScenarioInfo.Options.Option_BuildTime

local TimeDrop1 = Utilities.GetRandomInt(2.0 * 60, 3.0 * 60)
local TimeDrop2 = Utilities.GetRandomInt(6.0 * 60, 8.0 * 60)
local TimeDrop3 = Utilities.GetRandomInt(10.0 * 60, 12.0 * 60)
local TimeDrop4 = Utilities.GetRandomInt(14.0 * 60, 16.0 * 60)
local TimeDrop5 = Utilities.GetRandomInt(25.0 * 60, 25.5 * 60)

local ShieldBlueprint = {
	ImpactEffects = 'SeraphimShieldHit01',
	ImpactMesh = '/effects/entities/ShieldSection01/ShieldSection01_mesh',
	Mesh = '/effects/entities/Shield01/Shield01_mesh',
	MeshZ = '/effects/entities/Shield01/Shield01_mesh',
	RegenAssistMult = 60,
	ShieldEnergyDrainRechargeTime = 60,
	ShieldMaxHealth = 10300,
	ShieldRechargeTime = 20,
	ShieldRegenRate = 300,
	ShieldRegenStartTime = 1,
	ShieldSize = 16,
	ShieldVerticalOffset = -2,
}

function StartReinforcementDrop()
    ScenarioFramework.CreateTimerTrigger(function() InitializeDrop(1,0)end, BuildTime + TimeDrop1, false) --[[+/- min  4.5]]-- 
    ScenarioFramework.CreateTimerTrigger(function() InitializeDrop(2,0)end, BuildTime + TimeDrop2, false) --[[+/- min  9.0]]--
    ScenarioFramework.CreateTimerTrigger(function() InitializeDrop(3,0)end, BuildTime + TimeDrop3, false) --[[+/- min 13.0]]--
    ScenarioFramework.CreateTimerTrigger(function() InitializeDrop(4,0)end, BuildTime + TimeDrop4, false) --[[+/- min 17.0]]--  titans and precival
    ScenarioFramework.CreateTimerTrigger(function() InitializeDrop(5,1)end, BuildTime + TimeDrop5, false) --[[+/- min 27.25]]-- fatboyz
end 

local DropTable = ReinforcementDropTable.Tables
local BuildTime = ScenarioInfo.Options.Option_BuildTime

function InitializeDrop(WaveTableNumber, ExtraSetting)
   
    if WaveTableNumber == 1 then
        PlayDialogue.Dialogue(DialogueList.Jip_13, nil, false) --Jip: Quit messin around and get some reinforcements up here! The Fort is taking serious damage!
        PlayDialogue.Dialogue(DialogueList.Entropy_12, nil, false) --Entropy: Roger that.
        ForkThread(function()  
            WaitSeconds(30)
            PlayDialogue.Dialogue(DialogueList.Jip_6, nil, false) --Jip: Here are some reinforcements, Colonel. And watch your back I've got a bad feeling about this OP.
        end)
    end
    if WaveTableNumber ~= 1 then
        PlayDialogue.Dialogue(DialogueList.Jip_12, nil, false) -- Jip: Where are my reinforcements?
        PlayDialogue.Dialogue(DialogueList.Entropy_13, nil, false) -- Entropy: Roger. HQ out.
    end

    

    local Army = "ARMY_ALLY_UEF_HQ"

    local TransportShipTable = DropTable[WaveTableNumber].TransportShipIds
    local UnitTable = DropTable[WaveTableNumber].ReinformentUnitIds

    local GiveUnitsToArmy = DropTable[WaveTableNumber].AllArmies
    local DropCount = DropTable[WaveTableNumber].DropCount
  
    local CircleSpawnPoints = DropTable[WaveTableNumber].DropCount
    local InnerRadius = DropTable[WaveTableNumber].InnerRadius
    local OuterRadius = DropTable[WaveTableNumber].OuterRadius    
    local CircleCenter = ScenarioUtils.MarkerToPosition('defenceobject-1')
   
    local TranportWayPoint = CircularPointGenerator.CircularPointGenerator(CircleSpawnPoints, InnerRadius, CircleCenter)
    local DropPositions = CircularPointGenerator.CircularPointGenerator(CircleSpawnPoints, OuterRadius, CircleCenter)
    local DropPositionsCounter = 1


    for _ = 1, DropCount do
        local SpawnLocation = Markers.GetRandomPosition(Markers.DropSpawn)    
        Transportees = UnitCreator.CreateUnits(UnitTable, Army, SpawnLocation)    
        Transports = UnitCreator.CreateUnits(TransportShipTable, Army, SpawnLocation)
        for x, Transport in Transports do 
            Transport:SetSpeedMult(1.8)
            if ExtraSetting == 1 then
                Transport:CreateShield(ShieldBlueprint)   
                Transport:SetMaxHealth((Transport:GetMaxHealth()*17.38))
                Transport:SetHealth(nil, Transport:GetMaxHealth())  
            end
        end
        ScenarioFramework.AttachUnitsToTransports(Transportees, Transports)
        IssueMove(Transports, TranportWayPoint[DropPositionsCounter])
        IssueTransportUnload(Transports, DropPositions[DropPositionsCounter])
        
        IssueMove(Transports, SpawnLocation)
        IssueDestroySelf(Transports)
        
        ForkThread(OnDetachedThread, Transportees)

        DropPositionsCounter = DropPositionsCounter + 1
    end
end

function OnDetachedThread(Units)
    -- keep running until no longer attached
    local Attached = true;
    while Attached do
        WaitSeconds(1)
        Attached = false
        for Every, Unit in Units do
            if not IsDestroyed(Unit) then
                if Unit:IsUnitState('Attached') then
                    -- keep checking until they are _all_ free.
                    Attached = true
                    break
                end
            end                
        end
    end
    GiveUnits(Units)
end

function GiveUnits(Units)
    local SelectArmy = "Weakest"
    local Army = ArmyStrength.GetArmy(SelectArmy)     
    ForkThread(function()
        WaitSeconds(2)
   
        for x, Unit in Units do
            if not IsDestroyed(Unit) then 
                ScenarioFramework.GiveUnitToArmy(Unit, Army)
            end
        end
    end)
end

function RandomUnits(Table)
    local n = table.getn(Table)
    local i = math.floor(Random() * n) + 1
    return Table[i]
end

