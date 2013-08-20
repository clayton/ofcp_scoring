require 'spec_helper'

describe "Ranked Hands" do
  it "should know the order of poker hands" do
    expect(RankedHand::RANKINGS).to eq(
      [
        "RoyalFlush", "StraightFlush", "FourOfAKind", "FullHouse", "Straight",
        "ThreeOfAKind", "TwoPair", "Pair", "HighCard"
      ]
    )
  end

  it "should know it's high card" do
    sut = RankedHand.new()
  end
end
