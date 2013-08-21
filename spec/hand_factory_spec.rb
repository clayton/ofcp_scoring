require 'spec_helper'

describe "Building Hands" do
  it "should build Chinese Poker Hands" do
    sut = HandFactory.new(FakeCategorizer.new)
    ChinesePokerHand.should_receive(:new)
    sut.build(%w())
  end
  it "should use an categorizer to categorize the hand" do
    categorizer = double(ChinesePokerHandCategorizer, :categorize => {})
    categorizer.should_receive(:categorize).with(%w())
    sut = HandFactory.new(categorizer)
    sut.build(%w())
  end
end


class FakeCategorizer
  def categorize(hand)
    hand
  end
end
