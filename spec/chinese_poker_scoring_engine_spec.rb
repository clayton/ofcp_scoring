require 'spec_helper'

describe "Chinese Poker Scoring Engine" do
  before(:each) do
    @sut = ChinesePokerScoringEngine.new
    @hand_one = %w(Ah Ks Qs 10s 10d 7d 6c 8h Qc Qd Ad 2c 4d)
    @hand_two = %w(9h 9c Qs 10s 10d 7d 6c 8h Qc Qd Ad 2c 4d)
  end
  it "should return no score for nil hands" do
    expect(@sut.score(nil, nil)).to eq([0,0])
  end
  it "should return no score for one nil hand" do
    expect(@sut.score(nil, 0)).to eq([0,0])
  end
  it "should use a hand evaluator to compare and score the hands" do
    evaluator = double(ChinesePokerHandEvaluator, :evaluate => [2,1])
    evaluator.should_receive(:evaluate).with(@hand_one, @hand_two)

    sut = ChinesePokerScoringEngine.new(evaluator)
    sut.score(@hand_one, @hand_two)
  end
end

