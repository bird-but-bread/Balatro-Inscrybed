local squirrel = {
    object_type = "Joker",
    name = "insc_squirrel",
    key = "squirrel",
    pos = { x = 2, y = 0 },
    config = { extra = { } },
    loc_vars = function(self, info_queue, center)
        return { vars = { } }
    end,
    yes_pool_flag = 'insc_beast_card',
    discovered = false,
    rarity = 1,
    cost = 0,
    order = 1,
    blueprint_compat = false,
    atlas = "leshy_cards",
    calculate = function(self, card, context)
        -- Nope
    end
}
return {name = {"BeastJokers"}, items = {squirrel}}