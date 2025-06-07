local detonator = {
    object_type = "Sigil",
    name = "insc_Detonator",
    key = "detonator",
    badge_colour = HEX("9fff80"),
    config = {trigger = false},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=11, y=1},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        local remove_table = {}
        if card.ability.sigil[index].trigger and not context.remove_playing_cards then
            if G.hand ~= nil then
                for i = 1, #G.hand.cards do
                    if G.hand.cards[i] == card then
                        if #G.hand.cards == 1 then
                            return
                        elseif i == 1 then
                            table.insert(remove_table, G.hand.cards[i+1])
                        elseif i == #G.hand.cards then
                            table.insert(remove_table, G.hand.cards[i-1])
                        else
                            local cards = {G.hand.cards[i-1], G.hand.cards[i+1]}
                            for j = 1, #cards do
                                table.insert(remove_table, cards[j])
                            end
                        end
                    end
                end
            end
            if G.play ~= nil then
                for i = 1, #G.play.cards do
                    if G.play.cards[i] == card then
                        if #G.play.cards == 1 then
                            return
                        elseif i == 1 then
                            table.insert(remove_table, G.play.cards[i+1])
                        elseif i == #G.play.cards then
                            table.insert(remove_table, G.play.cards[i-1])
                        else
                            local cards = {G.play.cards[i-1], G.play.cards[i+1]}
                            for j = 1, #cards do
                                table.insert(remove_table, cards[j])
                            end
                        end
                    end
                end
            end
        end
        if context.remove_playing_cards and not context.blueprint then
            for l = 1, #context.removed do
                if context.removed[l] == card then
                    if G.hand ~= nil then
                        for i = 1, #G.hand.cards do
                            if G.hand.cards[i] == card then
                                if #G.hand.cards == 1 then
                                    return
                                elseif i == 1 then
                                    table.insert(remove_table, G.hand.cards[i+1])
                                elseif i == #G.hand.cards then
                                    table.insert(remove_table, G.hand.cards[i-1])
                                else
                                    local cards = {G.hand.cards[i-1], G.hand.cards[i+1]}
                                    for j = 1, #cards do
                                        table.insert(remove_table, cards[j])
                                    end
                                end
                            end
                        end
                    end
                    if G.play ~= nil then
                        for i = 1, #G.play.cards do
                            if G.play.cards[i] == card then
                                if #G.play.cards == 1 then
                                    return
                                elseif i == 1 then
                                    table.insert(remove_table, G.play.cards[i+1])
                                elseif i == #G.play.cards then
                                    table.insert(remove_table, G.play.cards[i-1])
                                else
                                    local cards = {G.play.cards[i-1], G.play.cards[i+1]}
                                    for j = 1, #cards do
                                        table.insert(remove_table, cards[j])
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        if #remove_table > 1 then
            for i = 1, #remove_table do
                local index2 = nil
                if remove_table[i].sigil ~= nil then
                    if remove_table[i].sigil[1] ~= nil and remove_table[i].sigil[1] == self.key then
                        index2 = 1
                    elseif remove_table[i].sigil[2] ~= nil and remove_table[i].sigil[2] == self.key then
                        index2 = 2
                    end
                end
                if remove_table[i].sigil ~= nil and index ~= nil then
                    remove_table[i].ability.sigil[index].trigger = true
                else
                    remove_table[i]:start_dissolve()
                end
            end
        end
        if card.ability.sigil[index].trigger and not context.remove_playing_cards then
            card:start_dissolve()
        end
    end
}
return {name = {"Sigils"}, items = {detonator}}