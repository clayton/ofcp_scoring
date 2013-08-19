require 'spec_helper'

describe "Building Hands" do
  it "should use an organizer to organize the hand" do
    organizer = double(ChinesePokerHandOrganizer, :organize => {})
    organizer.should_receive(:organize).with(%w())
    sut = HandFactory.new(organizer)
    sut.build(%w())
  end
end


class FakeOrganizer
  def organize(hand)
    hand
  end
end
