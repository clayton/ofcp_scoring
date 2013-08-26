class OfcpScoring::HandEvaluator
  def initialize(hand_factory = OfcpScoring::HandFactory.new, royalties_calculator = OfcpScoring::RoyaltiesCalculator.new)
    @hand_factory = hand_factory
    @royalties_calculator = royalties_calculator
    @hand_one_score = 0
    @hand_two_score = 0
    @hand_one_royalties = 0
    @hand_two_royalties = 0

  end
  def evaluate(hand_one, hand_two)
    organized_hand_one = @hand_factory.build(hand_one)
    organized_hand_two = @hand_factory.build(hand_two)

    score_hands(organized_hand_one, organized_hand_two)
  end

private
  def score_hands(organized_hand_one, organized_hand_two)
    [:front, :middle, :back].each do |sub_hand|
      if organized_hand_one.send(sub_hand) > organized_hand_two.send(sub_hand)
        @hand_one_score += 1
        @hand_one_royalties += @royalties_calculator.calculate_bonus(organized_hand_one.send(sub_hand), sub_hand)
      end
      if organized_hand_two.send(sub_hand) > organized_hand_one.send(sub_hand)
        @hand_two_score += 1
        @hand_two_royalties += @royalties_calculator.calculate_bonus(organized_hand_two.send(sub_hand), sub_hand)
      end
    end

    adjust_for_missets(organized_hand_one, organized_hand_two)

    [(@hand_one_score + @hand_one_royalties), (@hand_two_score + @hand_two_royalties)]
  end

  def adjust_for_missets(organized_hand_one, organized_hand_two)
    if organized_hand_one.misset?
      @hand_one_score = 0
      @hand_two_score = 3
    end

    if organized_hand_two.misset?
      @hand_one_score = 3
      @hand_two_score = 0
    end

    @hand_one_score += 3 if @hand_two_score == 0
    @hand_two_score += 3 if @hand_one_score == 0
  end
end
