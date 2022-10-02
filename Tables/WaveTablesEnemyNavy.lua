-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

--Possible OrderIds
-- 1 = FormAggressiveMove 
-- 2 = FromAttack
-- 3 = FromMove
-- 4 = FormPatrol
-- 5 = AggressiveMove
-- 6 = IssueAttack
-- 7 = IssueMove
-- 8 = IssuePatrol

--Possible Formations = 'AttackFormation', 'GrowthFormation',

Tables = { 
    { -- Wave Set 1
        SpawnTime = 2.0,
        OrderId = 1,
        Formation = 'AttackFormation',
        UnitIds = {
        --1* T1 Scout   
        'UAL0101',
        },
    },
    { -- Wave Set 2
        SpawnTime = 4.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T1 Scout   
        'UAL0101', 'UAL0101', 
        },
    },
    { -- Wave Set 3
        SpawnTime = 6.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T1 Scout   
        'UAL0101', 'UAL0101',
        --2* T1TANK
        'UAL0201', 'UAL0201',
        },
    },
    { -- Wave Set 4
        SpawnTime = 7.0,
        OrderId = 1,
        Formation = 'AttackFormation',
        UnitIds = {
        --2* T1 Scout   
        'UAL0101', 'UAL0101',
        --2* T1TANK
        'UAL0201', 'UAL0201',
        },
    },
    { -- Wave Set 5
        SpawnTime = 8.0,
        OrderId = 3,
        Formation = 'GrowthFormation',
        UnitIds = {
        --1* T1 Scout   
        'UAL0101',
        --3* T1TANK
        'UAL0201', 'UAL0201', 'UAL0201',
        },
    },
    { -- Wave Set 6
        SpawnTime = 9.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --1* T1 Scout   
        'UAL0101',
        --4* T1TANK
        'UAL0201', 'UAL0201', 'UAL0201', 'UAL0201',
        },
    },
    { -- Wave Set 7
        SpawnTime = 10.0,
        OrderId = 3,
        Formation = 'GrowthFormation',
        UnitIds = {
        --6* T1TANK
        'UAL0201', 'UAL0201', 'UAL0201', 'UAL0201', 'UAL0201', 'UAL0201',
        },
    },
    { -- Wave Set 8
        SpawnTime = 11.0,
        OrderId = 1,
        Formation = 'AttackFormation',
        UnitIds = {
        --2* T1 Scout   
        'UAL0101', 'UAL0101',
        --4* T1TANK
        'UAL0201', 'UAL0201', 'UAL0201', 'UAL0201',
        },
    },
    { -- Wave Set 9
        SpawnTime = 12.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T1Frigate
        'UAS0103', 'UAS0103',
        --1* T1AntiAirBoat
        'UAS0102',
        },
    },
    { -- Wave Set 10
        SpawnTime = 13.0,
        OrderId = 1,
        Formation = 'AttackFormation',
        UnitIds = {
        --4* T1Frigate
        'UAS0103', 'UAS0103', 'UAS0103', 'UAS0103',
        --1* T1AntiAirBoat
        'UAS0102',
        },
    },
    { -- Wave Set 11
        SpawnTime = 14.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --4* T1Frigate
        'UAS0103', 'UAS0103', 'UAS0103', 'UAS0103',
        --1* T1AntiAirBoat
        'UAS0102',
        },
    },
    { -- Wave Set 12
        SpawnTime = 15.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T1Frigate
        'UAS0103', 'UAS0103', 'UAS0103', 'UAS0103',
        --1* T1AntiAirBoat
        'UAS0102',
        },
    },
    { -- Wave Set 13
        SpawnTime = 15.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T1Frigate
        'UAS0103', 'UAS0103',
        --1* T1AntiAirBoat
        'UAS0102',
        --2* T2SubHunter
        'XAS0204', 'XAS0204',
        },
    },
    { -- Wave Set 14
        SpawnTime = 15.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T1Frigate
        'UAS0103', 'UAS0103',
        --1* T1AntiAirBoat
        'UAS0102',
        --2* T2SubHunter
        'XAS0204', 'XAS0204',
        },
    },
    { -- Wave Set 15
        SpawnTime = 16.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T1Frigate
        'UAS0103', 'UAS0103',
        --1* T1AntiAirBoat
        'UAS0102',
        --2* T2SubHunter
        'XAS0204', 'XAS0204',
        },
    },
    { -- Wave Set 16
        SpawnTime = 17.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T1Frigate
        'UAS0103', 'UAS0103',
        --1* T1AntiAirBoat
        'UAS0102',
        },
    },
    { -- Wave Set 17
        SpawnTime = 18.0,
        OrderId = 1,
        Formation = 'AttackFormation',
        UnitIds = {
        --2* T1Frigate
        'UAS0103', 'UAS0103',
        --1* T1AntiAirBoat
        'UAS0102',
        },
    },
    { -- Wave Set 18
        SpawnTime = 19.0,
        OrderId = 1,
        Formation = 'AttackFormation',
        UnitIds = {
        --2* T1Frigate
        'UAS0103', 'UAS0103',
        --1* T1AntiAirBoat
        'UAS0102',
        --2* T2SubHunter
        'XAS0204', 'XAS0204',
        },
    },
    { -- Wave Set 19
        SpawnTime = 20.0,
        OrderId = 1,
        Formation = 'AttackFormation',
        UnitIds = {
        --1* T1Frigate
        'UAS0103',
        --1* T1AntiAirBoat
        'UAS0102',
        --2* T2SubHunter
        'XAS0204', 'XAS0204',
        --1* T2Destroyer
        'UAS0201',
        },
    },
    { -- Wave Set 20
        SpawnTime = 21.0,
        OrderId = 1,
        Formation = 'AttackFormation',
        UnitIds = {
        --2* T1Frigate
        'UAS0103', 'UAS0103',
        --1* T1AntiAirBoat
        'UAS0102',
        },
    },    
    { -- Wave Set 21
        SpawnTime = 22.0,
        OrderId = 1,
        Formation = 'AttackFormation',
        UnitIds = {
        --2* T1Frigate
        'UAS0103', 'UAS0103',
        --1* T1AntiAirBoat
        'UAS0102',
        },
    },    
    { -- Wave Set 22
        SpawnTime = 23.0,
        OrderId = 1,
        Formation = 'AttackFormation',
        UnitIds = {
        --1* T1Frigate
        'UAS0103',
        --1* T1AntiAirBoat
        'UAS0102',
        --2* T2SubHunter
        'XAS0204', 'XAS0204',
        --1* T2Destroyer
        'UAS0201',
        },
    },    
    { -- Wave Set 23
        SpawnTime = 24.0,
        OrderId = 1,
        Formation = 'AttackFormation',
        UnitIds = {
        --1* T1Frigate
        'UAS0103',
        --2* T2SubHunter
        'XAS0204', 'XAS0204',
        --1* T2Destroyer
        'UAS0201',
        --1* T2AntiAirBoat
        'UAS0202',
        },
    },    
    { -- Wave Set 24
        SpawnTime = 25.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T1Frigate
        'UAS0103', 'UAS0103',
        --1* T1AntiAirBoat
        'UAS0102',
        },
    },
    { -- Wave Set 25
        SpawnTime = 26.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T1Frigate
        'UAS0103', 'UAS0103',
        --1* T1AntiAirBoat
        'UAS0102',
        },
    },
    { -- Wave Set 26
        SpawnTime = 29.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --1* T1Frigate
        'UAS0103',
        --2* T2SubHunter
        'XAS0204', 'XAS0204',
        --1* T2Destroyer
        'UAS0201',
        --1* T2AntiAirBoat
        'UAS0202',
        },
    },
    { -- Wave Set 27
        SpawnTime = 30.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --1* T1Frigate
        'UAS0103',
        --2* T2SubHunter
        'XAS0204', 'XAS0204',
        --2* T2Destroyer
        'UAS0201', 'UAS0201',
        --1* T2AntiAirBoat
        'UAS0202',
        },
    },
    { -- Wave Set 28
        SpawnTime = 31.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --1* T1Frigate
        'UAS0103',
        --2* T2SubHunter
        'XAS0204', 'XAS0204',
        --2* T2Destroyer
        'UAS0201', 'UAS0201',
        --1* T2AntiAirBoat
        'UAS0202',
        },
    },
    { -- Wave Set 29
        SpawnTime = 32.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --1* T1Frigate
        'UAS0103',
        --2* T2SubHunter
        'XAS0204', 'XAS0204',
        --2* T2Destroyer
        'UAS0201', 'UAS0201',
        --1* T2AntiAirBoat
        'UAS0202',
        },
    },   
    { -- Wave Set 30
        SpawnTime = 33.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T1Frigate
        'UAS0103', 'UAS0103',
        --1* T1AntiAirBoat
        'UAS0102',
        },
    },       
    { -- Wave Set 31
        SpawnTime = 34.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T1Frigate
        'UAS0103', 'UAS0103',
        --1* T1AntiAirBoat
        'UAS0102',
        },
    },  
    { -- Wave Set 32
        SpawnTime = 35.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T2SubHunter
        'XAS0204',
        --2* T2Destroyer
        'UAS0201', 'UAS0201',
        --1* T2AntiAirBoat
        'UAS0202',
        --1* T3Battleship
        'UAS0302',
        },
    },   
    { -- Wave Set 33
        SpawnTime = 36.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T2SubHunter
        'XAS0204',
        --2* T2Destroyer
        'UAS0201', 'UAS0201',
        --1* T2AntiAirBoat
        'UAS0202',
        --1* T3Battleship
        'UAS0302',
        },
    }, 
    { -- Wave Set 34
        SpawnTime = 37.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T2Destroyer
        'UAS0201', 'UAS0201',
        --1* T2AntiAirBoat
        'UAS0202',
        --2* T3Battleship
        'UAS0302', 'UAS0302',
        },
    },
    { -- Wave Set 35
        SpawnTime = 38.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T2Destroyer
        'UAS0201', 'UAS0201',
        --1* T2AntiAirBoat
        'UAS0202',
        --2* T3Battleship
        'UAS0302', 'UAS0302',
        },
    },
    { -- Wave Set 36
        SpawnTime = 39.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T2Destroyer
        'UAS0201', 'UAS0201',
        --1* T2AntiAirBoat
        'UAS0202',
        --2* T3Battleship
        'UAS0302', 'UAS0302',
        },
    },
    { -- Wave Set 37
        SpawnTime = 40.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --1* T2AntiAirBoat
        'UAS0202',
        --2* T3Battleship
        'UAS0302', 'UAS0302',
        --1* T4ExpBattleship
        'UAS0401',
        },
    },
    { -- Wave Set 38
        SpawnTime = 41.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --1* T2AntiAirBoat
        'UAS0202',
        --2* T3Battleship
        'UAS0302', 'UAS0302',
        --1* T4ExpBattleship
        'UAS0401',
        },
    },
    { -- Wave Set 39
        SpawnTime = 42.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --1* T2AntiAirBoat
        'UAS0202',
        --2* T3Battleship
        'UAS0302', 'UAS0302',
        --1* T4ExpBattleship
        'UAS0401',
        },
    },
    { -- Wave Set 40
        SpawnTime = 43.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --1* T2AntiAirBoat
        'UAS0202',
        --2* T3Battleship
        'UAS0302', 'UAS0302',
        --3* T4ExpBattleship
        'UAS0401', 'UAS0401', 'UAS0401',
        },
    },
}