class OfcpScoring::HandFactory
  def initialize(categorizer = OfcpScoring::HandCategorizer.new)
    @categorizer = categorizer
  end
  def build(hand)
    OfcpScoring::ChinesePokerHand.new({
      :front  => @categorizer.categorize(hand[0..2]),
      :middle => @categorizer.categorize(hand[3..7]),
      :back   => @categorizer.categorize(hand[8..12])
    })
  end
end
