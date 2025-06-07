local trifurcated_powered = {
    object_type = "Sigil",
    name = "insc_Trifurcated_When_Powered",
    key = "trifurcated_powered",
    badge_colour = HEX("9fff80"),
    config = {furcated = 1},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=7, y=4},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    update = function(self, card, dt)
        if G.hand ~= nil then
            for i = 1, #G.hand.cards do
                if G.hand.cards[i].sigil ~= nil then
                    if G.hand.cards[i].sigil ~= nil then
                        if G.hand.cards[i].sigil[1] ~= nil then
                            if G.P_SIGILS[G.hand.cards[i].sigil[1]].furcated then
                                if G.hand.cards[i].ability.in_between_circuit then
                                    G.hand.cards[i].ability.sigil[1].furcated = 3
                                else
                                    G.hand.cards[i].ability.sigil[1].furcated = 1
                                end
                            end
                        end
                        if G.hand.cards[i].sigil[2] ~= nil then
                            if G.P_SIGILS[G.hand.cards[i].sigil[2]].furcated then
                                if G.hand.cards[i].ability.in_between_circuit then
                                    G.hand.cards[i].ability.sigil[2].furcated = 3
                                else
                                    G.hand.cards[i].ability.sigil[2].furcated = 1
                                end
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
                            if G.P_SIGILS[G.play.cards[i].sigil[1]].furcated then
                                if G.play.cards[i].ability.in_between_circuit then
                                    G.play.cards[i].ability.sigil[1].furcated = 3
                                else
                                    G.play.cards[i].ability.sigil[1].furcated = 1
                                end
                            end
                        end
                        if G.play.cards[i].sigil[2] ~= nil then
                            if G.P_SIGILS[G.play.cards[i].sigil[2]].furcated then
                                if G.play.cards[i].ability.in_between_circuit then
                                    G.play.cards[i].ability.sigil[2].furcated = 3
                                else
                                    G.play.cards[i].ability.sigil[2].furcated = 1
                                end
                            end
                        end
                    end
                end
            end
        end
    end,
}
return {name = {"Sigils"}, items = {trifurcated_powered}}