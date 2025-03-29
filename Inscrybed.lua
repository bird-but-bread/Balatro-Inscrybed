----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas {
    key = "sigils",
    path = "SigilAtlas.png",
    px = 71,
    py = 95
}
SMODS.Atlas {
    key = "po3",
    path = "po3_template.png",
    px = 71,
    py = 95
}
SMODS.Atlas {
    key = "beast",
    path = "beast_sprites.png",
    px = 71,
    py = 95
}
SMODS.Atlas {
    key = "dcc",
    path = "Death_card_Mockup.png",
    px = 640,
    py = 720
}
BalatroInscrybed = SMODS.current_mod

Deathcard = {}
BalatroInscrybed.Sigils = {}



assert(SMODS.load_file("items/utility.lua"))()
assert(SMODS.load_file("Items/Sigils.lua"))()
assert(SMODS.load_file("Items/Jokers.lua"))()
assert(SMODS.load_file("Items/Decks.lua"))()
assert(SMODS.load_file("Items/spectral.lua"))()



--if G and G.GAME and G.GAME.modifiers and G.GAME.modifiers.beast
    
--end













--this is the template for all the other sigils, this was made BEFORE it was changed into it's own object, and is still a seal

--SMODS.Sigil { 
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















     

----------------------------------------------
------------MOD CODE END----------------------
