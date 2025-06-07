local tidal = {
    object_type = "Sigil",
    name = "insc_Tidal_Lock",
    key = "tidal",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=7, y=0},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.playing_card_end_of_round and context.cardarea == G.hand then
            G.E_MANAGER:add_event(Event({
				func = (function()
					add_tag(Tag('tag_meteor'))
					play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
					play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
					return true
				end)
			}))
        end
    end
}
return {name = {"Sigils"}, items = {tidal}}