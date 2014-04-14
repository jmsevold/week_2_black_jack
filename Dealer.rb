class Dealer < Player
  def dealer_hit_or_stay(game_deck,user)
    stay = false
    until stay == true
      puts "Will #{self.player_name} hit or stay?"
      answer = gets.chomp
      if answer == "hit"
        game_deck.deal_to_dealer(dealer)
      elsif answer == 'stay'
        stay = true
      end
    end
    compare_hands(user,self)
  end
end