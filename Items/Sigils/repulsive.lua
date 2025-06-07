local repulsive = {
    object_type = "Sigil",
    name = "insc_Repulsive",
    key = "repulsive",
    badge_colour = HEX("9fff80"),
    config = { trigger = false, card = nil },
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=10, y=1},
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        if context.hand_drawn and context.cardarea == G.hand and (self.config.trigger == false or self.config.trigger == "nil") then
            for i = 1, #G.hand.cards do
                if G.hand.cards[i].sigil ~= nil then
                    if (G.hand.cards[i].sigil[1] ~= nil and G.hand.cards[i].sigil[1] == self.key) or (G.hand.cards[i].sigil[2] ~= nil and G.hand.cards[i].sigil[2] == self.key) then
                        self.config.trigger = true
                        return
                    end
                end
            end
        end
        if self.config.trigger ~= "nil" then
            if context.before and context.cardarea == G.play and self.config.trigger then
                for i = 1, #G.play.cards do
                    if G.play.cards[i].sigil ~= nil then
                        if (G.play.cards[i].sigil[1] ~= nil and G.play.cards[i].sigil[1] == self.key) or (G.play.cards[i].sigil[2] ~= nil and G.play.cards[i].sigil[2] == self.key) then
                            self.config.trigger = false
                            return
                        end
                    end
                end
            end
            if context.remove_playing_cards and context.removed and self.config.trigger then
                for i = 1, #context.removed do
                    if context.removed[i].sigil ~= nil then
                        if (context.removed[i].sigil[1] ~= nil and context.removed[i].sigil[1] == self.key) or (context.removed[i].sigil[2] ~= nil and context.removed[i].sigil[2] == self.key) then
                            self.config.trigger = false
                            return
                        end
                    end
                end
            end
            if context.discard and self.config.trigger then
                for i = 1, #G.hand.highlighted do
                    if G.hand.highlighted[i].sigil ~= nil then
                        if (G.hand.highlighted[i].sigil[1] ~= nil and G.hand.highlighted[i].sigil[1] == self.key) or (G.hand.highlighted[i].sigil[2] ~= nil and G.hand.highlighted[i].sigil[2] == self.key) then
                            self.config.trigger = false
                            return
                        end
                    end
                end
            end
        end
    end,
    update = function(self, card, dt)
        if self.config.trigger ~= "nil" then
            if self.config.trigger then
                if G.GAME.blind and ((not G.GAME.blind.disabled) and (G.GAME.blind:get_type() == 'Boss')) then 
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('ph_boss_disabled')})
                    G.GAME.blind:disable()
                end
            elseif not self.config.trigger then
                if G.GAME.blind and ((G.GAME.blind.disabled) and (G.GAME.blind:get_type() == 'Boss')) then 
                    local blind = G.GAME.blind
                    blind.disabled = false
                    G.GAME.blind:set_blind(blind, true, true)
                    G.GAME.blind:set_text()
                    self.config.trigger = "nil"
                end
            end
        end
    end
}
return {name = {"Sigils"}, items = {repulsive}}