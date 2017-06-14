require 'spec_helper'
require_relative '../poker_hand'

describe PokerHand do
  let(:royal_flush_cards) { %w(TH JH QH KH AH) }
  let(:straight_flush_cards) { %w(9H TH JH QH KH) }
  let(:four_of_a_kind_cards) { %w(9H 9D 9S 9C KH) }
  let(:full_house_cards) { %w(9H 9D 9S KC KH) }
  let(:flush_cards) { %w(4H 2H KH 5H TH) }
  let(:straight_cards) { %w(9H TD JS QD KH) }
  let(:three_of_a_kind_cards) { %w(9H 9D 9S QD KH) }
  let(:two_pair_cards) { %w(9H 9D TS TD KH) }
  let(:one_pair_cards) { %w(9H 9D JS QD KH) }
  let(:high_card_only_cards) { %w(9H 2D TS QD KH) }

  let(:jumbled_order) { %w(QH KH JH TH 9H) }
  let(:expected_sorted_order) { %w(9H TH JH QH KH) }

  let(:other_four_of_a_kind_cards) { %w(TH TD TS TC 2H) }
  let(:player_1_hand) { PokerHand.new(four_of_a_kind_cards) }
  let(:player_2_hand) { PokerHand.new(other_four_of_a_kind_cards) }

  it 'should store the same cards regardless of order' do
    expect(PokerHand.new(jumbled_order).cards).to match_array(jumbled_order)
  end

  it 'should store the cards in sorted order lowest to highest value' do
    expect(PokerHand.new(jumbled_order).cards).to eq expected_sorted_order

  end

  it 'should recognize a royal flush' do
    expect(PokerHand.new(royal_flush_cards).rank).to eq :royal_flush
  end

  it 'should recognize a straight flush' do
    expect(PokerHand.new(straight_flush_cards).rank).to eq :straight_flush
  end

  it 'should recognize four of a kind' do
    expect(PokerHand.new(four_of_a_kind_cards).rank).to eq :four_of_a_kind
  end

  it 'should recognize a full house' do
    expect(PokerHand.new(full_house_cards).rank).to eq :full_house
  end

  it 'should recognize a flush' do
    expect(PokerHand.new(flush_cards).rank).to eq :flush
  end

  it 'should recognize a straight' do
    expect(PokerHand.new(straight_cards).rank).to eq :straight
  end

  it 'should recognize three of a kind' do
    expect(PokerHand.new(three_of_a_kind_cards).rank).to eq :three_of_a_kind
  end

  it 'should recognize two pair' do
    expect(PokerHand.new(two_pair_cards).rank).to eq :two_pair
  end

  it 'should recognize one pair' do
    expect(PokerHand.new(one_pair_cards).rank).to eq :one_pair
  end

  it 'should recognize when it is only a high card' do
    expect(PokerHand.new(high_card_only_cards).rank).to eq :high_card
  end

  it 'should properly evaluate the better hand when compared using hands of different rank' do
    expect(PokerHand.new(four_of_a_kind_cards)).to be < PokerHand.new(royal_flush_cards)
  end

  it 'should properly evaluate the better hand when compared using hands equal rank' do
    expect(PokerHand.new(four_of_a_kind_cards)).to be < PokerHand.new(other_four_of_a_kind_cards)
  end
end
