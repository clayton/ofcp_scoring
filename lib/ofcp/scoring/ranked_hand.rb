module Ofcp
  module Scoring
    class RankedHand
      include Comparable

      RANKINGS = [
        "HighCard", "Pair", "TwoPair", "ThreeOfAKind", "Straight", "Flush",
        "FullHouse", "FourOfAKind", "StraightFlush", "RoyalFlush"
      ]

      def <=>(other_hand)
        klass = self.class.to_s.split("::").last
        other_klass = other_hand.class.to_s.split("::").last
        puts "klass: #{klass} other_klass: #{other_klass}"
        RANKINGS.index(klass) <=> RANKINGS.index(other_klass) unless klass == other_klass
      end

      def initialize(hand=nil)
        @hand = hand
      end

      def ranks
        ranks = @hand.ranks
        ranks.map{|r| r == 1 ? 14 : r}.sort
      end

      def grouped_ranks
        ranks.group_by{|card| card }
      end

      def compare_ranks(other)
        (ranks - (ranks & other.ranks)).max <=> (other.ranks - (ranks & other.ranks)).max
      end


    end
  end
end
