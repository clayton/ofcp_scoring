class ChinesePokerHand
  def initialize(hand=[], hand_scorer=HandScorer.new)
    @hand_scorer = hand_scorer
  end

  def score_against(other_hand)
    @hand_scorer.score(self, other_hand)
  end
end
