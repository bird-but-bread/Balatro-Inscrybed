local sacrifice = {
    object_type = "insc_Event",
    name = "insc_Sacrifice",
    key = "sacrifice",
    config = {},
    atlas = 'insc_events',
    pos = {x=0, y=0},
    disabled = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
}
return {name = {"Events"}, items = {sacrifice}}