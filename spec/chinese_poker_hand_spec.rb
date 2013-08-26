require 'spec_helper'

describe "Chinese Poker Hands" do
  it "should know when it is misset" do
    sut = OfcpScoring::ChinesePokerHand.new({
      :front => OfcpScoring::ThreeOfAKind.new({:ranks => [9,9,9]}),
      :middle => OfcpScoring::Pair.new({:ranks => [2,3,5,8,8]}),
      :back => OfcpScoring::HighCard.new({:ranks => [2,3,4,5,7]})
    })

    expect(sut.misset?).to be
  end

  it "should know when it is not misset" do
    sut = OfcpScoring::ChinesePokerHand.new({
      :back => OfcpScoring::ThreeOfAKind.new({:ranks => [9,9,9,5,7]}),
      :middle => OfcpScoring::Pair.new({:ranks => [2,3,5,8,8]}),
      :front => OfcpScoring::HighCard.new({:ranks => [2,3,4]})
    })

    expect(sut.misset?).to_not be
  end
end
