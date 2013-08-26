class OfcpScoring::Straight < OfcpScoring::RankedHand

  def <=>(other)
    return super if super
    highest_straight_card <=> other.highest_straight_card
  end

  def highest_straight_card
    return ranks.max unless ranks.include?(14)
    return 1 if ranks.include?(14) && ranks.include?(5)
    return 14
  end

end
