require 'spec_helper'

ScorableHand = Struct.new(:front,:middle, :back)


describe "Evaluator" do
  before(:each) do
    @hand_one = %w(Ah Ks Qs 10s 10d 7d 6c 8h Qc Qd Ad 2c 4d)
    @hand_two = %w(9h 9c Qs 10s 10d 7d 6c 8h Qc Qd Ad 2c 4d)
    @sut = ChinesePokerHandEvaluator.new(FakeFactory.new, FakeRoyaltyCalculator.new)
  end
  it "should evaluate the front hands" do
    expect(@sut.evaluate(ScorableHand.new(1,0,0), ScorableHand.new(0,0,0))).to eq([1,0])
  end
  it "should evaluate the middle hands" do
    expect(@sut.evaluate(ScorableHand.new(1,0,0), ScorableHand.new(0,1,0))).to eq([1,1])
  end
  it "should evaluate the back hands" do
    expect(@sut.evaluate(ScorableHand.new(1,1,0), ScorableHand.new(0,0,1))).to eq([2,1])
  end
  it "should add a scoop bonus" do
    expect(@sut.evaluate(ScorableHand.new(1,1,1), ScorableHand.new(0,0,0))).to eq([6,0])
  end
end

describe "Royalties Calculation" do
  it "should add royalties for a hand when it wins" do
    royalty_calc = double(RoyaltiesCalculator, :calculate_bonus => 0)
    sut = ChinesePokerHandEvaluator.new(FakeFactory.new, royalty_calc)
    royalty_calc.should_receive(:calculate_bonus).once.with(1, :front)
    royalty_calc.should_receive(:calculate_bonus).once.with(1, :middle)
    royalty_calc.should_receive(:calculate_bonus).once.with(1, :back)
    sut.evaluate(ScorableHand.new(1,0,1), ScorableHand.new(0,1,0))
  end

  it "should add the royalties for the first hand to its score" do
    royalty_calc = RoyaltiesCalculator.new
    royalty_calc.stub(:calculate_bonus).and_return(10)
    sut = ChinesePokerHandEvaluator.new(FakeFactory.new, royalty_calc)
    expect(sut.evaluate(ScorableHand.new(1,0,1), ScorableHand.new(0,1,0))).to eq([22,11])
  end

end

describe "Integration" do
  it "should score front, middle and back hands" do
    @hand_one = %w(Ah Ks Qs 8s 8d 7d 6c 4h Jc Jd Ad 2c 4d)
    @hand_two = %w(9h 6c Qs 10s 10d 7d 6c 8h Qc Qd Ad 2c 4d)

    sut = ChinesePokerHandEvaluator.new
    expect(sut.evaluate(@hand_one, @hand_two)).to eq([1,2])
  end
end

class FakeFactory
  def build(hand)
      hand
  end
end

class FakeRoyaltyCalculator
  def calculate_bonus(hand, position)
      0
  end
end
