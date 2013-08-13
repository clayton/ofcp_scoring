require 'spec_helper'

describe "Open Face Chinese Poker Hand" do
  describe "Setting Initial Hand" do
    it "should return empty array given no cards" do
      set_hand(nil).should == []
    end
    it "should set a royal flush on the bottom" do
      expect(set_hand(["Ah", "Kh", "Qh", "Jh", "10h"])).to eq(
        [
          "","","",
          "","","","","",
          "Ah", "Kh", "Qh", "Jh", "10h"
        ]
      )
    end

    it "should set an ace in the middle and two pair on the bottom" do
      pending
      # expect(set_hand(["Kh", "Ks", "Qh", "Qs","Ac"])).to eq(
      #   [
      #     "","","",
      #     "Ac","","","","",
      #     "Kh", "Ks", "Qh", "Qs", ""
      #   ]
      # )
    end

  end
end

def set_hand(cards)
  return [] if cards.nil?
  return ["","","","","","","",""] + cards
end
