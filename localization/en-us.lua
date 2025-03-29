 return{
	descriptions={
		Back = {
            b_insc_beast_deck = {
                name = "Beast Deck",
                text = {
                    "its a deck",
                }
            },
		},
		spectral = {
			c_insc_spectral = {
				name = "insert name here",
				text = {
					"insert text here",
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
			},
		},
	misc={	
		labels={
			insc_fecundity_sigil = "Fecundity Sigil",
			insc_gifter_sigil = "Gift Bearer Sigil",
			insc_overclocked_sigil = "Overclocked Sigil",
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
