class ChinesePokerHandEvaluator
  def initialize(hand_factory = HandFactory.new)
    @hand_factory = hand_factory
  end
  def evaluate(hand_one, hand_two)
    hand_one_score = 0
    hand_two_score = 0
    organized_hand_one = @hand_factory.build(hand_one)
    organized_hand_two = @hand_factory.build(hand_two)

    [:front, :middle, :back].each do |sub_hand|
      hand_one_score += 1 if organized_hand_one.send(sub_hand) > organized_hand_two.send(sub_hand)
      hand_two_score += 1 if organized_hand_two.send(sub_hand) > organized_hand_one.send(sub_hand)
    end

    hand_one_score += 3 if hand_one_score == 3
    hand_two_score += 3 if hand_two_score == 3

    [hand_one_score, hand_two_score]
  end
end
