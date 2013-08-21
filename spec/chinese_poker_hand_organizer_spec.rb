require 'spec_helper'

describe "Hand Organizer" do
  it "should return am empty string if no hand is present" do
    sut = ChinesePokerHandOrganizer.new
    expect(sut.organize(nil)).to eq("")
  end
end

describe "Integration" do
  it "should organize hands" do
    hand = %w(Qc Qd Ad 2c 4d)
    sut = ChinesePokerHandOrganizer.new
    organized = sut.organize(hand)
    expect(organized.two_cards_match?).to be
    expect(organized.two_different_cards_match?).to_not be
    expect(organized.ranks).to eq([1,2,4,12,12])
  end
end
