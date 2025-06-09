local ant_spawner = {
    object_type = "Sigil",
    name = "insc_Ant_Spawner",
    key = "ant_spawner",
    badge_colour = HEX("9fff80"),
    config = {ants = 0, odds = 4},
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
        return { vars = {G.GAME.probabilities.normal or 1, card.ability.sigil[index].odds} }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            local index = nil
            if card.sigil ~= nil then
                if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                    index = 1
                elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                    index = 2
                end
            end
            for i = 1, #G.play.cards do
                if G.play.cards[i] == card then
                    local sigil = card.ability.sigil[index]
                    if #G.play.cards == 1 then
                        return
                    elseif i == 1 then
                        if pseudorandom('ant_spawner') < G.GAME.probabilities.normal / sigil.odds then
						    G.play.cards[i+1]:set_sigil("insc_ant", nil, false)
                        end
                    elseif i == #G.play.cards then
                        if pseudorandom('ant_spawner') < G.GAME.probabilities.normal / sigil.odds then
						    G.play.cards[i-1]:set_sigil("insc_ant", nil, false)
                        end
                    else
                        local cards = {G.play.cards[i-1], G.play.cards[i+1]}
                        for j = 1, #cards do
                            if pseudorandom('ant_spawner') < G.GAME.probabilities.normal / sigil.odds then
                                cards[j]:set_sigil("insc_ant", nil, false)
                            end
                        end
                    end
                end
            end
        end
    end,
}
return {name = {"Sigils"}, items = {ant_spawner}}