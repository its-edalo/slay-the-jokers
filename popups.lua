function Card:generate_locvars()
    local card_type = self.ability.set or "None"
    local loc_vars = nil

    if not self.bypass_lock and self.config.center.unlocked ~= false and
    (self.ability.set == 'Joker' or self.ability.set == 'Edition' or self.ability.consumeable or self.ability.set == 'Voucher' or self.ability.set == 'Booster') and
    not self.config.center.discovered and 
    ((self.area ~= G.jokers and self.area ~= G.consumeables and self.area) or not self.area) then
        card_type = 'Undiscovered'
    end    
    if self.config.center.unlocked == false and not self.bypass_lock then --For everyting that is locked
        card_type = "Locked"
        if self.area and self.area == G.shop_demo then loc_vars = {}; end
    -- elseif self.debuff then
        -- loc_vars = { debuffed = true, playing_card = not not self.base.colour, value = self.base.value, suit = self.base.suit, colour = self.base.colour }
    elseif card_type == 'Default' or card_type == 'Enhanced' then
        loc_vars = { playing_card = not not self.base.colour, value = self.base.value, suit = self.base.suit, colour = self.base.colour,
                    nominal_chips = self.base.nominal > 0 and self.base.nominal or nil,
                    bonus_chips = (self.ability.bonus + (self.ability.perma_bonus or 0)) > 0 and (self.ability.bonus + (self.ability.perma_bonus or 0)) or nil,
                }
    elseif self.ability.set == 'Joker' then
        if self.ability.name == 'Joker' then loc_vars = {self.ability.mult}
        elseif self.ability.name == 'Jolly Joker' or self.ability.name == 'Zany Joker' or
            self.ability.name == 'Mad Joker' or self.ability.name == 'Crazy Joker'  or 
            self.ability.name == 'Droll Joker' then 
            loc_vars = {self.ability.t_mult, localize(self.ability.type, 'poker_hands')}
        elseif self.ability.name == 'Sly Joker' or self.ability.name == 'Wily Joker' or
        self.ability.name == 'Clever Joker' or self.ability.name == 'Devious Joker'  or 
        self.ability.name == 'Crafty Joker' then 
            loc_vars = {self.ability.t_chips, localize(self.ability.type, 'poker_hands')}
        elseif self.ability.name == 'Half Joker' then loc_vars = {self.ability.extra.mult, self.ability.extra.size}
        elseif self.ability.name == 'Fortune Teller' then loc_vars = {self.ability.extra, (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.tarot or 0)}
        elseif self.ability.name == 'Steel Joker' then loc_vars = {self.ability.extra, 1 + self.ability.extra*(self.ability.steel_tally or 0)}
        elseif self.ability.name == 'Chaos the Clown' then loc_vars = {self.ability.extra}
        elseif self.ability.name == 'Space Joker' then loc_vars = {''..(G.GAME and G.GAME.probabilities.normal or 1), self.ability.extra}
        elseif self.ability.name == 'Stone Joker' then loc_vars = {self.ability.extra, self.ability.extra*(self.ability.stone_tally or 0)}
        elseif self.ability.name == 'Drunkard' then loc_vars = {self.ability.d_size}
        elseif self.ability.name == 'Green Joker' then loc_vars = {self.ability.extra.hand_add, self.ability.extra.discard_sub, self.ability.mult}
        elseif self.ability.name == 'Credit Card' then loc_vars = {self.ability.extra}
        elseif self.ability.name == 'Greedy Joker' or self.ability.name == 'Lusty Joker' or
            self.ability.name == 'Wrathful Joker' or self.ability.name == 'Gluttonous Joker' then loc_vars = {self.ability.extra.s_mult, localize(self.ability.extra.suit, 'suits_singular')}
        elseif self.ability.name == 'Blue Joker' then loc_vars = {self.ability.extra, self.ability.extra*((G.deck and G.deck.cards) and #G.deck.cards or 52)}
        elseif self.ability.name == 'Sixth Sense' then loc_vars = {}
        elseif self.ability.name == 'Hack' then loc_vars = {self.ability.extra+1}
        elseif self.ability.name == 'Faceless Joker' then loc_vars = {self.ability.extra.dollars, self.ability.extra.faces}
        elseif self.ability.name == 'Juggler' then loc_vars = {self.ability.h_size}
        elseif self.ability.name == 'Golden Joker' then loc_vars = {self.ability.extra}
        elseif self.ability.name == 'Joker Stencil' then loc_vars = {self.ability.x_mult}
        elseif self.ability.name == 'Ceremonial Dagger' then loc_vars = {self.ability.mult}
        elseif self.ability.name == 'Banner' then loc_vars = {self.ability.extra}
        elseif self.ability.name == 'Misprint' then
        elseif self.ability.name == 'Mystic Summit' then loc_vars = {self.ability.extra.mult, self.ability.extra.d_remaining}
        elseif self.ability.name == 'Loyalty Card' then loc_vars = {self.ability.extra.Xmult, self.ability.extra.every + 1, localize{type = 'variable', key = (self.ability.loyalty_remaining == 0 and 'loyalty_active' or 'loyalty_inactive'), vars = {self.ability.loyalty_remaining}}}
        elseif self.ability.name == '8 Ball' then loc_vars = {''..(G.GAME and G.GAME.probabilities.normal or 1),self.ability.extra}
        elseif self.ability.name == 'Dusk' then loc_vars = {self.ability.extra+1}
        elseif self.ability.name == 'Fibonacci' then loc_vars = {self.ability.extra}
        elseif self.ability.name == 'Scary Face' then loc_vars = {self.ability.extra}
        elseif self.ability.name == 'Abstract Joker' then loc_vars = {self.ability.extra, (G.jokers and G.jokers.cards and #G.jokers.cards or 0)*self.ability.extra}
        elseif self.ability.name == 'Delayed Gratification' then loc_vars = {self.ability.extra}
        elseif self.ability.name == 'Gros Michel' then loc_vars = {self.ability.extra.mult, ''..(G.GAME and G.GAME.probabilities.normal or 1), self.ability.extra.odds}
        elseif self.ability.name == 'Even Steven' then loc_vars = {self.ability.extra}
        elseif self.ability.name == 'Odd Todd' then loc_vars = {self.ability.extra}
        elseif self.ability.name == 'Scholar' then loc_vars = {self.ability.extra.mult, self.ability.extra.chips}
        elseif self.ability.name == 'Business Card' then loc_vars = {''..(G.GAME and G.GAME.probabilities.normal or 1), self.ability.extra}
        elseif self.ability.name == 'Spare Trousers' then loc_vars = {self.ability.extra, localize('Two Pair', 'poker_hands'), self.ability.mult}
        elseif self.ability.name == 'Superposition' then loc_vars = {self.ability.extra}
        elseif self.ability.name == 'Ride the Bus' then loc_vars = {self.ability.extra, self.ability.mult}
        elseif self.ability.name == 'Egg' then loc_vars = {self.ability.extra}
        elseif self.ability.name == 'Burglar' then loc_vars = {self.ability.extra}
        elseif self.ability.name == 'Blackboard' then loc_vars = {self.ability.extra, localize('Spades', 'suits_plural'), localize('Clubs', 'suits_plural')}
        elseif self.ability.name == 'Runner' then loc_vars = {self.ability.extra.chips, self.ability.extra.chip_mod}
        elseif self.ability.name == 'Ice Cream' then loc_vars = {self.ability.extra.chips, self.ability.extra.chip_mod}
        elseif self.ability.name == 'DNA' then loc_vars = {self.ability.extra}
        elseif self.ability.name == 'Constellation' then loc_vars = {self.ability.extra, self.ability.x_mult}
        elseif self.ability.name == 'Hiker' then loc_vars = {self.ability.extra}
        elseif self.ability.name == 'To Do List' then loc_vars = {self.ability.extra.dollars, localize(self.ability.to_do_poker_hand, 'poker_hands')}
        elseif self.ability.name == 'Astronomer' then loc_vars = {self.ability.extra}
        
        elseif self.ability.name == 'Golden Ticket' then loc_vars = {self.ability.extra}
        elseif self.ability.name == 'Mr. Bones' then
        elseif self.ability.name == 'Acrobat' then loc_vars = {self.ability.extra}
        elseif self.ability.name == 'Sock and Buskin' then loc_vars = {self.ability.extra+1}
        elseif self.ability.name == 'Swashbuckler' then loc_vars = {self.ability.mult}
        elseif self.ability.name == 'Troubadour' then loc_vars = {self.ability.extra.h_size, -self.ability.extra.h_plays}
        elseif self.ability.name == 'Certificate' then loc_vars = {self.ability.extra}
        elseif self.ability.name == 'Throwback' then loc_vars = {self.ability.extra, self.ability.x_mult}
        elseif self.ability.name == 'Hanging Chad' then loc_vars = {self.ability.extra}
        elseif self.ability.name == 'Rough Gem' then loc_vars = {self.ability.extra}
        elseif self.ability.name == 'Bloodstone' then loc_vars = {''..(G.GAME and G.GAME.probabilities.normal or 1), self.ability.extra.odds, self.ability.extra.Xmult}
        elseif self.ability.name == 'Arrowhead' then loc_vars = {self.ability.extra}
        elseif self.ability.name == 'Onyx Agate' then loc_vars = {self.ability.extra}
        elseif self.ability.name == 'Glass Joker' then loc_vars = {self.ability.extra, self.ability.x_mult}
        elseif self.ability.name == 'Flower Pot' then loc_vars = {self.ability.extra}
        elseif self.ability.name == 'Wee Joker' then loc_vars = {self.ability.extra.chips, self.ability.extra.chip_mod}
        elseif self.ability.name == 'Merry Andy' then loc_vars = {self.ability.d_size, self.ability.h_size}
        elseif self.ability.name == 'The Idol' then loc_vars = {self.ability.extra, localize(G.GAME.current_round.idol_card.rank, 'ranks'), localize(G.GAME.current_round.idol_card.suit, 'suits_plural'), colours = {G.C.SUITS[G.GAME.current_round.idol_card.suit]}}
        elseif self.ability.name == 'Seeing Double' then loc_vars = {self.ability.extra}
        elseif self.ability.name == 'Matador' then loc_vars = {self.ability.extra}
        elseif self.ability.name == 'Hit the Road' then loc_vars = {self.ability.extra, self.ability.x_mult}
        elseif self.ability.name == 'The Duo' or self.ability.name == 'The Trio'
            or self.ability.name == 'The Family' or self.ability.name == 'The Order' or self.ability.name == 'The Tribe' then loc_vars = {self.ability.x_mult, localize(self.ability.type, 'poker_hands')}
        
        elseif self.ability.name == 'Cavendish' then loc_vars = {self.ability.extra.Xmult, ''..(G.GAME and G.GAME.probabilities.normal or 1), self.ability.extra.odds}
        elseif self.ability.name == 'Card Sharp' then loc_vars = {self.ability.extra.Xmult}
        elseif self.ability.name == 'Red Card' then loc_vars = {self.ability.extra, self.ability.mult}
        elseif self.ability.name == 'Madness' then loc_vars = {self.ability.extra, self.ability.x_mult}
        elseif self.ability.name == 'Square Joker' then loc_vars = {self.ability.extra.chips, self.ability.extra.chip_mod}
        elseif self.ability.name == 'Seance' then loc_vars = {localize(self.ability.extra.poker_hand, 'poker_hands')}
        elseif self.ability.name == 'Riff-raff' then loc_vars = {self.ability.extra}
        elseif self.ability.name == 'Vampire' then loc_vars = {self.ability.extra, self.ability.x_mult}
        elseif self.ability.name == 'Hologram' then loc_vars = {self.ability.extra, self.ability.x_mult}
        elseif self.ability.name == 'Vagabond' then loc_vars = {self.ability.extra}
        elseif self.ability.name == 'Baron' then loc_vars = {self.ability.extra}
        elseif self.ability.name == 'Cloud 9' then loc_vars = {self.ability.extra, self.ability.extra*(self.ability.nine_tally or 0)}
        elseif self.ability.name == 'Rocket' then loc_vars = {self.ability.extra.dollars, self.ability.extra.increase}
        elseif self.ability.name == 'Obelisk' then loc_vars = {self.ability.extra, self.ability.x_mult}
        elseif self.ability.name == 'Photograph' then loc_vars = {self.ability.extra}
        elseif self.ability.name == 'Gift Card' then  loc_vars = {self.ability.extra}
        elseif self.ability.name == 'Turtle Bean' then loc_vars = {self.ability.extra.h_size, self.ability.extra.h_mod}
        elseif self.ability.name == 'Erosion' then loc_vars = {self.ability.extra, math.max(0,self.ability.extra*(G.playing_cards and (G.GAME.starting_deck_size - #G.playing_cards) or 0)), G.GAME.starting_deck_size}
        elseif self.ability.name == 'Reserved Parking' then loc_vars = {self.ability.extra.dollars, ''..(G.GAME and G.GAME.probabilities.normal or 1), self.ability.extra.odds}
        elseif self.ability.name == 'Mail-In Rebate' then loc_vars = {self.ability.extra, localize(G.GAME.current_round.mail_card.rank, 'ranks')}
        elseif self.ability.name == 'To the Moon' then loc_vars = {self.ability.extra}
        elseif self.ability.name == 'Hallucination' then loc_vars = {G.GAME.probabilities.normal, self.ability.extra}
        elseif self.ability.name == 'Lucky Cat' then loc_vars = {self.ability.extra, self.ability.x_mult}
        elseif self.ability.name == 'Baseball Card' then loc_vars = {self.ability.extra}
        elseif self.ability.name == 'Bull' then loc_vars = {self.ability.extra, self.ability.extra*math.max(0,G.GAME.dollars) or 0}
        elseif self.ability.name == 'Diet Cola' then loc_vars = {localize{type = 'name_text', set = 'Tag', key = 'tag_double', nodes = {}}}
        elseif self.ability.name == 'Trading Card' then loc_vars = {self.ability.extra}
        elseif self.ability.name == 'Flash Card' then loc_vars = {self.ability.extra, self.ability.mult}
        elseif self.ability.name == 'Popcorn' then loc_vars = {self.ability.mult, self.ability.extra}
        elseif self.ability.name == 'Ramen' then loc_vars = {self.ability.x_mult, self.ability.extra}
        elseif self.ability.name == 'Ancient Joker' then loc_vars = {self.ability.extra, localize(G.GAME.current_round.ancient_card.suit, 'suits_singular'), colours = {G.C.SUITS[G.GAME.current_round.ancient_card.suit]}}
        elseif self.ability.name == 'Walkie Talkie' then loc_vars = {self.ability.extra.chips, self.ability.extra.mult}
        elseif self.ability.name == 'Seltzer' then loc_vars = {self.ability.extra}
        elseif self.ability.name == 'Castle' then loc_vars = {self.ability.extra.chip_mod, localize(G.GAME.current_round.castle_card.suit, 'suits_singular'), self.ability.extra.chips, colours = {G.C.SUITS[G.GAME.current_round.castle_card.suit]}}
        elseif self.ability.name == 'Smiley Face' then loc_vars = {self.ability.extra}
        elseif self.ability.name == 'Campfire' then loc_vars = {self.ability.extra, self.ability.x_mult}
        elseif self.ability.name == 'Stuntman' then loc_vars = {self.ability.extra.chip_mod, self.ability.extra.h_size}
        elseif self.ability.name == 'Invisible Joker' then loc_vars = {self.ability.extra, self.ability.invis_rounds}
        elseif self.ability.name == 'Satellite' then
            local planets_used = 0
            for _, v in pairs(G.GAME.consumeable_usage) do if v.set == 'Planet' then planets_used = planets_used + 1 end end
            loc_vars = {self.ability.extra, planets_used*self.ability.extra}
        elseif self.ability.name == 'Shoot the Moon' then loc_vars = {self.ability.extra}
        elseif self.ability.name == "Driver's License" then loc_vars = {self.ability.extra, self.ability.driver_tally or '0'}
        elseif self.ability.name == 'Bootstraps' then loc_vars = {self.ability.extra.mult, self.ability.extra.dollars, self.ability.extra.mult*math.floor((G.GAME.dollars + (G.GAME.dollar_buffer or 0))/self.ability.extra.dollars)}
        elseif self.ability.name == 'Caino' then loc_vars = {self.ability.extra, self.ability.caino_xmult}
        elseif self.ability.name == 'Triboulet' then loc_vars = {self.ability.extra}
        elseif self.ability.name == 'Yorick' then loc_vars = {self.ability.extra.xmult, self.ability.extra.discards, self.ability.yorick_discards, self.ability.x_mult}
        elseif self.ability.name == 'Perkeo' then loc_vars = {self.ability.extra}
        end
    elseif self.ability.set == 'Spectral' then 
        if self.ability.name == 'Familiar' or self.ability.name == 'Grim' or self.ability.name == 'Incantation' then loc_vars = {self.ability.extra}
        elseif self.ability.name == 'Immolate' then loc_vars = {self.ability.extra.destroy, self.ability.extra.dollars}
        elseif self.ability.name == 'Cryptid' then loc_vars = {self.ability.extra}
        end
        if self.ability.name == 'Ectoplasm' then loc_vars = {G.GAME.ecto_minus or 1} end
    elseif self.ability.set == 'Planet' then
        loc_vars = {
            G.GAME.hands[self.ability.consumeable.hand_type].level,localize(self.ability.consumeable.hand_type, 'poker_hands'), G.GAME.hands[self.ability.consumeable.hand_type].l_mult, G.GAME.hands[self.ability.consumeable.hand_type].l_chips,
            colours = {(G.GAME.hands[self.ability.consumeable.hand_type].level==1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[self.ability.consumeable.hand_type].level)])}
        }
    elseif self.ability.set == 'Tarot' then
        if self.ability.name == "The Fool" then
            local fool_c = G.GAME.last_tarot_planet and G.P_CENTERS[G.GAME.last_tarot_planet] or nil
            local last_tarot_planet = fool_c and localize{type = 'name_text', key = fool_c.key, set = fool_c.set} or localize('k_none')
            loc_vars = {last_tarot_planet}
        elseif self.ability.name == "The Magician" then loc_vars = {self.ability.consumeable.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = self.ability.consumeable.mod_conv}}
        elseif self.ability.name == "The High Priestess" then loc_vars = {self.ability.consumeable.planets}
        elseif self.ability.name == "The Empress" then loc_vars = {self.ability.consumeable.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = self.ability.consumeable.mod_conv}}
        elseif self.ability.name == "The Emperor" then loc_vars = {self.ability.consumeable.tarots}
        elseif self.ability.name == "The Hierophant" then loc_vars = {self.ability.consumeable.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = self.ability.consumeable.mod_conv}}
        elseif self.ability.name == "The Lovers" then loc_vars = {self.ability.consumeable.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = self.ability.consumeable.mod_conv}}
        elseif self.ability.name == "The Chariot" then loc_vars = {self.ability.consumeable.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = self.ability.consumeable.mod_conv}}
        elseif self.ability.name == "Justice" then loc_vars = {self.ability.consumeable.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = self.ability.consumeable.mod_conv}}
        elseif self.ability.name == "The Hermit" then loc_vars = {self.ability.consumeable.extra}
        elseif self.ability.name == "The Wheel of Fortune" then loc_vars = {G.GAME.probabilities.normal, self.ability.consumeable.extra}
        elseif self.ability.name == "Strength" then loc_vars = {self.ability.consumeable.max_highlighted}
        elseif self.ability.name == "The Hanged Man" then loc_vars = {self.ability.consumeable.max_highlighted}
        elseif self.ability.name == "Death" then loc_vars = {self.ability.consumeable.max_highlighted}
        elseif self.ability.name == "Temperance" then
            local _money = 0
            if G.jokers then
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i].ability.set == 'Joker' then
                        _money = _money + G.jokers.cards[i].sell_cost
                    end
                end
            end
            loc_vars = {self.ability.consumeable.extra, math.min(self.ability.consumeable.extra, _money)}
        elseif self.ability.name == "The Devil" then loc_vars = {self.ability.consumeable.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = self.ability.consumeable.mod_conv}}
        elseif self.ability.name == "The Tower" then loc_vars = {self.ability.consumeable.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = self.ability.consumeable.mod_conv}}
        elseif self.ability.name == "The Star" then loc_vars = {self.ability.consumeable.max_highlighted,  localize(self.ability.consumeable.suit_conv, 'suits_plural'), colours = {G.C.SUITS[self.ability.consumeable.suit_conv]}}
        elseif self.ability.name == "The Moon" then loc_vars = {self.ability.consumeable.max_highlighted, localize(self.ability.consumeable.suit_conv, 'suits_plural'), colours = {G.C.SUITS[self.ability.consumeable.suit_conv]}}
        elseif self.ability.name == "The Sun" then loc_vars = {self.ability.consumeable.max_highlighted, localize(self.ability.consumeable.suit_conv, 'suits_plural'), colours = {G.C.SUITS[self.ability.consumeable.suit_conv]}}
        elseif self.ability.name == "The World" then loc_vars = {self.ability.consumeable.max_highlighted, localize(self.ability.consumeable.suit_conv, 'suits_plural'), colours = {G.C.SUITS[self.ability.consumeable.suit_conv]}}
        end
    end

    return loc_vars
end

function Card:get_popup_direction()
    -- Should be 'c' in theory, but the extension works better with just 'b' and 't'
    --return (self.children.buy_button or (self.area and self.area.config.view_deck) or (self.area and self.area.config.type == 'shop')) and 'c' or
    return (self.children.buy_button or (self.area and self.area.config.view_deck) or (self.area and self.area.config.type == 'shop')) and 'b' or
           (self.T.y < G.CARD_H*0.8) and 'b' or
           't'
end