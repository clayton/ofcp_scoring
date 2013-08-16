require 'spec_helper'

describe "Building Hands" do
  it "should build organized poker hands" do
    args = {:ranks_only => {}, :suits_only => {}, :hand => [], :sorted_ranks => []}
    hand = double(OrganizedHand)
    hand.should_receive(:new).with(args)
    sut = HandFactory.new(hand)
    sut.build(args)
  end
end
