require 'spec_helper'

FakeHand = Struct.new(:class, :ranks)

describe "Royalties Calculations" do
  before(:each) do
    @sut = Ofcp::Scoring::RoyaltiesCalculator.new
  end
  describe "For Front Hands" do
    it "should give an extra point for a pair of sixes" do
      expect(@sut.calculate_bonus(FakeHand.new("Pair", [6]), :front)).to eq(1)
    end
    it "should give two extra points for a pair of sevens" do
      expect(@sut.calculate_bonus(FakeHand.new("Pair", [7]), :front)).to eq(2)
    end
    it "should give three extra points for a pair of eights" do
      expect(@sut.calculate_bonus(FakeHand.new("Pair", [8]), :front)).to eq(3)
    end
    it "should give 9 extra points for a pair of Aces" do
      expect(@sut.calculate_bonus(FakeHand.new("Pair", [14]), :front)).to eq(9)
    end
    it "should give no extra points for high card hands" do
      expect(@sut.calculate_bonus(FakeHand.new("HighCard", [14]), :front)).to eq(0)
    end
  end

  describe "For Middle Hands" do
    it "should not give any bonus for a pair" do
      expect(@sut.calculate_bonus(FakeHand.new("Pair", [14]), :middle)).to eq(0)
    end
    it "should give 20 extra points for a straight flush in the middle" do
      expect(@sut.calculate_bonus(FakeHand.new("StraightFlush"), :middle)).to eq(20)
    end
    it "should give 16 extra points for Quads in the middle" do
      expect(@sut.calculate_bonus(FakeHand.new("FourOfAKind"), :middle)).to eq(16)
    end
    it "should give 12 extra points for a full house in the middle" do
      expect(@sut.calculate_bonus(FakeHand.new("FullHouse"), :middle)).to eq(12)
    end
    it "should give 8 extra points for a flush in the middle" do
      expect(@sut.calculate_bonus(FakeHand.new("Flush"), :middle)).to eq(8)
    end
    it "should give 12 extra points for a straight in the middle" do
      expect(@sut.calculate_bonus(FakeHand.new("Straight"), :middle)).to eq(4)
    end
  end
  describe "For Back Hands" do
    it "should not give any bonus for a pair" do
      expect(@sut.calculate_bonus(FakeHand.new("Pair", [14]), :back)).to eq(0)
    end
    it "should give 20 extra points for a royal flush in the back" do
      expect(@sut.calculate_bonus(FakeHand.new("RoyalFlush"), :back)).to eq(20)
    end
    it "should give 10 extra points for a straight flush in the back" do
      expect(@sut.calculate_bonus(FakeHand.new("StraightFlush"), :back)).to eq(10)
    end
    it "should give 8 extra points for Quads in the back" do
      expect(@sut.calculate_bonus(FakeHand.new("FourOfAKind"), :back)).to eq(8)
    end
    it "should give 6 extra points for a full house in the back" do
      expect(@sut.calculate_bonus(FakeHand.new("FullHouse"), :back)).to eq(6)
    end
    it "should give 4 extra points for a flush in the back" do
      expect(@sut.calculate_bonus(FakeHand.new("Flush"), :back)).to eq(4)
    end
    it "should give 2 extra points for a straight in the back" do
      expect(@sut.calculate_bonus(FakeHand.new("Straight"), :back)).to eq(2)
    end
  end
end

# With Royalties you receive the following points for Back hands:

# 20 for a Royal
# 10 for StraightFlush
# 8 for Quads
# 6 for a Full House
# 4 for a Ofcp::Scoring::Flush
# 2 for a Straight
# (Some players might play 10 for Quads, 15 for a StraightFlush, and 25 for a Royal, so it is wise to agree the Royalites system beforehand just in case)

# You receive the following points for Middle hands:

# 20 for StraightFlush
# 16 for Quads
# 2 for a Full House
# 8 for a Ofcp::Scoring::Flush
# 4 for a Straight
# You receive the following points for Front hands (the 3 card hand):

# Pair of Aces: 9 points
# Pair of Kings: 8 points
# Pair of Queens: 7 points
# Pair of Jacks: 6 points
# Pair of Tens: 5 points
# Pair of Nines: 4 points
# Pair of Eights: 3 points
# Pair of Sevens: 2 points
# Paid of Sixes: 1 point
