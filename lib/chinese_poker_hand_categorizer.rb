class ChinesePokerHandCategorizer

  def initialize(organizer = ChinesePokerHandOrganizer.new)
    @organizer = organizer
  end

  def categorize(hand)
    organized_hand = @organizer.organize(hand)

    return Straight.new if ((organized_hand.sorted_ranks.first..organized_hand.sorted_ranks.last).to_a & organized_hand.sorted_ranks) == organized_hand.sorted_ranks.sort
    return Flush.new if max_value_of(organized_hand.suits_only, 5)
    return HighCard.new if max_value_of(organized_hand.ranks_only, 1)
    return FourOfAKind.new if max_value_of(organized_hand.ranks_only,4)
    return FullHouse.new if max_value_of(organized_hand.ranks_only,3) && organized_hand.ranks_only.values.one?{|matches| matches == 2}
    return ThreeOfAKind.new if max_value_of(organized_hand.ranks_only, 3)
    return TwoPair.new if organized_hand.ranks_only.keys.size == 3
    Pair.new
  end

  def max_value_of(hash, max)
    hash.values.max == max
end

end
