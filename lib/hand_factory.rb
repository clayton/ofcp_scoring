class HandFactory
  def initialize(organizer = ChinesePokerHandOrganizer.new)
    @organizer = organizer
  end
  def build(hand)
    OrganizedHand.new(@organizer.organize(hand))
  end
end
