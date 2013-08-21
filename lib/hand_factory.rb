class HandFactory
  def initialize(organizer = ChinesePokerHandOrganizer.new)
    @organizer = organizer
  end
  def build(hand)
    OrganizedHand.new({
      :front  => @organizer.organize(hand[0..2]),
      :middle => @organizer.organize(hand[3..7]),
      :back   => @organizer.organize(hand[8..12])
    })
  end
end
