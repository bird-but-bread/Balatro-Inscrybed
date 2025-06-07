local clinger = {
    object_type = "Sigil",
    name = "insc_Clinger",
    key = "clinger",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=1, y=6},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    update = function(self, card, dt)
        if G.hand ~= nil then
            if (card.area.config.type == 'hand') then
                local in_hand = false
                if card.highlighted and G.hand.highlighted[i] == card then
                    return
                else
                    card:highlight(true)
                    for i = 1, #G.hand.highlighted do
                        if G.hand.highlighted[i] == card then
                            in_hand = true
                            return
                        end
                    end
                    if not in_hand then
                        table.insert(G.hand.highlighted, card)
                    end
                end
            end
        end
    end,
}
return {name = {"Sigils"}, items = {clinger}}