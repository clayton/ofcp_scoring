module Ofcp
  module Scoring
    class ChinesePokerHand
      def initialize(hand)
        @hand = hand
      end

      def front
        @hand[:front]
      end

      def middle
        @hand[:middle]
      end

      def back
        @hand[:back]
      end

      def misset?
        true if front > middle || middle > back || front > back
      end

    end
  end
end
