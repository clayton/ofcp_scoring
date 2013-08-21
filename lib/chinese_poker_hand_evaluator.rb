class ChinesePokerHandEvaluator
  def initialize(hand_factory = HandFactory.new, royalties_calculator = RoyaltiesCalculator.new)
    @hand_factory = hand_factory
    @royalties_calculator = royalties_calculator
  end
  def evaluate(hand_one, hand_two)
    hand_one_score = 0
    hand_two_score = 0
    organized_hand_one = @hand_factory.build(hand_one)
    organized_hand_two = @hand_factory.build(hand_two)

    [:front, :middle, :back].each do |sub_hand|
      puts "#{sub_hand}"
      puts "\t hand one: #{organized_hand_one.send(sub_hand).class.to_s}"
      puts "\t hand two: #{organized_hand_two.send(sub_hand).class.to_s}"
      if organized_hand_one.send(sub_hand) > organized_hand_two.send(sub_hand)
        hand_one_score += 1
        hand_one_score += @royalties_calculator.calculate_bonus(organized_hand_one.send(sub_hand), sub_hand)
      end
      # if organized_hand_two.send(sub_hand) > organized_hand_one.send(sub_hand)
      #   puts "\t hand two: #{organized_hand_two.send(sub_hand).class.to_s}"
      #   hand_two_score += 1
      #   hand_two_score += @royalties_calculator.calculate_bonus(organized_hand_two.send(sub_hand), sub_hand)
      # end
    end

    hand_one_score += 3 if hand_one_score == 3
    hand_two_score += 3 if hand_two_score == 3

    [hand_one_score, hand_two_score]
  end
end
