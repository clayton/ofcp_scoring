module Ofcp
  module Scoring
    class HighCard < RankedHand
      def <=>(other)
        return super if super
        self.ranks.max <=> other.ranks.max
      end
    end
  end
end
