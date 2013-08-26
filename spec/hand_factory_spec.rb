require 'spec_helper'

describe "Building Hands" do
  it "should build Chinese Poker Hands" do
    sut = OfcpScoring::HandFactory.new(FakeCategorizer.new)
    OfcpScoring::ChinesePokerHand.should_receive(:new)
    sut.build(%w())
  end
  it "should use an categorizer to categorize the hand" do
    categorizer = double(OfcpScoring::HandCategorizer, :categorize => {})
    categorizer.should_receive(:categorize).with(%w())
    sut = OfcpScoring::HandFactory.new(categorizer)
    sut.build(%w())
  end
end


class FakeCategorizer
  def categorize(hand)
    hand
  end
end
