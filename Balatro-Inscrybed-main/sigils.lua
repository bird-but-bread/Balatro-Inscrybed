--- STEAMODDED HEADER
--- MOD_NAME: Sigils mod
--- MOD_ID: Sigils
--- MOD_AUTHOR: [bird but bread]
--- MOD_DESCRIPTION: adds some sigils from inscryption

----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas {
    key = "sigils",
    path = "SigilAtlas.png",
    px = 134,
    py = 180
}

--this is the template for all the other sigils, this was made BEFORE it was changed into it's own object, and is still a seal

--SMODS.Seal { 
--    --creates the visuals and sets the local vars
--    name = "replaece me ",
--    key = "replace me",
--    badge_colour = HEX("9fff80"),
--    config = { },
--    loc_txt = {
--        label = "Sigil",
--        name = "NAME",
--        text = {
--            "text"
--        },
--    },
--    atlas = 'sigils',
--}





--fecundity 
SMODS.Seal { 
    name = "fecundity",
    key = "test",
    badge_colour = HEX("9fff80"),
    config = { odds = 4 },
    loc_txt = {
        label = "Sigil",
        name = "fecundity",
        text = {
            "when a card bearing this Sigil is {C:attention}scored{}",
            "{C:green}#1# in #2#{} chance",
            "to create a {C:attention}copy{}",
        },
    },
    atlas = 'sigils',
    pos = {x=0, y=0},
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal or 1, self.config.odds } }
        end,
        -- consider changing the functionality to only add to hand and not to deck permenantly
        calculate = function(self, card, context)
            if context.cardarea == G.play and context.main_scoring then
                
                if pseudorandom('rat_test') < G.GAME.probabilities.normal/4 then

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

--Gift Bearererere
SMODS.Seal { 
    name = "Gift Bearer",
    key = "gifter",
    badge_colour = HEX("9fff80"),
    config = {},
    loc_txt = {
        label = "Sigil",
        name = "Gift Bearer",
        text = {
            "when a card", 
            "bearing this Sigil is {C:attention}Discarded{}",
            "Create a random joker",
        },
    },
    atlas = 'test_atlas',
    pos = {x=0, y=0},
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal or 1, self.config.odds } }
        end,
        calculate = function(self, card, context)
            if context.discard then
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    message = "gift!",
                    func = (function()
                            local card = create_card('Joker',G.joker_main)
                            --card:add_to_deck()
                            G.jokers:emplace(card)
                        return true
                    end)
                }))
        end
    end
}




----------------------------------------------
------------MOD CODE END----------------------
