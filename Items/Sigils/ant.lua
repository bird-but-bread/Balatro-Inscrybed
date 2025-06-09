local ant = {
    object_type = "Sigil",
    name = "insc_Ant",
    key = "ant",
    badge_colour = HEX("9fff80"),
    config = {ants = 0, odds = 2},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=4, y=3},
    loc_vars = function(self, info_queue, card)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        return { vars = {card.ability.sigil[index].ants, G.GAME.probabilities.normal or 1, card.ability.sigil[index].odds} }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.repetition then
            local index = nil
            if card.sigil ~= nil then
                if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                    index = 1
                elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                    index = 2
                end
            end
            local retriggers = 0
            local sigil = card.ability.sigil[index]
            for i = 1, card.ability.sigil[index].ants do
                if pseudorandom('ant') < G.GAME.probabilities.normal / sigil.odds then
                    retriggers = retriggers + 1
                end
            end
            if retriggers > 0 then
                return {
                    message = localize('k_again_ex'),
                    repetitions = retriggers,
                    card = card
                }
            end
        end
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
        card.ability.sigil[index].ants = 0
        if G.hand ~= nil then
            for i = 1, #G.hand.cards do
                if G.hand.cards[i].sigil ~= nil then
                    if G.hand.cards[i].sigil ~= nil then
                        if G.hand.cards[i].sigil[1] ~= nil then
                            if G.hand.cards[i].ability.sigil[1].ants then
                                card.ability.sigil[index].ants = card.ability.sigil[index].ants + 1
                            end
                        end
                        if G.hand.cards[i].sigil[2] ~= nil then
                            if G.hand.cards[i].ability.sigil[2].ants then
                                card.ability.sigil[index].ants = card.ability.sigil[index].ants + 1
                            end
                        end
                    end
                end
            end
        end
        if G.play ~= nil then
            for i = 1, #G.play.cards do
                if G.play.cards[i].sigil ~= nil then
                    if G.play.cards[i].sigil ~= nil then
                        if G.play.cards[i].sigil[1] ~= nil then
                            if G.play.cards[i].ability.sigil[1].ants then
                                card.ability.sigil[index].ants = card.ability.sigil[index].ants + 1
                            end
                        end
                        if G.play.cards[i].sigil[2] ~= nil then
                            if G.play.cards[i].ability.sigil[2].ants then
                                card.ability.sigil[index].ants = card.ability.sigil[index].ants + 1
                            end
                        end
                    end
                end
            end
        end
        if G.jokers ~= nil then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.insc_ant_trigger ~= nil and G.jokers.cards[i].ability.insc_ant_trigger then
                    card.ability.sigil[index].ants = card.ability.sigil[index].ants + 1
                end
                if G.jokers.cards[i].ability.extra ~= nil and type(G.jokers.cards[i].ability.extra) == "table" and G.jokers.cards[i].ability.extra.insc_ant_trigger ~= nil and G.jokers.cards[i].ability.extra.insc_ant_trigger then
                    card.ability.sigil[index].ants = card.ability.sigil[index].ants + 1
                end
            end
        end
    end
}
return {name = {"Sigils"}, items = {ant}}