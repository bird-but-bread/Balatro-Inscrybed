local kraken_waterborne = {
    object_type = "Sigil",
    name = "insc_Kraken_Waterborne",
    key = "kraken_waterborne",
    badge_colour = HEX("9fff80"),
    config = {tentacle = 0},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=0, y=7},
    loc_vars = function(self, info_queue, card)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        return { vars = {card.ability.sigil[index].tentacle} }
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
            for i = 1, card.ability.sigil[index].tentacle do
                retriggers = retriggers + 1
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
        card.ability.sigil[index].tentacle = 0
        if G.hand ~= nil then
            for i = 1, #G.hand.cards do
                if G.hand.cards[i].sigil ~= nil then
                    if G.hand.cards[i].sigil ~= nil then
                        if G.hand.cards[i].sigil[1] ~= nil then
                            if G.hand.cards[i].ability.sigil[1].tentacle then
                                card.ability.sigil[index].tentacle = card.ability.sigil[index].tentacle + 1
                            end
                        end
                        if G.hand.cards[i].sigil[2] ~= nil then
                            if G.hand.cards[i].ability.sigil[2].tentacle then
                                card.ability.sigil[index].tentacle = card.ability.sigil[index].tentacle + 1
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
                            if G.play.cards[i].ability.sigil[1].tentacle then
                                card.ability.sigil[index].tentacle = card.ability.sigil[index].tentacle + 1
                            end
                        end
                        if G.play.cards[i].sigil[2] ~= nil then
                            if G.play.cards[i].ability.sigil[2].tentacle then
                                card.ability.sigil[index].tentacle = card.ability.sigil[index].tentacle + 1
                            end
                        end
                    end
                end
            end
        end
        if G.jokers ~= nil then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.insc_tentacle_trigger ~= nil and G.jokers.cards[i].ability.insc_tentacle_trigger then
                    card.ability.sigil[index].tentacle = card.ability.sigil[index].tentacle + 1
                end
                if G.jokers.cards[i].ability.extra ~= nil and type(G.jokers.cards[i].ability.extra) == "table" and G.jokers.cards[i].ability.extra.insc_tentacle_trigger ~= nil and G.jokers.cards[i].ability.extra.insc_tentacle_trigger then
                    card.ability.sigil[index].tentacle = card.ability.sigil[index].tentacle + 1
                end
            end
        end
        if card.debuff then
            card.debuff = false
        end
    end
}
return {name = {"Sigils"}, items = {kraken_waterborne}}