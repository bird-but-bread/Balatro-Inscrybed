local test_blind = {
    object_type = "Blind",
    key = 'test_blind',
    insc_advanced_blind = true,
    boss = {
      min = 2,
    },
    mult = 1,
    boss_colour = HEX('926fcd'),
    atlas = 'blinds',
    pos = { x = 0, y = 0 },

    calculate = function(self, blind, context)
        
    end
}
return {name = {"Blinds"}, items = {test_blind}}