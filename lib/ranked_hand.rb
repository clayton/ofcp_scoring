class RankedHand
  RANKINGS = [
    "RoyalFlush", "StraightFlush", "FourOfAKind", "FullHouse", "Straight",
    "ThreeOfAKind", "TwoPair", "Pair", "HighCard"
  ]

  def initialize(hand=nil)
    @hand = hand
  end
end
