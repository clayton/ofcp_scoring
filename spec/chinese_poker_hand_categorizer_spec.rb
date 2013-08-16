require 'spec_helper'

describe "Hand Categorization" do
  before(:each) do
    @sut = ChinesePokerHandCategorizer.new
  end

  it "should categorize organized poker hands" do
    organizer = double(ChinesePokerHandOrganizer, :organize => :organized_hand)
    organizer.should_receive(:organize).with(%w(Ac))

    sut = ChinesePokerHandCategorizer.new(organizer)
    sut.categorize(%w(Ac))
  end

  context "Five Card Hands" do
    it "should return an empty string if no hand is present" do
      expect(@sut.categorize(nil)).to eq("")
    end
    it "should return a Pair when two cards match" do
      expect(@sut.categorize(OrganizedHand.new(:ranks_only => [2,2]))).to be_a(Pair)
    end
    it "should return two Pair when two sets of two cards match" do
      expect(@sut.categorize(%w(Ah Ac Jh Jd 9c))).to be_a(TwoPair)
    end
    it "should return Three Of a Kind when three cards match" do
      expect(@sut.categorize(%w(Ah Jc Jh Jd 9c))).to be_a(ThreeOfAKind)
    end
    it "should return Four of a kind when four cards match" do
      expect(@sut.categorize(%w(Js Jc Jh Jd 9c))).to be_a(FourOfAKind)
    end
    it "should return Full House when three cards match and two cards match" do
      expect(@sut.categorize(%w(Js Jc Jh 9d 9c))).to be_a(FullHouse)
    end
    it "should return High Card when no cards match" do
      expect(@sut.categorize(%w(Js Ac 7h 8d 9c))).to be_a(HighCard)
    end
    it "should return Flush when suits all same" do
      expect(@sut.categorize(%w(2h 3h 5h Kh Jh))).to be_a(Flush)
    end
    it "should return Straight when all five cards are in sequential order" do
      expect(@sut.categorize(%w(2c 3d 4d 5c 6h))).to be_a(Straight)
    end
    it "should return Straight when five cards starting with an ace are present" do
      expect(@sut.categorize(%w(Ac 2c 3d 4d 5c))).to be_a(Straight)
    end
    it "should return Straight when five cards starting with an 10 are present" do
      expect(@sut.categorize(%w(10c Jh Qs Kd Ac))).to be_a(Straight)
    end
  end
  context "Three Card Hands" do

  end

end
