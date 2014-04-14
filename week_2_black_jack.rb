require 'pry'

class Card
  attr_accessor :face, :suit, :value
  
  def initialize(face,suit)
    @face = face
    @suit = suit
    @value = 0
  end
  
  def identify
    if self.face == "Ace" || self.face == '8'
      letter = "an"
    else
      letter = "a"
    end
    return "#{letter} #{@face} of #{@suit}"
  end
end




class Player
  attr_accessor :hand, :player_name, :total
  
  def initialize
    @hand = []
    @total = 0
    @player_name = ""
  end
  
  def calculate_total
    @total = 0
    @hand.each do |card|
      @total += card.value
    end
    @total
  end
  
  def display_hand
    hand_string = []
    @hand.each do |card|
      hand_string << card.identify
    end
    hand_string.join(", ")
  end

  def player_wins
    puts "#{self.player_name} got 21 and won the game!"
    Process.exit
  end

  def player_busts
    puts "#{self.player_name} busted and loses!"
    Process.exit
  end

  def win_or_bust
    total = self.calculate_total
    if total == 21
      self.player_wins
    elsif total > 21
      self.player_busts
    end
  end

  def hit_or_stay(game_deck)
    stay = false

    until stay == true
      puts "Will #{self.player_name} hit or stay?"
      answer = gets.chomp
      if answer == "hit"
        game_deck.deal_card(self)
      elsif answer == 'stay'
        stay = true
      end
    end
  end
end


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
  end
end



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
    player.hit_or_stay(self)
  end

  def deal_card(player)
    card = self.deck.pop
    ace_checker(card,player)
    player.hand.push(card)
    puts"#{player.player_name} received #{card.identify}"
    puts "Current hand: #{player.display_hand}"
    player.win_or_bust
    player.hit_or_stay(self)
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
    elsif card.face == "Ace" && player.total + 11 <= 21
      card.value = 11
    end
  end
end


class BlackJack
  def initialize
    game_deck = Deck.new
    user = Player.new
    dealer = Dealer.new
    dealer.player_name = "Dealer"
    puts "Welcome to Blackjack! What is your name?"
    name = gets.chomp
    user.player_name = name
    puts "Let's get started!"
    start_game(game_deck,user,dealer)
  end

  def start_game(game_deck,user,dealer)
    game_deck.first_deal(user)
    puts "\n\n=== Now it's the dealer's turn... ===\n\n"
    game_deck.first_dealer_deal(dealer, user)
    compare_hands(user,dealer)
    puts "Thank you for playing!"
  end 

  def compare_hands(player1,player2)
    if player1.calculate_total > player2.calculate_total
      puts "#{player1.player_name} has #{player1.calculate_total} and wins the game."
      Process.exit
    elsif player1.calculate_total < player2.calculate_total
      puts "#{player2.player_name} has #{player2.calculate_total} and wins the game."
      Process.exit
    else
      puts "Tie game! Dealer wins!"
      Process.exit
    end
  end
end


game = BlackJack.new















