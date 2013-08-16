class ChinesePokerHandEvaluator
  def initialize(categorizer = ChinesePokerHandCategorizer.new)
    @categorizer = categorizer
  end
  def evaluate(hand_one, hand_two)
    hand_one_score = 0
    hand_two_score = 0
    categorized_hand_one = @categorizer.categorize(hand_one)
    categorized_hand_two = @categorizer.categorize(hand_two)

    [:front, :middle, :back].each do |sub_hand|
      hand_one_score += 1 if categorized_hand_one.send(sub_hand) > categorized_hand_two.send(sub_hand)
      hand_two_score += 1 if categorized_hand_two.send(sub_hand) > categorized_hand_one.send(sub_hand)
    end

    [hand_one_score, hand_two_score]
  end
end
