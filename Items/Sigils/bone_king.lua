local bone_king = {
    object_type = "Sigil",
    name = "insc_Bone_King",
    key = "bone_king",
    badge_colour = HEX("9fff80"),
    config = { },
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=9, y=1},
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        if context.hand_drawn then
            for i = 1,#context.hand_drawn do
                if context.hand_drawn[i] == card then
                    ease_discard(1)
                end
            end
        end
    end
}
return {name = {"Sigils"}, items = {bone_king}}