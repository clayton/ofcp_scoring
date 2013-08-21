require 'spec_helper'

describe "Organized Hands" do
  before(:each) do
    pending
    @hand = %w(Ah Ks Qs 10s 10d 7d 6c 8h Qc Qd Ad 2c 4d)
    @categorizer = FakeCategorizer.new
    @sut = OrganizedHand.new(@hand, @categorizer)
  end
  it "should categorize it's front" do
    @categorizer.should_receive(:categorize).with()
    @sut.front
  end
  it "should know its middle" do
    @categorizer.should_receive(:categorize).with()
    @sut.middle
  end
  it "should know its back" do
    @categorizer.should_receive(:categorize).with()
    @sut.back
  end
end

class FakeCategorizer
  def categorize(sub_hand)
    sub_hand
  end
end
