require 'spec_helper'

describe "Chinese Poker Hands" do
  it "should know when it is misset" do
    sut = ChinesePokerHand.new({
      :front => ThreeOfAKind.new({:ranks => [9,9,9]}),
      :middle => Pair.new({:ranks => [2,3,5,8,8]}),
      :back => HighCard.new({:ranks => [2,3,4,5,7]})
    })

    expect(sut.misset?).to be
  end

  it "should know when it is not misset" do
    sut = ChinesePokerHand.new({
      :back => ThreeOfAKind.new({:ranks => [9,9,9,5,7]}),
      :middle => Pair.new({:ranks => [2,3,5,8,8]}),
      :front => HighCard.new({:ranks => [2,3,4]})
    })

    expect(sut.misset?).to_not be
  end
end
