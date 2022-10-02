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
        OrderId = 7,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T2 Tanks   
        'XSL0202', 'XSL0202', 
        --1* T2 Hover AA
        'XSL0205',
        },
    },
    { -- Wave Set 2
        OrderId = 7,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T2 Tanks   
        'XSL0202', 'XSL0202', 
        --1* T2 Hover AA
        'XSL0205',
        },
    },
    { -- Wave Set 3
        OrderId = 3,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T2 Tanks   
        'XSL0202', 'XSL0202', 
        --1* T2 Hover AA
        'XSL0205',
        },
    },
    { -- Wave Set 4
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T3 Sniperbot
        'XSL0305', 'XSL0305',
        },
    },
    { -- Wave Set 5
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T3 Mobile Arty
        'XSL0304', 'XSL0304',
        --1* T2 Hover AA
        'XSL0205',
        },
    },
    { -- Wave Set 6
        OrderId = 3,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T3 Tank
        'XSL0303', 'XSL0303',
        },
    },
    { -- Wave Set 7
        OrderId = 3,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T3 Tank
        'XSL0303', 'XSL0303',
        },
    },
    { -- Wave Set 8
        OrderId = 3,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T3 Tank
        'XSL0303', 'XSL0303',
        --1* T2 Hover AA
        'XSL0205',
        },
    },
    { -- Wave Set 9
        OrderId = 3,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T3 Tank
        'XSL0303', 'XSL0303',
        },
    },
    { -- Wave Set 10
        OrderId = 3,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T3 Tank
        'XSL0303', 'XSL0303',
        --1* T2 Hover AA
        'XSL0205',
        },
    },
    { -- Wave Set 11
        OrderId = 3,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T3 Tank
        'XSL0303', 'XSL0303',
        },
    },
    { -- Wave Set 12
        OrderId = 3,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T3 Tank
        'XSL0303', 'XSL0303',
        --1* T2 Hover AA
        'XSL0205',
        },
    },
    { -- Wave Set 13
        OrderId = 1,
        Formation = 'GrowthFormation',
        UnitIds = {
        --2* T3 Mobile Arty
        'XSL0304', 'XSL0304',
        --1* T2 Hover AA
        'XSL0205',
        },
    },
    { -- Wave Set 14
        OrderId = 3,
        Formation = 'GrowthFormation',
        UnitIds = {
        --1* T4 Exp
        'XSL0401',
        --3* T3 AA
        'dslk004', 'dslk004', 'dslk004',
        },
    },
    { -- Wave Set 15
        OrderId = 3,
        Formation = 'AttackFormation',
        UnitIds = {
        --2* T4 Exp
        'XSL0401', 'XSL0401',
        },
    },
}