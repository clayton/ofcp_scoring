require 'spec_helper'

describe "Organized Hands" do
  it "should be able to find sequences in its ranks" do
    sut = OfcpScoring::OrganizedHand.new({:ranks => [4,5,7,8,9]})
    expect(sut.sequences).to eq([[9,8,7],[5,4]])
  end
end
