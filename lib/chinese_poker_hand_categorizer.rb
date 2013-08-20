class ChinesePokerHandCategorizer

  def initialize(organizer = ChinesePokerHandOrganizer.new)
    @organizer = organizer
  end

  def categorize(hand)
    return "" if hand.nil?

    organized_hand = @organizer.organize(hand)

    categorization = HighCard
    categorization = Pair if organized_hand.two_cards_match?
    categorization = TwoPair if organized_hand.two_different_cards_match?
    categorization = ThreeOfAKind if organized_hand.three_cards_match?
    categorization = Straight if organized_hand.ranks_in_order?
    categorization = Flush if organized_hand.all_suits_match?
    categorization = FullHouse if organized_hand.three_cards_match? && organized_hand.two_cards_match?
    categorization = FourOfAKind if organized_hand.four_cards_match?
    categorization = StraightFlush if organized_hand.all_suits_match? && organized_hand.ranks_in_order?
    categorization = RoyalFlush if organized_hand.all_suits_match? && organized_hand.ranks_in_order? && organized_hand.high_card_ace?

    return categorization.new(organized_hand)

  end

end
