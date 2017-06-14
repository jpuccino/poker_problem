require 'spec_helper'
require_relative '../poker_game'

describe PokerGame do
  let(:poker_game) { PokerGame.new('spec/test_poker_hands.txt') }

  before(:each) { poker_game.play_all }

  it 'should report the correct number of wins' do
    expect(poker_game.player_one_wins).to eq 3
  end

  it 'should announce the correct number of wins out of the correct number of games' do
    expect(poker_game.player_one_announcement).to eq 'Player 1 won 3 of 5 games'
  end
end
