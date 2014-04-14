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
end




