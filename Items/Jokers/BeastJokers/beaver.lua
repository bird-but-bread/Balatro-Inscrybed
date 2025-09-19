local beaver = {
    object_type = "Joker",
    name = "Beaver",
    key = "beaver",
    insc_type = "None",
    pos = { x = 4, y = 0 },
    config = { insc_sacrifice_sigils = {"dam_builder"}, extra = {counts_as_enhance = 'm_stone' } },
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    yes_pool_flag = 'insc_beast_card',
    discovered = false,
    rarity = 2,
    cost = 6,
    order = 1,
    blueprint_compat = false,
    atlas = "leshy_cards",
    update = function(self, card, dt)
        if G.playing_cards then
            for k, v in pairs(G.playing_cards) do
                if SMODS.get_enhancements(v).m_stone then
                    if v.ability.counts_as_enhance then
                        local skip = false
                        for i = 1, #v.ability.counts_as_enhance do
                            if v.ability.counts_as_enhance[i] == 'm_wild' then
                                skip = true
                            end
                        end
                        if not skip then
                            table.insert(v.ability.counts_as_enhance, 'm_wild')
                        end
                    else
                        v.ability.counts_as_enhance = {}
                        table.insert(v.ability.counts_as_enhance, 'm_wild')
                    end
                end
            end
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        for k, v in pairs(G.playing_cards) do
            if SMODS.get_enhancements(v).m_stone then
                if v.ability.counts_as_enhance then
                    local skip = nil
                    for i = 1, #v.ability.counts_as_enhance do
                        if v.ability.counts_as_enhance[i] == 'm_wild' then
                            skip = i
                        end
                    end
                    if skip then
                        table.remove(v.ability.counts_as_enhance, skip)
                    end
                end
            end
        end
    end,
}
return {name = {"BeastJokers"}, items = {beaver}}