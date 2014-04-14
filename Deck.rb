class Deck
  attr_accessor :deck
  def initialize
    @deck = []
    faces = %w{ 2 3 4 5 6 7 8 9 10 Jack King Queen Ace }
    suits = %w{ Hearts Spades Diamonds Clubs}
    faces.each do |face|
      suits.each do |suit|
        card = Card.new(face,suit)
        card_value_determiner(card)
        deck << card
      end
    end
    deck.shuffle!
  end

  def card_value_determiner(card)
    string_nums = (2..10).to_a.map { |i| i.to_s}
    if string_nums.include?(card.face)
      card.value = card.face.to_i
    elsif card.face == 'Ace'
      card.value == 11
    else
      card.value = 10
    end
  end

  def first_deal(player)
    c1 = self.deck.pop
    c2 = self.deck.pop
    self.ace_checker(c1,player)
    self.ace_checker(c2,player)
    player.hand.push(c1,c2)
    puts"#{player.player_name} received #{c1.identify}"
    puts"#{player.player_name} received #{c2.identify}"
    puts "Current hand: #{player.display_hand}"
    player.win_or_bust
    player.hit_or_stay
  end

  def deal_card(player)
    card = self.deck.pop
    ace_checker(card,player)
    player.hand.push(card)
    puts"#{player.player_name} received #{card.identify}"
    puts "Current hand: #{player.display_hand}"
    player.win_or_bust
    player.hit_or_stay
  end
  
  def deal_to_dealer(dealer,game_deck)
    card = self.deck.pop
    ace_checker(card,dealer)
    dealer.hand.push(card)
    puts"#{dealer.player_name} received a #{card.identify}"
    puts "Current hand: #{dealer.display_hand}"
    dealer.win_or_bust
    dealer.dealer_hit_or_stay(game_deck,user)
  end


  
  def first_dealer_deal(dealer,user)
    until dealer.total >= 17
      card = self.deck.pop
      self.ace_checker(card,dealer)
      dealer.hand.push(card)
      puts"#{dealer.player_name} received #{card.identify}"
      puts "Current hand: #{dealer.display_hand}"
      dealer.win_or_bust
    end
    dealer.dealer_hit_or_stay(self,user)
  end

  def ace_checker(card,player)
    if card.face == "Ace" && player.total + 11 > 21
      card.value = 1
    elsif card.face == "Ace" && player.total + 11 < 21
      card.value = 11
    end
  end
end







