local guardian = {
    object_type = "Sigil",
    name = "insc_Guardian",
    key = "guardian",
    badge_colour = HEX("9fff80"),
    config = { insert_in_deck = {false, "length"} },
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=10, y=6},
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    update = function(self, card, dt)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        if G.deck ~= nil and G.GAME.blind and (G.GAME.blind:get_type() == 'Boss') then
            card.ability.sigil[index].insert_in_deck[1] = true
        elseif G.GAME.blind and (G.GAME.blind:get_type() ~= 'Boss') then
            card.ability.sigil[index].insert_in_deck[1] = false
        end
    end
}
return {name = {"Sigils"}, items = {guardian}}