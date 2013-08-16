require 'spec_helper'

describe "Open Face Chinese Poker" do
  before(:each) do
    pending "Waiting..."
  end
  it "should determine how many points each poker hand owes the other" do
    my_hand = %w(Ah Ks Qs 10s 10d 7d 6c 8h Qc Qd Ad 2c 4d)
    their_hand = %w(9h 9c Qs 10s 10d 7d 6c 8h Qc Qd Ad 2c 4d)
    sut = ChinesePokerScoringEngine.new
    expect(sut.score(my_hand, their_hand)).to eq([1, 2])
  end
end
