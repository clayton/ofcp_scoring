module Ofcp
  module Scoring
    class HandCategorizer

      def initialize(organizer = Ofcp::Scoring::HandOrganizer.new)
        @organizer = organizer
      end

      def categorize(hand)
        return "" if hand.nil?

        organized_hand = @organizer.organize(hand)

        categorization = Ofcp::Scoring::HighCard
        categorization = Ofcp::Scoring::Pair if organized_hand.two_cards_match?
        categorization = Ofcp::Scoring::TwoPair if organized_hand.two_different_cards_match?
        categorization = Ofcp::Scoring::ThreeOfAKind if organized_hand.three_cards_match?

        unless organized_hand.three_card_hand?
          categorization = Ofcp::Scoring::Straight if organized_hand.ranks_in_order?
          categorization = Ofcp::Scoring::Flush if organized_hand.all_suits_match?
          categorization = Ofcp::Scoring::FullHouse if organized_hand.three_cards_match? && organized_hand.two_cards_match?
          categorization = Ofcp::Scoring::FourOfAKind if organized_hand.four_cards_match?
          categorization = StraightFlush if organized_hand.all_suits_match? && organized_hand.ranks_in_order?
          categorization = RoyalFlush if organized_hand.all_suits_match? && organized_hand.ranks_in_order? && organized_hand.high_card_ace?
        end

        return categorization.new(organized_hand)

      end

    end
  end
end
