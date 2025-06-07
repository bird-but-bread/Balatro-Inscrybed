local amorphous = {
    object_type = "Sigil",
    name = "insc_Amorphous",
    key = "amorphous",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=8, y=1},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            local cen_pool = {}
            for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                if v.key ~= 'm_stone' then 
                    cen_pool[#cen_pool+1] = v
                end
            end
            local ed = pseudorandom_element(cen_pool, pseudoseed('amorphous_card'))
            card:set_ability(ed)
        end
    end
}
return {name = {"Sigils"}, items = {amorphous}}