local energy_conduit = {
    object_type = "Sigil",
    name = "insc_Energy_Conduit",
    key = "energy_conduit",
    badge_colour = HEX("9fff80"),
    config = { circuit_active = false, no_hand_remove = true, hands_left = nil, r_hands_left = nil, way_to_much_configs = 0},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=5, y=4},
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
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
        if context.hand_drawn or context.first_hand_drawn then
            card.ability.sigil[index].hands_left = G.GAME.current_round.hands_left
            self.config.way_to_much_configs = 0
        end
        if context.main_scoring and context.cardarea == G.play then
            for i = 1, #G.play.cards do
                if G.play.cards[i].sigil ~= nil and ((G.play.cards[i].sigil[1] ~= nil and G.play.cards[i].ability.sigil[1].no_hand_remove) or (G.play.cards[i].sigil[2] ~= nil and G.play.cards[i].ability.sigil[2].no_hand_remove)) then 
                    if G.play.cards[i].ability.sigil[index].circuit_active and G.play.cards[i].ability.sigil[index].hands_left ~= nil then
                        if (G.play.cards[i].ability.sigil[index].hands_left) > (self.config.r_hands_left) then
                            ease_hands_played(1)
                            self.config.way_to_much_configs = self.config.way_to_much_configs + 1
                            self.config.r_hands_left = self.config.r_hands_left + 1
                            break
                        end
                    end
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
        self.config.r_hands_left = G.GAME.current_round.hands_left + self.config.way_to_much_configs
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
return {name = {"Sigils"}, items = {energy_conduit}}