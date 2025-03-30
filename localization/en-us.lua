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
			insc_trifurcated_powered_sigil ={
				name = "Trifurcated When Powered",
				text = {
					"If a card bearing this",
					"sigil is inside a {C:attention}circuit{}, it",
					"counts {C:attention}three times{} when",
					"calculating {C:attention}Poker Hands",
				},
			},
		},
	},
	misc={	
		labels={
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
			insc_trifurcated_powered_sigil = "Trifurcated When Powered Sigil",
		},
		dictionary = {
			b_create_death_card = "Create Death Card",
			ml_edition_sigil_enhancement_explanation = {
					"Playing cards may each have one",
					"Enhancement, Edition, Sigil, and Seal"
			},
		}
  	},
}
