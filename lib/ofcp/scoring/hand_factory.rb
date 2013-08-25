module Ofcp
  module Scoring
    class HandFactory
      def initialize(categorizer = Ofcp::Scoring::HandCategorizer.new)
        @categorizer = categorizer
      end
      def build(hand)
        Ofcp::Scoring::ChinesePokerHand.new({
          :front  => @categorizer.categorize(hand[0..2]),
          :middle => @categorizer.categorize(hand[3..7]),
          :back   => @categorizer.categorize(hand[8..12])
        })
      end
    end
  end
end
