module Ofcp
  module Scoring
    class ScoringEngine
      def initialize(evaluator = Ofcp::Scoring::HandEvaluator.new)
        @evaluator = evaluator
      end
      def score(hand_one, hand_two)
        return [0,0] if hand_one.nil? || hand_two.nil?
        @evaluator.evaluate(hand_one, hand_two)
      end
    end
  end
end
