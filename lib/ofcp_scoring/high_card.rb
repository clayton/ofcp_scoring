class OfcpScoring::HighCard < OfcpScoring::RankedHand
  def <=>(other)
    return super if super
    self.ranks.max <=> other.ranks.max
  end
end
