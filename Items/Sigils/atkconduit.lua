local atkconduit = {
    object_type = "Sigil",
    name = "insc_Attack_Conduit",
    key = "atkconduit",
    badge_colour = HEX("9fff80"),
    config = {mult = 7, circuit_active = false},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=6, y=4},
    loc_vars = function(self, info_queue, card)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        return { vars = {card.ability.sigil[index].mult} }
    end,
    circuit = true,
    calculate = function(self, card, context)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        if context.main_scoring and context.cardarea == G.play then
            for i = 1, #G.play.cards do
                if G.play.cards[i].ability.in_between_circuit then
                    SMODS.calculate_effect({mult_mod = card.ability.sigil[index].mult, message = localize{type='variable',key='a_mult',vars={card.ability.sigil[index].mult}}}, G.play.cards[i])
                end
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
        if G.hand ~= nil then
            local conduits = {}
            for i = 1, #G.hand.cards do
                if G.hand.cards[i].sigil ~= nil then
                    if G.hand.cards[i].sigil ~= nil then
                        if G.hand.cards[i].sigil[1] ~= nil then
                            if G.P_SIGILS[G.hand.cards[i].sigil[1]].circuit then
                                table.insert(conduits, i)
                            end
                        end
                        if G.hand.cards[i].sigil[2] ~= nil then
                            if G.P_SIGILS[G.hand.cards[i].sigil[2]].circuit then
                                table.insert(conduits, i)
                            end
                        end
                    end
                end
                G.hand.cards[i].ability.in_between_circuit = false
                card.ability.sigil[index].circuit_active = false
            end
            if #conduits >= 2 then
                index1 = conduits[1]
                for i = index1, conduits[#conduits] do
                    if i ~= index1 and i ~= conduits[#conduits] then
                        G.hand.cards[i].ability.in_between_circuit = true 
                        card.ability.sigil[index].circuit_active = true
                    end
                end
            end
        end
        if G.play ~= nil then
            local conduits = {}
            for i = 1, #G.play.cards do
                if G.play.cards[i].sigil ~= nil then
                    if G.play.cards[i].sigil ~= nil then
                        if G.play.cards[i].sigil[1] ~= nil then
                            if G.P_SIGILS[G.play.cards[i].sigil[1]].circuit then
                                table.insert(conduits, i)
                            end
                        end
                        if G.play.cards[i].sigil[2] ~= nil then
                            if G.P_SIGILS[G.play.cards[i].sigil[2]].circuit then
                                table.insert(conduits, i)
                            end
                        end
                    end
                end
                G.play.cards[i].ability.in_between_circuit = false
                card.ability.sigil[index].circuit_active = false
            end
            if #conduits >= 2 then
                index1 = conduits[1]
                for i = index1, conduits[#conduits] do
                    if i ~= index1 and i ~= conduits[#conduits] then
                        G.play.cards[i].ability.in_between_circuit = true 
                        card.ability.sigil[index].circuit_active = true
                    end
                end
            end
        end
    end,
}
return {name = {"Sigils"}, items = {atkconduit}}