class OfcpScoring::RankedHand
  include Comparable

  RANKINGS = [
    "HighCard", "Pair", "TwoPair", "ThreeOfAKind", "Straight", "Flush",
    "FullHouse", "FourOfAKind", "StraightFlush", "RoyalFlush"
  ]

  def rank_name
    self.class.to_s.split("::").last
  end

  def <=>(other_hand)
    RANKINGS.index(rank_name) <=> RANKINGS.index(other_hand.rank_name) unless rank_name == other_hand.rank_name
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
