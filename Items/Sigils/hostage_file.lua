local hostage_file = {
    object_type = "Sigil",
    name = "insc_Hostage_File",
    key = "hostage_file",
    badge_colour = HEX("9fff80"),
    config = { },
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=6, y=3},
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
            for i = 1, #context.removed do
                if context.removed[i] == card then
                    if #G.jokers.cards >= 1 then
                        local money = G.jokers.cards[1].cost
                        G.jokers.cards[1]:start_dissolve()
                        return{
                            dollars = money
                        }
                    end
                end
            end
        end
    end
}
return {name = {"Sigils"}, items = {hostage_file}}