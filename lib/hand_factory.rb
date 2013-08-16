class HandFactory
  def initialize(hand = OrganizedHand)
    @hand = hand
  end
  def build(organized_hand_values={})
    @hand.new(organized_hand_values)
  end
end
