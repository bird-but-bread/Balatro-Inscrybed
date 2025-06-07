local leader = {
    object_type = "Sigil",
    name = "insc_Leader",
    key = "leader",
    badge_colour = HEX("9fff80"),
    config = { },
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=10, y=4},
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            for i = 1, #G.play.cards do
                if G.play.cards[i] == card then
                    if #G.play.cards == 1 then
                        return
                    elseif i == 1 then
						G.play.cards[i+1].ability.perma_mult = G.play.cards[i+1].ability.perma_mult + 5
                    elseif i == #G.play.cards then
						G.play.cards[i-1].ability.perma_mult = G.play.cards[i-1].ability.perma_mult + 5
                    else
                        local cards = {G.play.cards[i-1], G.play.cards[i+1]}
                        for j = 1, #cards do
                            cards[j].ability.perma_mult = cards[j].ability.perma_mult + 5
                        end
                    end
                end
            end
        end
    end,
}
return {name = {"Sigils"}, items = {leader}}