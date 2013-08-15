require 'spec_helper'

describe "Chinese Poker Hand" do
  it "should rank its hands" do
    ranked_hand = double(RankedHand)
    ranked_hand.should_receive(:rank).with(%w(Ac 9s Qs))
    ranked_hand.should_receive(:rank).with(%w(Ks Kd 5c 10s 9s))
    ranked_hand.should_receive(:rank).with(%w(As Ad 3h 4h 2c))
    my_hand = ChinesePokerHand.new(%w(Ac 9s Qs Ks Kd 5c 10s 9s As Ad 3h 4h 2c), hand_scorer, ranked_hand)

    my_hand.rank
  end
  it "should be able to compare its score to another hand" do
    hand_scorer = double(HandScorer, :score => 0)

    my_hand = ChinesePokerHand.new(%w(Ac 9s Qs Ks Kd 5c 10s 9s As Ad 3h 4h 2c), hand_scorer)
    their_hand = ChinesePokerHand.new(%w(Kc 9s Qs Qc Qd 5c 10s 9s Ks Kd 3h 4h 2c), hand_scorer)

    hand_scorer.should_receive(:score).with(my_hand, their_hand)
    my_hand.score_against(their_hand)
  end
end
