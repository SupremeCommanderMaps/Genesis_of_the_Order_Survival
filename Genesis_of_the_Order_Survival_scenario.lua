version = 3 -- Lua Version. Dont touch this
ScenarioInfo = {
    name = "Genesis of the Order Survival",
    description = "",
    preview = '',
    map_version = 21,
    AdaptiveMap = true,
    type = 'skirmish',
    starts = true,
    size = {1024, 1024},
    reclaim = {360, 0},
    map = '/maps/genesis_of_the_order_survival.v0021/Genesis_of_the_Order_Survival.scmap',
    save = '/maps/genesis_of_the_order_survival.v0021/Genesis_of_the_Order_Survival_save.lua',
    script = '/maps/genesis_of_the_order_survival.v0021/Genesis_of_the_Order_Survival_script.lua',
    norushradius = 40,
    Configurations = {
        ['standard'] = {
            teams = {
                {
                    name = 'FFA',
                    armies = {'ARMY_1', 'ARMY_2', 'ARMY_3', 'ARMY_4', 'ARMY_5'}
                },
            },
            customprops = {
                ['ExtraArmies'] = STRING( 'ARMY_ALLY_UEF ARMY_ENEMY_AEON ARMY_ALLY_UEF_HQ ARMY_ENEMY_SERAPHIM ARMY_ENEMY_ORDER_BOSS' ),
            },
        },
    },
}
