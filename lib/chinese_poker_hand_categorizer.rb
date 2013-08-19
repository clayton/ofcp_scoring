class ChinesePokerHandCategorizer

  def initialize(organizer = ChinesePokerHandOrganizer.new)
    @organizer = organizer
  end

  def categorize(hand)
    return "" if hand.nil?

    organized_hand = @organizer.organize(hand)

    return RoyalFlush.new if organized_hand.all_suits_match? && organized_hand.ranks_in_order? && organized_hand.high_card_ace?
    return StraightFlush.new if organized_hand.all_suits_match? && organized_hand.ranks_in_order?
    return Straight.new if organized_hand.ranks_in_order?
    return Flush.new if organized_hand.all_suits_match?
    return FullHouse.new if organized_hand.three_cards_match? && organized_hand.two_cards_match?
    return FourOfAKind.new if organized_hand.four_cards_match?
    return ThreeOfAKind.new if organized_hand.three_cards_match?
    return TwoPair.new if organized_hand.two_different_cards_match?
    return Pair.new if organized_hand.two_cards_match?
    return HighCard.new

  end

end
