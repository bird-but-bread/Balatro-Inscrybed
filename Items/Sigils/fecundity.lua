local fecundity = {
    object_type = "Sigil",
    name = "insc_fecundity",
    key = "fecundity",
    badge_colour = HEX("9fff80"),
    config = { odds = 4 },
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=3, y=3},
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal or 1, self.config.odds } }--might be center.config.odds
    end,
    -- consider changing the functionality to only add to hand and not to deck permenantly
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            if pseudorandom('rat_test') < G.GAME.probabilities.normal/self.config.odds then -- tell me if this breaks because why make it hard coded? -smg9000
                --this code is just stolen from DNA
                local card = copy_card(card, nil, nil, G.playing_card)
                card:add_to_deck()
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                table.insert(G.playing_cards, card)
                G.hand:emplace(card)
                card.states.visible = nil
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:start_materialize()
                        return true end,
                }))
                return{
                    message = {
                        "Infested!",
                    }
                }
            else
                return{
                    message = {"Aw, rats!"}
                }
            end
        end
    end
}
return {name = {"Sigils"}, items = {fecundity}}