module Ofcp
  module Scoring
    class TwoPair < RankedHand
      def <=>(other)
        return super if super
        if higher_paired_card == other.higher_paired_card
          if lower_paired_card == other.lower_paired_card
            compare_ranks(other)
          else
            lower_paired_card <=> other.lower_paired_card
          end
        else
          higher_paired_card <=> other.higher_paired_card
        end
      end

      def higher_paired_card
        grouped_ranks.map{|card,matches| card if matches.size == 2}.compact.max
      end

      def lower_paired_card
        grouped_ranks.map{|card,matches| card if matches.size == 2}.compact.min
      end
    end
  end
end
