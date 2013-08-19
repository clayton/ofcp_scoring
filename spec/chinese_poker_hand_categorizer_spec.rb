require 'spec_helper'
require 'ostruct'

describe "Hand Categorization" do
  FakeHandOrganizer = Struct.new(:to_s) do
    def organize(hand)
      return ""
    end
  end

  FakeOrganizedHand = Struct.new(
    :two_cards_match?,
    :two_different_cards_match?,
    :three_cards_match?,
    :four_cards_match?,
    :all_suits_match?,
    :ranks_in_order?,
    :high_card_ace?
  )

  before(:each) do
    @organizer = FakeHandOrganizer.new
    @sut = ChinesePokerHandCategorizer.new(@organizer)
  end

  it "should categorize organized poker hands" do

    organizer = double(ChinesePokerHandOrganizer, :organize => FakeOrganizedHand.new)
    organizer.should_receive(:organize).with(%w(Ac))

    sut = ChinesePokerHandCategorizer.new(organizer)
    sut.categorize(%w(Ac))
  end

  context "Five Card Hands" do
    it "should return an empty string if no hand is present" do
      expect(@sut.categorize(nil)).to eq("")
    end
    it "should return a Pair when two cards match" do
      @organizer.stub(:organize).and_return(FakeOrganizedHand.new(true))
      expect(@sut.categorize(%w(Ah Ac Jh 5d 9c))).to be_a(Pair)
    end
    it "should return two Pair when two sets of two cards match" do
      @organizer.stub(:organize).and_return(FakeOrganizedHand.new(true, true))
      expect(@sut.categorize(%w(Ah Ac Kh Kc 9d))).to be_a(TwoPair)
    end
    it "should return Three Of a Kind when three cards match" do
      @organizer.stub(:organize).and_return(FakeOrganizedHand.new(false, false, true))
      expect(@sut.categorize(%w(Ah Jc Jh Jd 9c))).to be_a(ThreeOfAKind)
    end
    it "should return Four of a kind when four cards match" do
      @organizer.stub(:organize).and_return(FakeOrganizedHand.new(false, false, false, true))
      expect(@sut.categorize(%w(Js Jc Jh Jd 9c))).to be_a(FourOfAKind)
    end
    it "should return Full House when three cards match and two cards match" do
      @organizer.stub(:organize).and_return(FakeOrganizedHand.new(true, false, true))
      expect(@sut.categorize(%w(Js Jc Jh 9d 9c))).to be_a(FullHouse)
    end
    it "should return High Card when no cards match" do
      @organizer.stub(:organize).and_return(FakeOrganizedHand.new(false, false, false, false))
      expect(@sut.categorize(%w(Js Ac 7h 8d 9c))).to be_a(HighCard)
    end
    it "should return Flush when suits all same" do
      @organizer.stub(:organize).and_return(FakeOrganizedHand.new(false, false, false, false, true))
      expect(@sut.categorize(%w(2h 3h 5h Kh Jh))).to be_a(Flush)
    end
    it "should return Straight when all five cards are in sequential order" do
      @organizer.stub(:organize).and_return(FakeOrganizedHand.new(false, false, false, false, false, true))
      expect(@sut.categorize(%w(2c 3d 4d 5c 6h))).to be_a(Straight)
    end
    it "should return a Straight Flush when all five cards are in sequential order and all suits match" do
      @organizer.stub(:organize).and_return(FakeOrganizedHand.new(false, false, false, false, true, true))
      expect(@sut.categorize(%w(2c 3d 4d 5c 6h))).to be_a(StraightFlush)
    end
    it "should return a Royal Flush when all five cards are in sequential order, all suits match and highest rank is an Ace" do
      @organizer.stub(:organize).and_return(FakeOrganizedHand.new(false, false, false, false, true, true, true))
      expect(@sut.categorize(%w(Ac Kc Qc Jc 10c))).to be_a(RoyalFlush)
    end
  end
  context "Three Card Hands" do

  end

end
