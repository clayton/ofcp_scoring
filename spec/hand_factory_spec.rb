require 'spec_helper'

describe "Building Hands" do
  it "should build Chinese Poker Hands" do
    sut = Ofcp::Scoring::HandFactory.new(FakeCategorizer.new)
    Ofcp::Scoring::ChinesePokerHand.should_receive(:new)
    sut.build(%w())
  end
  it "should use an categorizer to categorize the hand" do
    categorizer = double(Ofcp::Scoring::HandCategorizer, :categorize => {})
    categorizer.should_receive(:categorize).with(%w())
    sut = Ofcp::Scoring::HandFactory.new(categorizer)
    sut.build(%w())
  end
end


class FakeCategorizer
  def categorize(hand)
    hand
  end
end
