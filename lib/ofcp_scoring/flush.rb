require_relative 'ranked_hand'
class OfcpScoring::Flush < OfcpScoring::RankedHand
  def <=>(other)
    return super if super
    highest_flush_card <=> other.highest_flush_card
  end

  def highest_flush_card
    ranks.max
  end
end
