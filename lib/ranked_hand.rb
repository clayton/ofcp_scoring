class RankedHand
  include Comparable

  RANKINGS = [
    "RoyalFlush", "StraightFlush", "FourOfAKind", "FullHouse", "Straight",
    "ThreeOfAKind", "TwoPair", "Pair", "HighCard"
  ]

  def <=>(other_hand)
    if self.class == other_hand.class
       self.highest_card <=> other_hand.highest_card
    else
      RANKINGS.index(other_hand.class.to_s) <=> RANKINGS.index(self.class.to_s)
    end
  end

  def initialize(hand=nil)
    @hand = hand
  end

  def highest_card
    return 14 if @hand[:ranks].include?(1)
    @hand[:ranks].max
  end
end
