 return{
	descriptions={
		Back = {
            b_insc_beast_deck = {
                name = "Beast Deck",
                text = {
                    "The {C:attention}first{} scored {C:attention}wild card{}",
					"of each round",
					"permanently gains {C:mult}+10{} Mult", 
					"then creates a copy",
					"Start with {C:attention}2{} {C:tarot,T:c_lovers}The Lovers{}",
                }
            },
		},
		Spectral = {
			c_insc_sigilapplyfec = {
				name = "Fecundity",
				text = {
					"Add a {C:red}Fecundity Sigil",
					"to #1# {C:attention}selected cards{}",
					"in your hand",
				}
			},
			c_insc_sigilapplygibe = {
				name = "Gift Bearer",
				text = {
					"Add a {C:red}Gift Bearer Sigil",
					"to #1# {C:attention}selected cards{}",
					"in your hand",
				}
			},
			c_insc_sigilapplyove = {
				name = "Overclocked",
				text = {
					"Add a {C:red}Overclocked Sigil",
					"to #1# {C:attention}selected cards{}",
					"in your hand",
				}
			},
		},
		insc_Event = {
			ev_insc_sacrifice ={
				name="Sacrifice",
				text={
					"{C:red}Sacrifice{} a joker",
					"for it's sigil",
				},
			},
			ev_insc_campfire ={
				name="Campfire",
				text={
					"{C:attention}Increase{} a jokers",
					"stats",
				},
			},
		},
		Other={
		  	insc_fecundity_sigil ={
				name="Fecundity",
				text={
					"When a card bearing this Sigil is {C:attention}scored{}",
					"{C:green}#1# in #2#{} chance",
					"to create a {C:attention}copy{}",
				},
			},
		  	insc_gifter_sigil ={
				name = "Gift Bearer",
				text = {
					"When a card", 
					"bearing this Sigil is {C:attention}Discarded{}",
					"Create a random joker",
					},
			},
			insc_overclocked_sigil ={
				name = "Overclocked",
				text = {
					"{X:mult,C:white} X#1# {} Mult.", 
					"If a card bearing this sigil is played and",
					"doesn't win, {C:green}#2# in #3#{} chance it breaks.",
				},
			},
			insc_parasite_sigil ={
				name = "Brood Parasite",
				text = {
					"When a card bearing",
					"this sigil is {C:red}discarded{}",
					"create the {C:attention}Egg Joker",
					"{C:inactive}(Must have room)",
				},
			},
			insc_double_sigil ={
				name = "Double Strike",
				text = {
					"{C:attention}Retriggers{} this card",
					"once",
				},
			},
			insc_airborne_sigil ={
				name = "Airborne",
				text = {
					"This card {C:attention}always{}",
					"scores",
				},
			},
			insc_waterborne_sigil ={
				name = "Waterborne",
				text = {
					"This card {C:attention}cannot{}",
					"be {C:red}debuffed"
				},
			},
			insc_stone_sigil ={
				name = "Made of Stone",
				text = {
					"This card is {C:attention}considered{}",
					"a {C:dark_edition}Stone Card"
				},
			},
			insc_bifurcated_sigil ={
				name = "Bifurcated Strike",
				text = {
					"This card is counted {C:attention}two times",
					"when calculating {C:attention}Poker Hands.",
					"{C:inactive}(High Card -> Pair)"
				},
			},
			insc_trifurcated_sigil ={
				name = "Trifurcated Strike",
				text = {
					"This card is counted {C:attention}three times",
					"when calculating {C:attention}Poker Hands.",
					"{C:inactive}(High Card -> Three of a Kind)"
				},
			},
			insc_lives_sigil ={
				name = "Many Lives",
				text = {
					"This card will {C:attention}come back",
					"after being {C:red}discarded",
					"or {C:red}destroyed",
				},
			},
			insc_unkillable_sigil ={
				name = "Unkillable",
				text = {
					"When a card bearing this sigil",
					"is {C:red}destroyed{} {C:attention}three{} copies of",
					"it are {C:attention}added{} to your deck",
					"without the sigil"
				},
			},
			insc_sacrifice_sigil ={
				name = "Worthy Sacrifice",
				text = {
					"This card draws {C:attention}#1#{} cards",
					"instead of {C:attention}1{} when {C:red}discarded",
				},
			},
			insc_amorphous_sigil ={
				name = "Amorphous",
				text = {
					"When this card is {C:attention}played{} it",
					"gains a {C:attention}random{} {C:dark_edition}enhancement",
				},
			},
			insc_tidal_sigil ={
				name = "Tidal Lock",
				text = {
					"If a card bearing this sigil",
					"is {C:attention}held in hand{} until end of",
					"round, create a {C:planet}Meteor tag"
				},
			},
			insc_fledgling_sigil ={
				name = "Fledgling",
				text = {
					"This card gains {C:mult}+#2#{} Mult",
					"whenever played but {C:attention}not scored",
					"{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
				},
			},
			insc_atkconduit_sigil ={
				name = "Attack Conduit",
				text = {
					"If a card bearing this sigil",
					"creates a {C:attention}circuit{}, all played",
					"cards {C:attention}inside{} of it give {C:mult}+#1#{} mult"
				},
			},
			insc_gemconduit_sigil ={
				name = "Gem Spawn Conduit",
				text = {
					"If a card bearing this sigil",
					"creates a {C:attention}circuit{}, all stone",
					"cards in the {C:attention}circuit{} give {C:mult}X#1#{} mult"
				},
			},
			insc_buff_powered_sigil ={
				name = "Buff When Powered",
				text = {
					"If a card bearing this",
					"sigil is inside a {C:attention}circuit{}",
					"it gives {C:mult}X#1#{} mult",
				},
			},
			insc_digger_sigil ={
				name = "Bone Digger",
				text = {
					"When this card is {C:attention}held in",
					"{C:attention}hand{} draw an {C:attention}additional{} card"
				},
			},
			insc_bellist_sigil ={
				name = "Bellist",
				text = {
					"When a card bearing this",
					"sigil is {C:attention}held in hand{} it will",
					"{C:green}trigger{} the {C:dark_edition}enhancements",
					"of the cards {C:attention}next{} to it"
				},
			},
			insc_tail_sigil ={
				name = "Loose Tail",
				text = {
					"When this card would be {C:red}destroyed",
					"don't destroy it and add a {C:attention}copy",
					"with {C:attention}half the rank{} of the original"
				},
			},
			insc_gift_powered_sigil ={
				name = "Gift When Powered",
				text = {
					"If a card bearing this",
					"sigil is inside a {C:attention}circuit{}",
					"and {C:attention}not scored{}, create",
					"a {C:attention}random{} joker"
				},
			},
			insc_trifurcated_powered_sigil ={
				name = "Trifurcated When Powered",
				text = {
					"If a card bearing this",
					"sigil is inside a {C:attention}circuit{}, it",
					"counts {C:attention}three times{} when",
					"calculating {C:attention}Poker Hands",
				},
			},
			insc_trinket_sigil ={
				name = "Trinket Bearer",
				text = {
					"When this card is {C:attention}played{} gain",
					" a {C:attention}random{} consumable",
				},
			},
			insc_repulsive_sigil ={
				name = "Repulsive",
				text = {
					"When this card is {C:attention}held in",
					"{C:attention}hand{} the boss blind is {C:red}disabled"
				},
			},
			insc_shield_latch_sigil ={
				name = "Shield Latch",
				text = {
					"When this card is {C:red}destroyed",
					"generate {C:attention}The Chariot{} consumable"
				},
			},
			insc_bomb_latch_sigil ={
				name = "Bomb Latch",
				text = {
					"When this card is {C:red}destroyed",
					"generate {C:attention}The Hanged Man{} consumable"
				},
			},
			insc_brittle_latch_sigil ={
				name = "Brittle Latch",
				text = {
					"When this card is {C:red}destroyed",
					"generate {C:attention}Justice{} consumable"
				},
			},
			insc_mighty_leap_sigil ={
				name = "Mighty Leap",
				text = {
					"When {C:red}discarded{} in a boss blind",
					"{C:attention}disable{} the boss blind and",
					"{C:red}destroy{} this card"
				},
			},
			insc_frozen_sigil ={
				name = "Frozen Away",
				text = {
					"When this card is {C:red}destroyed",
					"create a copy with {C:chips}+#1#{} Chips",
					"and {C:mult}+#2#{} Mult",
				},
			},
			insc_swapper_sigil ={
				name = "Swapper",
				text = {
					"Swaps any {C:chips}Chips{}",
					"and {C:mult}Mult{} bonuses",
				},
			},
			insc_ant_sigil ={
				name = "Ant",
				text = {
					"{C:green}#2# in #3#{} chance to {C:attention}retrigger{}",
					"this card once for {C:attention}every{} ant",
					"{C:inactive}(Currently {C:green}#1#{}{C:inactive} Times)"
				},
			},
			insc_ant_spawner_sigil ={
				name = "Ant Spawner",
				text = {
					"{C:green}#1# in #2#{} chance for any card next",
					"to a card bearing this sigil to",
					"{C:green}gain{} the {C:dark_edition}Ant sigil{} when {C:attention}played"
				},
			},
			insc_clinger_sigil ={
				name = "Clinger",
				text = {
					"A card bearing this sigil",
					"is {C:attention}always{} selected",
				},
			},
			insc_detonator_sigil ={
				name = "Detonator",
				text = {
					"When a card bearing this sigil",
					"is {C:red}destroyed{}, {C:red}destroy{} the cards",
					"to the {C:attention}left{} and {C:attention}right",
					"of it as well"
				},
			},
			insc_burrower_sigil ={
				name = "Burrower",
				text = {
					"When a card bearing this sigil",
					"is played but {C:attention}not scored{}, draw",
					"an {C:attention}additional{} card"
				},
			},
			insc_armored_sigil ={
				name = "Armored",
				text = {
					"When this card is {C:attention}scored{} it",
					"{C:attention}returns{} to your hand",
				},
			},
			insc_guardian_sigil ={
				name = "Guardian",
				text = {
					"Cards bearing this sigil are",
					"{C:attention}automatically drawn{} to your",
					"first hand on a {C:attention}boss{} blind"
				},
			},
			insc_corpse_eater_sigil ={
				name = "Corpse Eater",
				text = {
					"When a card is {C:red}discarded{}, any",
					"cards bearing this sigil are",
					"{C:green}guaranteed{} to be {C:attention}drawn"
				},
			},
			insc_handy_sigil ={
				name = "Handy",
				text = {
					"When this card is {C:attention}played",
					"{C:red}discard{} your hand and",
					"{C:attention}draw{} a new one"
				},
			},
			insc_morsel_sigil ={
				name = "Morsel",
				text = {
					"When a card bearing this Sigil is",
					"{C:red}discarded{}, it's instead {C:red}destroyed{},",
					"and {C:green}levels up{} the {C:attention}last played hand"
				},
			},
			insc_energy_conduit_sigil ={
				name = "Energy Conduit",
				text = {
					"If a card bearing this sigil",
					"completes a {C:attention}circuit{}, the played",
					"hand does {C:attention}not{} cost a hand"
				},
			},
			insc_touch_death_sigil ={
				name = "Touch of Death",
				text = {
					"When a card bearing this Sigil is",
					"{C:attention}scored{}, gain {C:red}X#2#{} Mult and",
					"{C:red}destroy{} a {C:attention}random{} joker",
					"{C:inactive}(Currently {C:red}X#1#{} {C:inactive}Mult)"
				},
			},
		},
	},
	misc={	
		labels={
			insc_morsel_sigil = "Morsel Sigil",
			insc_touch_death_sigil = "Touch of Death Sigil",
			insc_energy_conduit_sigil = "Energy Sigil",
			insc_handy_sigil = "Handy Sigil",
			insc_guardian_sigil = "Guardian Sigil",
			insc_corpse_eater_sigil = "Corpse Eater Sigil",
			insc_armored_sigil = "Armored Sigil",
			insc_burrower_sigil = "Burrower Sigil",
			insc_detonator_sigil = "Detonator Sigil",
			insc_swapper_sigil = "Swapper Sigil",
			insc_clinger_sigil = "Clinger Sigil",
			insc_ant_sigil = "Ant Sigil",
			insc_ant_spawner_sigil = "Ant Spawner Sigil",
			insc_frozen_sigil = "Frozen Away Sigil",
			insc_mighty_leap_sigil = "Mighty Leap Sigil",
			insc_brittle_latch_sigil = "Brittle Latch Sigil",
			insc_bomb_latch_sigil = "Bomb Latch Sigil",
			insc_shield_latch_sigil = "Shield Latch Sigil",
			insc_bellist_sigil = "Bellist Sigil",
			insc_repulsive_sigil = "Repulsive Sigil",
			insc_trinket_sigil = "Trinket Bearer Sigil",
			insc_tail_sigil = "Loose Tail Sigil",
			insc_fecundity_sigil = "Fecundity Sigil",
			insc_gifter_sigil = "Gift Bearer Sigil",
			insc_overclocked_sigil = "Overclocked Sigil",
			insc_parasite_sigil = "Brood Parasite Sigil",
			insc_double_sigil = "Double Strike Sigil",
			insc_airborne_sigil = "Airborne Sigil",
			insc_waterborne_sigil = "Waterborne Sigil",
			insc_stone_sigil = "Made of Stone Sigil",
			insc_bifurcated_sigil = "Bifurcated Strike Sigil",
			insc_trifurcated_sigil = "Trifurcated Strike Sigil",
			insc_lives_sigil = "Many Lives Sigil",
			insc_unkillable_sigil = "Unkillable Sigil",
			insc_sacrifice_sigil = "Worthy Sacrifice Sigil",
			insc_amorphous_sigil = "Amorphous Sigil",
			insc_tidal_sigil = "Tidal Lock Sigil",
			insc_fledgling_sigil = "Fledgling Sigil",
			insc_atkconduit_sigil = "Attack Conduit Sigil",
			insc_gemconduit_sigil = "Gem Spawn Conduit Sigil",
			insc_buff_powered_sigil = "Buff When Powered Sigil",
			insc_gift_powered_sigil = "Gift When Powered Sigil",
			insc_digger_sigil = "Bone Digger Sigil",
			insc_trifurcated_powered_sigil = "Trifurcated When Powered Sigil",
		},
		dictionary = {
			b_create_death_card = "Create Death Card",
			ml_edition_sigil_enhancement_explanation = {
					"Playing cards may each have one",
					"Enhancement, Edition, Sigil, and Seal"
			},
			insc_swap = 'Swap!',
		}
  	},
}
