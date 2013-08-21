require 'spec_helper'

describe "Open Face Chinese Poker" do
  before(:each) do
    # pending "Waiting..."
  end
  it "should determine how many points each poker hand owes the other" do
    my_hand = %w(2h 3h 5h 10d 10h 4h 7c 8s Jd Js 6c 7d 9c)
    their_hand = %w(Ah 3h 5h 6d 6h 4h 7c 8s Qd Qs 6c 7d 9c)
    sut = ChinesePokerScoringEngine.new
    expect(sut.score(my_hand, their_hand)).to eq([1, 2])
  end

  it "should give a scoop bonus when one hand scoops another" do
    my_hand = %w(Ah As Qs Js Jd 7d 6c 8h Kc Kd Ad 2c 4d)
    their_hand = %w(9h 9c Qs 10s 10d 7d 6c 8h Qc Qd Ad 2c 4d)
    sut = ChinesePokerScoringEngine.new
    expect(sut.score(my_hand, their_hand)).to eq([6, 0])
  end
end
