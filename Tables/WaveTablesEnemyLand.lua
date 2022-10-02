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
    { -- Wave Set 0
        SpawnTime = 0.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T1 Scout   
        'UAL0101', 'UAL0101', 
        --4* T1BOT
        'UAL0106', 'UAL0106', 'UAL0106', 'UAL0106',
        },
    },
    { -- Wave Set 0.5
        SpawnTime = 0.1,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T1 Scout   
        'UAL0101', 'UAL0101', 
        --4* T1BOT
        'UAL0106', 'UAL0106', 'UAL0106', 'UAL0106',
        },
    },
    { -- Wave Set 1
        SpawnTime = 0.2,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T1 Scout   
        'UAL0101', 'UAL0101', 
        --4* T1BOT
        'UAL0106', 'UAL0106', 'UAL0106', 'UAL0106',
        },
    },
    { -- Wave Set 2
        SpawnTime = 0.5,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --8* T1BOT
        'UAL0106', 'UAL0106', 'UAL0106', 'UAL0106',
        'UAL0106', 'UAL0106', 'UAL0106', 'UAL0106',
        },
    },
    { -- Wave Set 3
        SpawnTime = 1.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --4* T1BOT
        'UAL0106', 'UAL0106', 'UAL0106', 'UAL0106', 
        --3* T1TANK
        'UAL0201', 'UAL0201', 'UAL0201',
        },
    },
    { -- Wave Set 4
        SpawnTime = 1.5,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T1BOT
        'UAL0106', 'UAL0106',
        --4* T1TANK
        'UAL0201', 'UAL0201', 'UAL0201', 'UAL0201',
        },
    },
    { -- Wave Set 5
        SpawnTime = 2.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --6* T1TANK
        'UAL0201', 'UAL0201',
        'UAL0201', 'UAL0201', 'UAL0201', 'UAL0201',
        },
    },
    { -- Wave Set 6
        SpawnTime = 2.5,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --8* T1TANK
        'UAL0201', 'UAL0201', 'UAL0201', 'UAL0201',
        'UAL0201', 'UAL0201', 'UAL0201', 'UAL0201',
        },
    },
    { -- Wave Set 7
        SpawnTime = 3.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --6* T1TANK
        'UAL0201', 'UAL0201', 'UAL0201', 'UAL0201', 'UAL0201', 'UAL0201',
        --2* T1ARTY
        'UAL0103', 'UAL0103',
        },
    },
    { -- Wave Set 8
        SpawnTime = 3.5,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --6* T1TANK
        'UAL0201', 'UAL0201', 'UAL0201', 'UAL0201', 'UAL0201', 'UAL0201',
        --2* T1ARTY
        'UAL0103', 'UAL0103',
        },
    },
    { -- Wave Set 9
        SpawnTime = 4.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --4* T1TANK
        'UAL0201', 'UAL0201', 'UAL0201', 'UAL0201',
        --4 * T1ARTY
        'UAL0103', 'UAL0103', 'UAL0103', 'UAL0103',
        },
    },
    { -- Wave Set 10
        SpawnTime = 4.5,
        OrderId = 1,
        Formation = 'AttackFormation',
        UnitIds = {
        --3* T1TANK
        'UAL0201', 'UAL0201', 'UAL0201',
        --4* T1ARTY
        'UAL0103', 'UAL0103', 'UAL0103', 'UAL0103',
        --1* T2HoverTank
        'XAL0203',
        },
    },
    { -- Wave Set 11
        SpawnTime = 5.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --3* T1TANK
        'UAL0201', 'UAL0201', 'UAL0201',
        --3* T1ARTY
        'UAL0103', 'UAL0103', 'UAL0103',
        --2* T2HoverTank
        'XAL0203', 'XAL0203',
        },
    },
    { -- Wave Set 12
        SpawnTime = 5.5,
        OrderId = 1,
        Formation = 'AttackFormation',
        UnitIds = {
        --2* T1TANK
        'UAL0201', 'UAL0201',
        --4* T1ARTY
        'UAL0103', 'UAL0103', 'UAL0103', 'UAL0103',
        --3* T2HoverTank
        'XAL0203', 'XAL0203', 'XAL0203',
        --1* T2AntiAirHover
        'UAL0205',
        },
    },
    { -- Wave Set 13
        SpawnTime = 6.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T1ARTY
        'UAL0103', 'UAL0103',
        --6* T2HoverTank
        'XAL0203', 'XAL0203', 'XAL0203', 'XAL0203', 'XAL0203', 'XAL0203',
        --1* T2AntiAirHover
        'UAL0205',
        },
    },
    { -- Wave Set 14
        SpawnTime = 6.5,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T1ARTY
        'UAL0103', 'UAL0103',
        --6* T2HoverTank
        'XAL0203', 'XAL0203', 'XAL0203', 'XAL0203', 'XAL0203', 'XAL0203',
        --1* T2AntiAirHover
        'UAL0205',
        },
    },
    { -- Wave Set 15
        SpawnTime = 7.0,
        OrderId = 1,
        Formation = 'AttackFormation',
        UnitIds = {
        --2* T1ARTY
        'UAL0103',
        --6* T2HoverTank
        'XAL0203', 'XAL0203', 'XAL0203', 'XAL0203', 'XAL0203', 'XAL0203',
        --2* T2AntiAirHover
        'UAL0205', 'UAL0205',
        },
    },
    { -- Wave Set 16
        SpawnTime = 7.5,
        OrderId = 1,
        Formation = 'AttackFormation',
        UnitIds = {
        --1* T1ARTY
        'UAL0103',
        --6* T2HoverTank
        'XAL0203', 'XAL0203', 'XAL0203', 'XAL0203', 'XAL0203', 'XAL0203',
        --2* T2AntiAirHover
        'UAL0205', 'UAL0205',
        },
    },
    { -- Wave Set 17
        SpawnTime = 8.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --1* T1ARTY
        'UAL0103',
        --4* T2HoverTank
        'XAL0203', 'XAL0203', 'XAL0203', 'XAL0203',
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205','UAL0205',
        --1* T2HeavyTank
        'UAL0202',
        },
    },
    { -- Wave Set 18
        SpawnTime = 8.5,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --1* T1ARTY
        'UAL0103',
        --4* T2HoverTank
        'XAL0203', 'XAL0203', 'XAL0203', 'XAL0203',
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205','UAL0205',
        --1* T2HeavyTank
        'UAL0202',
        },
    },
    { -- Wave Set 19
        SpawnTime = 9.0,
        OrderId = 1,
        Formation = 'AttackFormation',
        UnitIds = {
        --1* T1ARTY
        'UAL0103',
        --4* T2HoverTank
        'XAL0203', 'XAL0203', 'XAL0203', 'XAL0203',
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205','UAL0205',
        --2* T2HeavyTank
        'UAL0202', 'UAL0202',
        },
    },
    { -- Wave Set 20
        SpawnTime = 9.5,
        OrderId = 1,
        Formation = 'AttackFormation',
        UnitIds = {
        --4* T2HoverTank
        'XAL0203', 'XAL0203', 'XAL0203', 'XAL0203',
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205','UAL0205',
        --3* T2HeavyTank
        'UAL0202', 'UAL0202', 'UAL0202',
        },
    },
    { -- Wave Set 21
        SpawnTime = 10.0,
        OrderId = 3,
        Formation = 'AttackFormation',
        UnitIds = {
        --2* T2AntiAirHover
        'UAL0205', 'UAL0205',
        --4* T2HeavyTank
        'UAL0202', 'UAL0202', 'UAL0202',
        'UAL0202',
        },
    },
    { -- Wave Set 22
        SpawnTime = 10.5,
        OrderId = 3,
        Formation = 'AttackFormation',
        UnitIds = {
        --2* T2AntiAirHover
        'UAL0205', 'UAL0205',
        --4* T2HeavyTank       
        'UAL0202', 'UAL0202', 'UAL0202',
        'UAL0202',
        },
    },
    { -- Wave Set 23
        SpawnTime = 11.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --4* T2HoverTank
        'XAL0203', 'XAL0203', 'XAL0203', 'XAL0203',
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',
        --2* T2HeavyTank
        'UAL0202', 'UAL0202',
        },
    },
    { -- Wave Set 24
        SpawnTime = 11.5,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T2HoverTank
        'XAL0203', 'XAL0203',
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',
        --2* T2HeavyTank
        'UAL0202', 'UAL0202',
        },
    },
    { -- Wave Set 25
        SpawnTime = 12.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',
        --3* T2HeavyTank
        'UAL0202', 'UAL0202', 'UAL0202',
        --3* T2MobileMissileLauncher
        'UAL0111', 'UAL0111',
        },
    },
    { -- Wave Set 26
        SpawnTime = 12.5,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205','UAL0205',
        --4* T2HeavyTank
        'UAL0202', 'UAL0202', 'UAL0202', 'UAL0202',
        --3* T2MobileMissileLauncher
        'UAL0111', 'UAL0111',
        },
    },
    { -- Wave Set 27
        SpawnTime = 13.0,
        OrderId = 1,
        Formation = 'AttackFormation',
        UnitIds = {
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205','UAL0205',
        --4* T2HeavyTank
        'UAL0202', 'UAL0202', 'UAL0202', 'UAL0202',
        --3* T2MobileMissileLauncher
        'UAL0111', 'UAL0111', 'UAL0111',
        },
    },
    { -- Wave Set 28
        SpawnTime = 13.5,
        OrderId = 1,
        Formation = 'AttackFormation',
        UnitIds = {
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205','UAL0205',
        --4* T2HeavyTank
        'UAL0202', 'UAL0202', 'UAL0202', 'UAL0202',
        --3* T2MobileMissileLauncher
        'UAL0111', 'UAL0111', 'UAL0111',
        },
    },
    { -- Wave Set 29
        SpawnTime = 14.0,
        OrderId = 1,
        Formation = 'AttackFormation',
        UnitIds = {
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205','UAL0205',
        --4* T2HeavyTank
        'UAL0202', 'UAL0202', 'UAL0202', 'UAL0202',
        --3* T2MobileMissileLauncher
        'UAL0111', 'UAL0111', 'UAL0111',
        },
    },
    { -- Wave Set 30
        SpawnTime = 14.5,
        OrderId = 1,
        Formation = 'AttackFormation',
        UnitIds = {
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205','UAL0205',
        --4* T2HeavyTank
        'UAL0202', 'UAL0202', 'UAL0202', 'UAL0202',
        --3* T2MobileMissileLauncher
        'UAL0111', 'UAL0111', 'UAL0111',
        },
    },
    { -- Wave Set 31
        SpawnTime = 15.0,
        OrderId = 1,
        Formation = 'AttackFormation',
        UnitIds = {
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205','UAL0205',
        --7* T2MobileMissileLauncher
        'UAL0111', 'UAL0111', 'UAL0111', 'UAL0111', 'UAL0111', 'UAL0111', 'UAL0111',
        },
    },
    { -- Wave Set 32
        SpawnTime = 15.5,
        OrderId = 1,
        Formation = 'AttackFormation',
        UnitIds = {
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205','UAL0205',
        --7* T2MobileMissileLauncher
        'UAL0111', 'UAL0111', 'UAL0111', 'UAL0111', 'UAL0111', 'UAL0111', 'UAL0111',
        },
    },
    { -- Wave Set 33
        SpawnTime = 16.0,
        OrderId = 3,
        Formation = 'AttackFormation',
        UnitIds = {
        --8* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205', 'UAL0205', 'UAL0205',
        'UAL0205', 'UAL0205', 'UAL0205',
        },
    },
    { -- Wave Set 34
        SpawnTime = 16.5,
        OrderId = 3,
        Formation = 'AttackFormation',
        UnitIds = {        
        --8* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205', 'UAL0205', 'UAL0205',
        'UAL0205', 'UAL0205', 'UAL0205',
        },
    },
    { -- Wave Set 35
        SpawnTime = 17.0,
        OrderId = 3,
        Formation = 'GrowthFormation',
        UnitIds = {
        --10* T2HeavyTank
        'UAL0202', 'UAL0202', 'UAL0202', 'UAL0202', 'UAL0202',
        'UAL0202', 'UAL0202', 'UAL0202', 'UAL0202', 'UAL0202',
        },
    },
    { -- Wave Set 36
        SpawnTime = 17.5,
        OrderId = 3,
        Formation = 'GrowthFormation',
        UnitIds = {
        --10* T2HeavyTank
        'UAL0202', 'UAL0202', 'UAL0202', 'UAL0202', 'UAL0202',
        'UAL0202', 'UAL0202', 'UAL0202', 'UAL0202', 'UAL0202',
        },
    },
    { -- Wave Set 37
        SpawnTime = 18.0,
        OrderId = 3,
        Formation = 'AttackFormation',
        UnitIds = {
        --10* T2HeavyTank
        'UAL0202', 'UAL0202', 'UAL0202', 'UAL0202', 'UAL0202',
        'UAL0202', 'UAL0202', 'UAL0202', 'UAL0202', 'UAL0202',
        },
    },
    { -- Wave Set 38
        SpawnTime = 18,5,
        OrderId = 3,
        Formation = 'AttackFormation',
        UnitIds = {
        --10* T2HeavyTank
        'UAL0202', 'UAL0202', 'UAL0202', 'UAL0202', 'UAL0202',
        'UAL0202', 'UAL0202', 'UAL0202', 'UAL0202', 'UAL0202',
        },
    },
    { -- Wave Set 39
        SpawnTime = 19.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',
        --3* T2HeavyTank
        'UAL0202', 'UAL0202', 'UAL0202',
        --2* T3MobileArty
        'UAL0304', 'UAL0304',
        --2* T3MediumTank
        'UAL0303', 'UAL0303',
        },
    },
    { -- Wave Set 40
        SpawnTime = 19.5,
        OrderId = 1,
        Formation = 'AttackFormation',
        UnitIds = {
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',
        --4* T2HeavyTank
        'UAL0202', 'UAL0202', 'UAL0202', 'UAL0202',
        --2* T3MobileArty
        'UAL0304', 'UAL0304',
        --2* T3MediumTank
        'UAL0303', 'UAL0303',
        },
    },
    { -- Wave Set 41
        SpawnTime = 20.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',
        --4* T2HeavyTank
        'UAL0202', 'UAL0202', 'UAL0202', 'UAL0202',
        --2* T3MobileArty
        'UAL0304', 'UAL0304',
        --2* T3MediumTank
        'UAL0303', 'UAL0303',
        },
    },
    { -- Wave Set 42
        SpawnTime = 20.5,
        OrderId = 1,
        Formation = 'AttackFormation',
        UnitIds = {
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',
        --4* T2HeavyTank
        'UAL0202', 'UAL0202', 'UAL0202', 'UAL0202',
        --2* T3MobileArty
        'UAL0304', 'UAL0304',
        --2* T3MediumTank
        'UAL0303', 'UAL0303',
        },
    },
    { -- Wave Set 43
        SpawnTime = 21.0,
        OrderId = 1,
        Formation = 'AttackFormation',
        UnitIds = {
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',
        --4* T2HeavyTank
        'UAL0202', 'UAL0202', 'UAL0202', 'UAL0202',
        --2* T3MobileArty
        'UAL0304', 'UAL0304',
        --2* T3MediumTank
        'UAL0303', 'UAL0303',
        },
    },
    { -- Wave Set 44
        SpawnTime = 21.5,
        OrderId = 1,
        Formation = 'AttackFormation',
        UnitIds = {
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',
        --4* T2HeavyTank
        'UAL0202', 'UAL0202', 'UAL0202', 'UAL0202',
        --4* T3MobileArty
        'UAL0304', 'UAL0304',
        --4* T3MediumTank
        'UAL0303', 'UAL0303',
        },
    },
    { -- Wave Set 45
        SpawnTime = 22.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',
        --4* T2HeavyTank
        'UAL0202', 'UAL0202', 'UAL0202', 'UAL0202',
        --2* T3MobileArty
        'UAL0304', 'UAL0304',
        --2* T3MediumTank
        'UAL0303', 'UAL0303',
        },
    },
    { -- Wave Set 46
        SpawnTime = 22.5,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',
        --2* T2HeavyTank
        'UAL0202', 'UAL0202',
        --4* T3MobileArty
        'UAL0304', 'UAL0304', 'UAL0304', 'UAL0304',
        --1* T3MediumTank
        'UAL0303',
        },
    },
    { -- Wave Set 47
        SpawnTime = 23.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',
        --2* T2HeavyTank
        'UAL0202', 'UAL0202',
        --4* T3MobileArty
        'UAL0304', 'UAL0304', 'UAL0304', 'UAL0304',
        --1* T3MediumTank
        'UAL0303',
        },
    },
    { -- Wave Set 48
        SpawnTime = 23.5,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',
        --4* T3MobileArty
        'UAL0304', 'UAL0304', 'UAL0304', 'UAL0304',
        --3* T3MediumTank
        'UAL0303', 'UAL0303', 'UAL0303',
        },
    },
    { -- Wave Set 49
        SpawnTime = 24.0,
        OrderId = 3,
        Formation = 'AttackFormation',
        UnitIds = {
        --10* T3MediumTank
        'UAL0303', 'UAL0303', 'UAL0303', 'UAL0303', 'UAL0303', 'UAL0303',
        'UAL0303', 'UAL0303', 'UAL0303', 'UAL0303',
        },
    },
    { -- Wave Set 50
        SpawnTime = 24.5,
        OrderId = 3,
        Formation = 'AttackFormation',
        UnitIds = {
        --10* T3MediumTank
        'UAL0303', 'UAL0303', 'UAL0303', 'UAL0303', 'UAL0303', 'UAL0303',
        'UAL0303', 'UAL0303', 'UAL0303', 'UAL0303',
        },
    },
    { -- Wave Set 51
        SpawnTime = 25.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --8* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205', 'UAL0205', 'UAL0205', 'UAL0205', 'UAL0205', 'UAL0205',
        },
    },
    { -- Wave Set 52
        SpawnTime = 25.5,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --8* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205', 'UAL0205', 'UAL0205', 'UAL0205', 'UAL0205', 'UAL0205',
        },
    },
    { -- Wave Set 53
        SpawnTime = 26.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',
        --1* T3MobileArty
        'UAL0304',
        --5* T3MediumTank
        'UAL0303', 'UAL0303', 'UAL0303', 'UAL0303', 'UAL0303',
        },
    },
    { -- Wave Set 54
        SpawnTime = 26.5,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',
        --1* T3MobileArty
        'UAL0304',
        --5* T3MediumTank
        'UAL0303', 'UAL0303', 'UAL0303', 'UAL0303', 'UAL0303',
        },
    },
    { -- Wave Set 55
        SpawnTime = 27.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',
        --1* T3MobileArty
        'UAL0304',
        --5* T3MediumTank
        'UAL0303', 'UAL0303', 'UAL0303', 'UAL0303', 'UAL0303',
        },
    },
    { -- Wave Set 56
        SpawnTime = 27.5,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',
        --1* T3MobileArty
        'UAL0304',
        --5* T3MediumTank
        'UAL0303', 'UAL0303', 'UAL0303', 'UAL0303', 'UAL0303',
        },
    },
    { -- Wave Set 57
        SpawnTime = 28.0,
        OrderId = 1,
        Formation = 'AttackFormation',
        UnitIds = {
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',
        --1* T3MobileArty
        'UAL0304',
        --5* T3MediumTank
        'UAL0303', 'UAL0303', 'UAL0303', 'UAL0303', 'UAL0303',
        },
    },
    { -- Wave Set 58
        SpawnTime = 28.5,
        OrderId = 1,
        Formation = 'AttackFormation',
        UnitIds = {
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',
  
        --3* T3MediumTank
        'UAL0303', 'UAL0303', 'UAL0303',
        --4* T3MobileArty
        'UAL0304', 'UAL0304', 'UAL0304', 'UAL0304',
        },
    },
    { -- Wave Set 59
        SpawnTime = 29.0,
        OrderId = 3,
        Formation = 'AttackFormation',
        UnitIds = {
        --4* T3MediumTank
        'UAL0303', 'UAL0303', 'UAL0303', 'UAL0303',
        --3* T3MobileArty
        'UAL0304', 'UAL0304', 'UAL0304',
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',
        },
    },
    { -- Wave Set 60
        SpawnTime = 29.5,
        OrderId = 1,
        Formation = 'AttackFormation',
        UnitIds = {
        --4* T3MediumTank
        'UAL0303', 'UAL0303', 'UAL0303', 'UAL0303',
        --3* T3SniperBot
        'XAL0305', 'XAL0305', 'XAL0305',
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',
        },
    },
    { -- Wave Set 61
        SpawnTime = 30.0,
        OrderId = 1,
        Formation = 'AttackFormation',
        UnitIds = {
        --3* T3SniperBot
        'XAL0305', 'XAL0305', 'XAL0305', 'XAL0305', 'XAL0305', 'XAL0305', 
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',
        },
    },
    { -- Wave Set 62
        SpawnTime = 30.5,
        OrderId = 3,
        Formation = 'AttackFormation',
        UnitIds = {
        --7* T3MediumTank
        'UAL0303', 'UAL0303', 'UAL0303', 'UAL0303', 'UAL0303', 'UAL0303', 'UAL0303',
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',
        },
    },
    { -- Wave Set 63
        SpawnTime = 31.0,
        OrderId = 3,
        Formation = 'GrowthFormation',
        UnitIds = {
        --3* T3MediumTank
        'UAL0303', 'UAL0303', 'UAL0303',
        --5* T3MediumTank
        'UAL0303', 'UAL0303', 'UAL0303', 'UAL0303', 'UAL0303',
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',
        },
    },
    { -- Wave Set 64
        SpawnTime = 31.5,
        OrderId = 3,
        Formation = 'GrowthFormation',
        UnitIds = {
        --4* T3MediumTank
        'UAL0303', 'UAL0303', 'UAL0303', 'UAL0303',
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',
        --3* T3SniperBot
        'XAL0305', 'XAL0305', 'XAL0305',
        },
    },
    { -- Wave Set 65
        SpawnTime = 32.0,
        OrderId = 3,
        Formation = 'GrowthFormation',
        UnitIds = {
        --1* T3MediumTank
        'UAL0303',
        --3* T3SupportAcu
        'UAL0301', 'UAL0301', 'UAL0301',
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',

        },
    },
    { -- Wave Set 66
        SpawnTime = 32.5,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',
        --4* T3SniperBot
        'XAL0305', 'XAL0305', 'XAL0305', 'XAL0305',
        },
    },
    { -- Wave Set 67
        SpawnTime = 33.0,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',
        --3* T3SniperBot
        'XAL0305', 'XAL0305', 'XAL0305',
        },
    },
    { -- Wave Set 68
        SpawnTime = 33.5,
        OrderId = 3,
        Formation = 'GrowthFormation',
        UnitIds = {
        --3* T3SupportAcu
        'UAL0301', 'UAL0301', 'UAL0301',
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',
        --2* T3SupportAcusRambo
        'UAL0301_Rambo', 'UAL0301_Rambo',
        },
    },
    { -- Wave Set 69
        SpawnTime = 34.0,
        OrderId = 3,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T3SupportAcu
        'UAL0301', 'UAL0301',
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',
        --2* T3SupportAcusRambo
        'UAL0301_Rambo', 'UAL0301_Rambo',
        },
    },
    { -- Wave Set 70
        SpawnTime = 34.5,
        OrderId = 3,
        Formation = 'GrowthFormation',
        UnitIds = {
        --4* T3SupportAcusRambo
        'UAL0301_Rambo', 'UAL0301_Rambo', 'UAL0301_Rambo', 'UAL0301_Rambo',
        --3* T3AntiAir
        'DALK003', 'DALK003', 'DALK003',
        },
    },
    { -- Wave Set 71
        SpawnTime = 35.0,
        OrderId = 3,
        Formation = 'GrowthFormation',
        UnitIds = {
        --4* T3SupportAcusRambo
        'UAL0301_Rambo', 'UAL0301_Rambo', 'UAL0301_Rambo', 'UAL0301_Rambo',
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',
        },
    },
    { -- Wave Set 72
        SpawnTime = 35.5,
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',
        --3* T3SniperBot
        'XAL0305', 'XAL0305', 'XAL0305',
        --3* T3MobileArty
        'UAL0304', 'UAL0304', 'UAL0304',
        },
    },
    { -- Wave Set 73
        SpawnTime = 36,0,
        OrderId = 1,
        Formation = 'AttackFormation',
        UnitIds = {
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',
        --3* T3SniperBot
        'XAL0305', 'XAL0305', 'XAL0305',
        --3* T3MobileArty
        'UAL0304', 'UAL0304', 'UAL0304',
        },
    },
    { -- Wave Set 74
        SpawnTime = 36.5,
        OrderId = 3,
        Formation = 'GrowthFormation',
        UnitIds = {
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',
        --3* T3SniperBot
        'XAL0305', 'XAL0305',
        --1* T3SupportAcusRambo
        'UAL0301_Rambo',
        --1* T4Exp
        'UAL0401',
        },
    },
    { -- Wave Set 75
        SpawnTime = 37.0,
        OrderId = 3,
        Formation = 'GrowthFormation',
        UnitIds = {
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',
        --1* T3SupportAcusRambo
        'UAL0301_Rambo',
        --1* T4Exp
        'UAL0401',
        },
    },
    { -- Wave Set 76
        SpawnTime = 38.0,
        OrderId = 3,
        Formation = 'GrowthFormation',
        UnitIds = {
        --3* T2AntiAirHover
        'UAL0205', 'UAL0205', 'UAL0205',
        --4* T3SupportAcusRambo
        'UAL0301_Rambo', 'UAL0301_Rambo',
        --2* T4Exp
        'UAL0401', 'UAL0401',
        },
    },
    { -- Wave Set 77
        SpawnTime = 38.5,
        OrderId = 3,
        Formation = 'GrowthFormation',
        UnitIds = {
        --3* T3AntiAir
        'DALK003', 'DALK003', 'DALK003',
        --2* T3SupportAcusRambo
        'UAL0301_Rambo', 'UAL0301_Rambo',
        --2* T4Exp
        'UAL0401', 'UAL0401',
        },
    },
    { -- Wave Set 78
        SpawnTime = 39.0,
        OrderId = 1,
        Formation = 'AttackFormation',
        UnitIds = {
        --4* T3AntiAir
        'DALK003', 'DALK003', 'DALK003', 'DALK003',
        --3* T4Exp
        'UAL0401', 'UAL0401', 'UAL0401',
        },
    },
    { -- Wave Set 79
        SpawnTime = 39.5,
        OrderId = 3,
        Formation = 'AttackFormation',
        UnitIds = {
        --4* T3AntiAir
        'DALK003', 'DALK003', 'DALK003', 'DALK003',
        --3* T4Exp
        'UAL0401', 'UAL0401', 'UAL0401',
        },
    },    
    { -- Wave Set 80
        SpawnTime = 40.0,
        OrderId = 3,
        Formation = 'AttackFormation',
        UnitIds = {
        --5* T4Exp
        'UAL0401', 'UAL0401', 'UAL0401', 'UAL0401',
        'UAL0401',
        },
    },
    { -- Wave Set 81
        SpawnTime = 40.5,
        OrderId = 1,
        Formation = 'AttackFormation',
        UnitIds = {
        --7* T4Exp
        'UAL0401', 'UAL0401', 'UAL0401', 'UAL0401',
        'UAL0401', 'UAL0401', 'UAL0401',
        },
    },
}