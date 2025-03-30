-- sigil collection UI stuff
SMODS.current_mod.custom_collection_tabs = function()
	return { UIBox_button {
        count = G.ACTIVE_MOD_UI and modsCollectionTally(G.P_CENTER_POOLS["Sigil"]),
        button = 'your_collection_sigil',
        label = {"Sigils"}, minw = 5, id = 'your_collection_sigil'
    }}
end

G.FUNCS.your_collection_sigil = function(e)
    G.SETTINGS.paused = true
    G.FUNCS.overlay_menu{
      definition = create_UIBox_your_collection_sigil(),
    }
end

create_UIBox_your_collection_sigil = function()
    return SMODS.card_collection_UIBox(G.P_CENTER_POOLS.Sigil, {5,5}, {
        snap_back = true,
        infotip = localize('ml_edition_sigil_enhancement_explanation'),
        hide_single_page = true,
        collapse_single_page = true,
        center = 'c_base',
        h_mod = 1.03,
        modify_card = function(card, center)
            card:apply_sigil(center.key, true)
        end,
    })
end

-- Death card stuff
Deathcard.create_UIBox_select_summon_materials = function(card)

    local amount = #G.jokers.cards + 1
    BalatroInscrybed.death_card_area = CardArea(0, 10, G.CARD_W, G.CARD_H*3.4, 
    {card_limit = 1, type = 'title', highlight_limit = 1})
    BalatroInscrybed.chose_card_one = CardArea(0, 0, G.CARD_W, G.CARD_H*1, 
    {card_limit = amount, type = 'title', highlight_limit = 1})


    return {
        n = G.UIT.ROOT, config = {align = "cm", minw = G.ROOM.T.w * 5, minh = G.ROOM.T.h * 5, padding = 0, r = 0.1, colour = HEX("3F4A61")}, nodes = {
            {n=G.UIT.R, config={align = "tm"},nodes={
                {n=G.UIT.C, config={align = "tm", padding    =-.5},nodes={
                    {n=G.UIT.O, config = {object = Sprite(0, 0, 12, 12, G.ASSET_ATLAS['insc_dcc'], {x=0,y=0}), hover = true, can_collide = false}},
                }},
                {n=G.UIT.C, config={align = "tm", padding =-.5},nodes={
                    {n=G.UIT.O, config = {object = BalatroInscrybed.death_card_area, hover = true, can_collide = false}},
                }},     
                {n=G.UIT.C, config={align = "tm", padding =-.5},nodes={ 
                    {n=G.UIT.O, config = {object = Sprite(0, 0, 12, 12, G.ASSET_ATLAS['insc_dcc'], {x=1,y=0}), hover = true, can_collide = false}}, 
                }},             
            }},
            {n=G.UIT.R, config={align = "bm", padding = 0,  minh=4,},nodes={
                {n=G.UIT.O, config = {object = BalatroInscrybed.chose_card_one, hover = true, can_collide = false}},
            }},

        },}
end

G.FUNCS.death_card_start = function(e)
    G.OVERLAY_MENU:remove()
    G.OVERLAY_MENU = nil
    G.FUNCS.overlay_menu({
            definition = Deathcard.create_UIBox_select_summon_materials(card)
        })
    SMODS.add_card{
        key = "j_insc_deathcard",
        area = BalatroInscrybed.death_card_area
    }
    
    for i = #G.jokers.cards, 1, -1 do
        local card_ = G.jokers.cards[i]
        G.jokers:remove_card(card_)
        BalatroInscrybed.chose_card_one:emplace(card_)
    end
    SMODS.add_card{
        key = "j_insc_deathcard",
        BalatroInscrybed.chose_card_one
    } 
end

