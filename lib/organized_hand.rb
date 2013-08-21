class OrganizedHand

  def initialize(hand, categorizer = ChinesePokerHandCategorizer.new)
    @front       = hand[:front]
    @middle      = hand[:middle]
    @back        = hand[:back]
    @categorizer = categorizer
  end

  def front
    @categorizer.categorize(@front)
  end

  def middle
    @categorizer.categorize(@middle)
  end

  def back
    @categorizer.categorize(@back)
  end
end
