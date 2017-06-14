#!/usr/bin/env ruby
require_relative 'poker_game'

filename = ARGV.first || 'poker.txt'

poker_game = PokerGame.new(filename)
poker_game.play_all

puts poker_game.player_one_announcement
