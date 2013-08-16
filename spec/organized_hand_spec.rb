require 'spec_helper'

describe "Organized Hands" do
  it "should know its front" do
    sut = OrganizedHand.new(:hand => %w(Ah Ks Qs 10s 10d 7d 6c 8h Qc Qd Ad 2c 4d))
    expect(sut.front).to eq(%w(Ah Ks Qs))
  end
  it "should know its middle" do
    sut = OrganizedHand.new(:hand => %w(Ah Ks Qs 10s 10d 7d 6c 8h Qc Qd Ad 2c 4d))
    expect(sut.middle).to eq(%w(10s 10d 7d 6c 8h))
  end
  it "should know its back" do
    sut = OrganizedHand.new(:hand => %w(Ah Ks Qs 10s 10d 7d 6c 8h Qc Qd Ad 2c 4d))
    expect(sut.back).to eq(%w(Qc Qd Ad 2c 4d))
  end
end
