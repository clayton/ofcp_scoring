class RankedHand
  include Comparable

  RANKINGS = [
    "HighCard", "Pair", "TwoPair", "ThreeOfAKind", "Straight", "Flush",
    "FullHouse", "FourOfAKind", "StraightFlush", "RoyalFlush"
  ]

  def <=>(other_hand)
    if self.class == other_hand.class
      (ranks - (ranks & other_hand.ranks)) <=> (other_hand.ranks - (ranks & other_hand.ranks))
    else
      RANKINGS.index(self.class.to_s) <=> RANKINGS.index(other_hand.class.to_s)
    end
  end

  def initialize(hand=nil)
    @hand = hand
  end

  def ranks
    ranks = @hand.ranks
    if @hand.high_card_ace?
      ranks.delete(1)
      ranks << 14
    end
    ranks.sort
  end


end
