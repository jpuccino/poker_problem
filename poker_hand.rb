require 'active_support/core_ext/module/delegation'

class PokerHand
  include Comparable
  attr_reader :cards, :rank

  def initialize(cards)
    # High card is always last
    @cards = cards.sort_by {|card| card_value_map[card[0]] }
    rank_hand
  end

  def <=>(other_hand)
    if self.rank == other_hand.rank
      # Can compare by highest card
      if [:high_card, :straight, :flush, :straight_flush, :royal_flush].include?(self.rank)
        card_value_map[self.high_card[0]] <=> card_value_map[other_hand.high_card[0]]
      else # Compare by highest match
        # sort by highest count, then highest value
        counts1 = match_counts.sort_by {|value, count| [count, card_value_map[value]] }
        counts2 = other_hand.match_counts.sort_by {|value, count| [count, card_value_map[value]] }
        # check descending to compare best cards first
        counts1.zip(counts2).reverse_each do |(val1, _cnt1), (val2, _cnt2)|
          comp = card_value_map[val1] <=> card_value_map[val2]
          return comp if comp.nonzero?
        end
        0 # according to the problem this shouldn't happen, but here for consistency
      end
    else
      hand_value_map[self.rank] <=> hand_value_map[other_hand.rank]
    end
  end



  def self.hand_value_map
    @hand_value_map ||= [:high_card,
                         :one_pair,
                         :two_pair,
                         :three_of_a_kind,
                         :straight,
                         :flush,
                         :full_house,
                         :four_of_a_kind,
                         :straight_flush,
                         :royal_flush].map.with_index(1) {|name, value| [name, value] }.to_h.freeze
  end

  def self.card_value_map
    @card_value_map ||= %w(2 3 4 5 6 7 8 9 T J Q K A).map.with_index(1) {|name, value| [name, value] }.to_h.freeze
  end

  protected

  def high_card
    cards.last
  end

  def match_counts
    @counts ||= cards.reduce(Hash.new(0)) {|counts, card| counts[card[0]] += 1; counts }
  end

  private *delegate(:card_value_map, :hand_value_map, to: :class)
  private

  def flush?
    suit = cards.first[1]
    @flush ||= cards.all? {|c| c[1] == suit }
  end

  def straight?
    cards.each_cons(2).all? {|a, b| card_value_map[b[0]] == card_value_map[a[0]] + 1 }
  end

  def four_of_a_kind?
    match_counts.values.include?(4)
  end

  def full_house?
    match_counts.values.sort == [2, 3]
  end

  def three_of_a_kind?
    match_counts.values.sort == [1, 1, 3]
  end

  def two_pair?
    match_counts.values.sort == [1, 2, 2]
  end

  def one_pair?
    match_counts.values.sort == [1, 1, 1, 2]
  end

  def rank_hand
    # By checking in order of best rank first, we avoid the risk of accidentally
    # ranking a hand too low when the hand meets multiple sets of conditions.
    @rank = if flush? && straight? && high_card[0] == card_value_map.keys.last
              :royal_flush
            elsif flush? && straight?
              :straight_flush
            elsif four_of_a_kind?
              :four_of_a_kind
            elsif full_house?
              :full_house
            elsif flush?
              :flush
            elsif straight?
              :straight
            elsif three_of_a_kind?
              :three_of_a_kind
            elsif two_pair?
              :two_pair
            elsif one_pair?
              :one_pair
            else
              :high_card
            end
  end
end
