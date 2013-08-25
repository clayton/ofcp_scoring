module Ofcp
  module Scoring
  class ThreeOfAKind < RankedHand
    def <=>(other)
      return super if super
      highest_trip_card <=> other.highest_trip_card
    end

    def highest_trip_card
      grouped_ranks.map{|card,matches| card if matches.size == 3}.compact.max
    end
  end
end
end
