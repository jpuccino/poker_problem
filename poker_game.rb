require_relative 'poker_hand'

class PokerGame
  attr_reader :player_one_wins

  def initialize(hands_filename)
    @hands_filename = hands_filename
  end

  def player_one_announcement
    "Player 1 won #{@player_one_wins} of #{@number_of_games} games"
  end

  def play_all
    @player_one_wins = 0
    @number_of_games = 0
    File.foreach(@hands_filename) do |line|
      cards = line.split
      player1 = PokerHand.new(cards.take(5))
      player2 = PokerHand.new(cards.drop(5))
      @player_one_wins += 1 if player1 > player2
      @number_of_games += 1
    end
  end
end
