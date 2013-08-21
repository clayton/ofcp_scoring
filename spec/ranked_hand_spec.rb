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

  it "should know it's highest card" do
    sut = HighCard.new({:ranks => [13,12,11,10,5]})
    expect(sut.highest_card).to eq(13)
  end

  it "should know use an Ace as the highest card if present" do
    sut = HighCard.new({:ranks => [1,4,5,6,7]})
    expect(sut.highest_card).to eq(14)
  end

  it "should rank Royal Flushes above Straight Flushes" do
    royal_flush = RoyalFlush.new
    straight_flush = StraightFlush.new

    expect(royal_flush > straight_flush).to be
  end

  it "should rank Straight Flushes above Four of a Kind" do
    straight_flush = StraightFlush.new
    four_of_a_kind = FourOfAKind.new

    expect(straight_flush > four_of_a_kind).to be
  end

  it "should rank a Full House over a Pair" do
    full_house = FullHouse.new
    pair = Pair.new

    expect(full_house > pair).to be
  end

  it "should evaluate the highest card when comparing the same rank" do
    aces = Pair.new({:ranks => [1]})
    nines = Pair.new({:ranks => [9]})

    expect(aces > nines).to be
  end
end
