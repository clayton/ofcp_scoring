require 'spec_helper'

describe "Hand Organizer" do
  it "should return am empty string if no hand is present" do
    sut = ChinesePokerHandOrganizer.new
    expect(sut.organize(nil)).to eq("")
  end
  it "should build an organized hand" do
    hand = %w(Qc Qd Ad 2c 4d)
    hand_factory = double(HandFactory)
    hand_factory.should_receive(:build).with(
      :ranks_only => {"Q" => 2, "A" => 1, "2" => 1, "4" => 1},
      :suits_only => {"c" => 2, "d" => 3},
      :sorted_ranks => ["1", "12", "12", "2", "4"],
      :hand => hand
    )

    sut = ChinesePokerHandOrganizer.new(hand_factory)
    sut.organize(hand)
  end
end
