class OrganizedHand
  def initialize(args)
    @hand = args[:hand]
  end

  def front
    @hand[0..2]
  end

  def middle
    @hand[3..7]
  end

  def back
    @hand[8..12]
  end
end
