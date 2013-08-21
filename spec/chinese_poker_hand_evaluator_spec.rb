require 'spec_helper'

describe "Evaluator" do
  before(:each) do
    @hand_one = %w(Ah Ks Qs 10s 10d 7d 6c 8h Qc Qd Ad 2c 4d)
    @hand_two = %w(9h 9c Qs 10s 10d 7d 6c 8h Qc Qd Ad 2c 4d)
    @hand = Struct.new(:front,:middle, :back)
    @sut = ChinesePokerHandEvaluator.new(FakeFactory.new)
  end
  it "should evaluate the front hands" do
    expect(@sut.evaluate(@hand.new(1,0,0), @hand.new(0,0,0))).to eq([1,0])
  end
  it "should evaluate the middle hands" do
    expect(@sut.evaluate(@hand.new(1,1,0), @hand.new(0,0,0))).to eq([2,0])
  end
  it "should evaluate the back hands" do
    expect(@sut.evaluate(@hand.new(1,1,1), @hand.new(0,0,0))).to eq([3,0])
  end
  it "should evaluate the score of the losing hand" do
    expect(@sut.evaluate(@hand.new(0,0,0), @hand.new(1,1,1))).to eq([0,3])
  end
end

describe "Integration" do
  it "should score front, middle and back hands" do
    @hand_one = %w(Ah Ks Qs 8s 8d 7d 6c 8h Jc Jd Ad 2c 4d)
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
