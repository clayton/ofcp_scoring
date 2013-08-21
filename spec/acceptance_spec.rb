require 'spec_helper'

describe "Open Face Chinese Poker" do
  it "should determine how many points each poker hand owes the other" do
    my_hand = %w(2h 3h 5h 10d 10h 4h 7c 8s Jd Js 6c 7d 9c)
    their_hand = %w(Ah 3h 5h 6d 6h 4h 7c 8s Qd Qs 6c 7d 9c)
    sut = ChinesePokerScoringEngine.new
    expect(sut.score(my_hand, their_hand)).to eq([1, 2])
  end

  it "should give a scoop bonus when one hand scoops another" do
    my_hand = %w(Ah 4s Qs Js Jd 7d 6c 8h Kc Kd Ad 2c 4d)
    their_hand = %w(9h 4c Qs 10s 10d 7d 6c 8h Qc Qd Ad 2c 4d)
    sut = ChinesePokerScoringEngine.new
    expect(sut.score(my_hand, their_hand)).to eq([6, 0])
  end

  it "should give royalties for extra special hands" do
    my_hand    = %w(Ah 4s Qs 2h 3h 4h 5h 7h Kh Kd Ks 9c 9s)
    their_hand = %w(9h 4c Qs 10s 10d 7d 6c 8h Qc Qd Ad 2c 4d)
    sut = ChinesePokerScoringEngine.new
    expect(sut.score(my_hand, their_hand)).to eq([20, 0])
  end
end
