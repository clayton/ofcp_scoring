class ChinesePokerHandCategorizer

  def initialize(organizer = ChinesePokerHandOrganizer.new)
    @organizer = organizer
  end

  def categorize(hand)
    return "" if hand.nil?

    categorization = HighCard
    categorization = Pair if hand.two_cards_match?
    categorization = TwoPair if hand.two_different_cards_match?
    categorization = ThreeOfAKind if hand.three_cards_match?

    unless hand.three_card_hand?
      categorization = Straight if hand.ranks_in_order?
      categorization = Flush if hand.all_suits_match?
      categorization = FullHouse if hand.three_cards_match? && hand.two_cards_match?
      categorization = FourOfAKind if hand.four_cards_match?
      categorization = StraightFlush if hand.all_suits_match? && hand.ranks_in_order?
      categorization = RoyalFlush if hand.all_suits_match? && hand.ranks_in_order? && hand.high_card_ace?
    end

    return categorization.new(hand)

  end

end
