require 'spec_helper'

describe "Hand Organizer" do
  it "should return am empty string if no hand is present" do
    sut = ChinesePokerHandOrganizer.new
    expect(sut.organize(nil)).to eq("")
  end
end
