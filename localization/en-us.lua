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
					"Retrigger all {C:attention}held in hand",
					"effects on this card and",
					"{C:attention}any{} cards next to it",
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
		},
	},
	misc={	
		labels={
			insc_swapper_sigil = "Swapper Sigil",
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
