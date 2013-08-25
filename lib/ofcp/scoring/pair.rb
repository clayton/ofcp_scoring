module Ofcp
  module Scoring
    class Pair < RankedHand

      def <=>(other)
        return super if super
        if highest_paired_card == other.highest_paired_card
          compare_ranks(other)
        else
          highest_paired_card <=> other.highest_paired_card
        end
      end

      def highest_paired_card
        grouped_ranks.map{|card,matches| card if matches.size == 2}.compact.first
      end

    end
  end
end
