class OrganizedHand
  def initialize(hand, categorizer = ChinesePokerHandCategorizer.new)
    @hand = hand
    @categorizer = categorizer
  end

  def front
    @categorizer.categorize(@hand[0..2])
  end

  def middle
    @categorizer.categorize(@hand[3..7])
  end

  def back
    @categorizer.categorize(@hand[8..12])
  end
end
