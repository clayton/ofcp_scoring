class OfcpScoring::OrganizedHand
  def initialize(organized_hand)
    @hand = organized_hand
  end

  def ranks
    @hand[:ranks]
  end

  def two_cards_match?
    @hand[:two_cards_match]
  end

  def two_different_cards_match?
    @hand[:two_different_cards_match]
  end

  def three_cards_match?
    @hand[:three_cards_match]
  end

  def four_cards_match?
    @hand[:four_cards_match]
  end

  def all_suits_match?
    @hand[:all_suits_match]
  end

  def ranks_in_order?
    @hand[:ranks_in_order]
  end

  def three_card_hand?
    @hand[:three_card_hand]
  end
end
