local digger = {
    object_type = "Sigil",
    name = "insc_Bone_Digger",
    key = "digger",
    badge_colour = HEX("9fff80"),
    config = {active = false, trigger = 0},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=5, y=5},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {}
        }
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
        if context.main_scoring and context.cardarea == G.play then
            for i = 1, #G.play.cards do
                if G.play.cards[i].sigil ~= nil and card == G.play.cards[i] then
                    G.GAME.insc_extra_draw = G.GAME.insc_extra_draw - 1
                    break
                end
            end
        end
        if G.hand ~= nil then
            local _card = nil
            for i = 1, #G.hand.cards do
                if G.hand.cards[i].sigil ~= nil and card == G.hand.cards[i] then
                    card.ability.sigil[index].trigger = 1
                    _card = G.hand.cards[i]
                    break
                end
            end
            if _card ~= nil then
                if _card.sigil ~= nil then
                    if _card.sigil[index] ~= nil then
                        if card.ability.sigil[index].trigger == 1 then
                            if not card.ability.sigil[index].active then
                                G.GAME.insc_extra_draw = G.GAME.insc_extra_draw + 1
                                card.ability.sigil[index].active = true
                                card.ability.sigil[index].trigger = -1
                            end
                        else
                            if card.ability.sigil[index].active then
                                G.GAME.insc_extra_draw = G.GAME.insc_extra_draw - 1
                                card.ability.sigil[index].active = false
                            end
                        end
                        if context.hand_drawn then
                            card.ability.sigil[index].trigger = 1
                            card.ability.sigil[index].active = false
                        end
                    end
                end 
            end
        end
    end
}
return {name = {"Sigils"}, items = {digger}}