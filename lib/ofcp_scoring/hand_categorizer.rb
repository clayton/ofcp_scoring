class OfcpScoring::HandCategorizer

  def initialize(organizer = OfcpScoring::HandOrganizer.new)
    @organizer = organizer
  end

  def categorize(hand)
    return "" if hand.nil?

    organized_hand = @organizer.organize(hand)

    categorization = OfcpScoring::HighCard
    categorization = OfcpScoring::Pair if organized_hand.two_cards_match?
    categorization = OfcpScoring::TwoPair if organized_hand.two_different_cards_match?
    categorization = OfcpScoring::ThreeOfAKind if organized_hand.three_cards_match?

    unless organized_hand.three_card_hand?
      categorization = OfcpScoring::Straight if organized_hand.ranks_in_order?
      categorization = OfcpScoring::Flush if organized_hand.all_suits_match?
      categorization = OfcpScoring::FullHouse if organized_hand.three_cards_match? && organized_hand.two_cards_match?
      categorization = OfcpScoring::FourOfAKind if organized_hand.four_cards_match?
      categorization = OfcpScoring::StraightFlush if organized_hand.all_suits_match? && organized_hand.ranks_in_order?
      categorization = OfcpScoring::RoyalFlush if organized_hand.all_suits_match? && organized_hand.ranks_in_order? && organized_hand.high_card_ace?
    end

    return categorization.new(organized_hand)

  end

end
