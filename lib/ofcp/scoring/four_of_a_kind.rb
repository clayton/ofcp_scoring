module Ofcp
  module Scoring
    class FourOfAKind < RankedHand
      def <=>(other)
        return super if super
        highest_quad_card <=> other.highest_quad_card
      end

      def highest_quad_card
        grouped_ranks.map{|card,matches| card if matches.size == 4}.compact.max
      end
    end
  end
end
