local bat = {
    object_type = "Joker",
    name = "insc_bat",
    key = "bat",
    pos = { x = 3, y = 1 },
    config = { insc_sacrifice_sigils = {"airborne"}, extra = { } },
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    yes_pool_flag = 'insc_beast_card',
    discovered = false,
    rarity = 1,
    cost = 4,
    order = 1,
    blueprint_compat = false,
    atlas = "leshy_cards",
    calculate = function(self, card, context)
        if context.discard then
            if context.other_card:is_suit("Hearts") then
               context.other_card:change_suit("Spades") 
            end
        end
    end,
}
return {name = {"BeastJokers"}, items = {bat}}