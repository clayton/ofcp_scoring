require 'spec_helper'

describe "Ranked Hands" do
  HandWithRankings = Struct.new(:ranks, :high_card_ace?)

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
    aces = Pair.new(HandWithRankings.new([1], :high_card_ace))
    nines = Pair.new(HandWithRankings.new([9], false))

    expect(aces > nines).to be
  end

  it "should compare the ranks of two hands when they are different" do
    sut = RankedHand.new(HandWithRankings.new([13,12,11,10,7], false))
    other = RankedHand.new(HandWithRankings.new([13,12,11,10,8], false))
    expect(sut < other).to be
  end
end
