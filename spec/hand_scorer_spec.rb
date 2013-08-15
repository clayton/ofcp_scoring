require 'spec_helper'

describe "Scoring Hands" do
  it "should return 0 when the hands tie" do
    hand_1 = ChinesePokerHand.new
    hand_1.stub(:top_rank).and_return("HighCard")
    hand_1.stub(:middle_rank).and_return("HighCard")
    hand_1.stub(:bottom_rank).and_return("HighCard")
    hand_2 = hand_1

    sut = HandScorer.new
    expect(sut.score(hand_1, hand_2)).to eq(0)
  end

  it "should return 6 when the first hand scoops the second" do

    better_hand = RankedHand.new
    worse_hand = RankedHand.new

    better_hand.stub(:>).and_return(true)
    better_hand.stub(:<).and_return(false)
    worse_hand.stub(:<).and_return(false)
    worse_hand.stub(:>).and_return(true)

    hand_1 = ChinesePokerHand.new
    hand_1.stub(:top_rank).and_return(better_hand)
    hand_1.stub(:middle_rank).and_return(better_hand)
    hand_1.stub(:bottom_rank).and_return(better_hand)

    hand_2 = ChinesePokerHand.new
    hand_2.stub(:top_rank).and_return(worse_hand)
    hand_2.stub(:middle_rank).and_return(worse_hand)
    hand_2.stub(:bottom_rank).and_return(worse_hand)


    sut = HandScorer.new
    expect(sut.score(hand_1, hand_2)).to eq(6)
  end
end

class RankedHand
end
