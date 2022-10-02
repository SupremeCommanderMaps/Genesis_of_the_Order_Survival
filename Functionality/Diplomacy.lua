-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

function SetupDiplomacy(PlayerArmies)


    local ArmyAlly = "ARMY_ALLY_UEF"
    local ArmyEnemy = "ARMY_ENEMY_AEON"
    local SeraphimArmyEnemy = "ARMY_ENEMY_SERAPHIM"
    local ArmyHq = "ARMY_ALLY_UEF_HQ"
    local ArmyAeonBoss = "ARMY_ENEMY_AEON_BOSS"
    

    for _, Army in PlayerArmies do
        for _, ArmyX in PlayerArmies do
            SetAlliance(Army, ArmyX, 'Ally')
            SetAlliedVictory(Army, true)
        end
    end
    for _, Army in PlayerArmies do
        SetAlliance(Army, ArmyAlly, 'Ally')
        SetAlliance(Army, ArmyHq, 'Ally') 

        SetAlliance(Army, ArmyEnemy, 'Enemy') 
        SetAlliance(Army, SeraphimArmyEnemy, 'Enemy') 
        SetAlliance(Army, ArmyAeonBoss, 'Enemy') 
    end

    SetAlliance(ArmyAlly, ArmyAlly, 'Ally')
    SetAlliance(ArmyAlly, ArmyEnemy, 'Enemy')
    SetAlliance(ArmyAlly, SeraphimArmyEnemy, 'Enemy')
    SetAlliance(ArmyAlly, ArmyHq, 'Ally')
    SetAlliance(ArmyAlly, ArmyAeonBoss, 'Enemy')

    SetAlliance(ArmyEnemy, ArmyAlly, 'Enemy')
    SetAlliance(ArmyEnemy, ArmyEnemy, 'Ally')
    SetAlliance(ArmyEnemy, SeraphimArmyEnemy, 'Ally') 
    SetAlliance(ArmyEnemy, ArmyHq, 'Enemy') 
    SetAlliance(ArmyEnemy, ArmyAeonBoss, 'Ally')

    SetAlliance(SeraphimArmyEnemy, ArmyAlly, 'Enemy') 
    SetAlliance(SeraphimArmyEnemy, ArmyEnemy, 'Ally') 
    SetAlliance(SeraphimArmyEnemy, SeraphimArmyEnemy, 'Ally') 
    SetAlliance(SeraphimArmyEnemy, ArmyHq, 'Enemy') 
    SetAlliance(SeraphimArmyEnemy, ArmyAeonBoss, 'Ally')

    SetAlliance(ArmyHq, ArmyAlly, 'Ally')    
    SetAlliance(ArmyHq, ArmyEnemy, 'Enemy') 
    SetAlliance(ArmyHq, SeraphimArmyEnemy, 'Enemy')    
    SetAlliance(ArmyHq, ArmyHq, 'Ally') 
    SetAlliance(ArmyHq, ArmyAeonBoss, 'Enemy')


    SetAlliance(ArmyAeonBoss, ArmyAlly, 'Enemy')    
    SetAlliance(ArmyAeonBoss, ArmyEnemy, 'Ally') 
    SetAlliance(ArmyAeonBoss, SeraphimArmyEnemy, 'Ally')    
    SetAlliance(ArmyAeonBoss, ArmyHq, 'Enemy') 
    SetAlliance(ArmyAeonBoss, ArmyAeonBoss, 'Ally')

    SetIgnoreArmyUnitCap('ARMY_ENEMY_AEON', true)
    SetIgnoreArmyUnitCap('ARMY_ENEMY_SERAPHIM', true)

    GetArmyBrain(ArmyEnemy):SetResourceSharing(false)
    GetArmyBrain(SeraphimArmyEnemy):SetResourceSharing(false)

    GetArmyBrain(ArmyAlly):GiveStorage('Energy', 10000)
    GetArmyBrain(ArmyEnemy):GiveStorage('Energy', 10000)
    GetArmyBrain(SeraphimArmyEnemy):GiveStorage('Energy', 10000)
    GetArmyBrain(ArmyHq):GiveStorage('Energy', 100000)
    GetArmyBrain(ArmyAeonBoss):GiveStorage('Energy', 100000)

    SetArmyColor(ArmyAlly,205,195,174) 
    SetArmyColor(ArmyEnemy,126,155,77) 
    SetArmyColor(SeraphimArmyEnemy,174,161,109) 
    SetArmyColor(ArmyHq,20,30,135) 
    SetArmyColor(ArmyAeonBoss,227,128,128) 
end

