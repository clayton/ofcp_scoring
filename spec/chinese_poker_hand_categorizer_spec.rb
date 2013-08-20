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
      hand = FakeOrganizedHand.new(true)
      @organizer.stub(:organize).and_return(hand)
      Pair.should_receive(:new).with(hand)
      @sut.categorize(%w(Ah Ac Jh 5d 9c))
    end
    it "should return two Pair when two sets of two cards match" do
      hand = FakeOrganizedHand.new(true, true)
      @organizer.stub(:organize).and_return(hand)
      TwoPair.should_receive(:new).with(hand)
      @sut.categorize(%w(Ah Ac Kh Kc 9d))
    end
    it "should return Three Of a Kind when three cards match" do
      hand = FakeOrganizedHand.new(false, false, true)
      @organizer.stub(:organize).and_return(hand)
      ThreeOfAKind.should_receive(:new).with(hand)
      @sut.categorize(%w(Ah Jc Jh Jd 9c))
    end
    it "should return Four of a kind when four cards match" do
      hand = FakeOrganizedHand.new(false, false, false, true)
      @organizer.stub(:organize).and_return(hand)
      FourOfAKind.should_receive(:new).with(hand)
      @sut.categorize(%w(Js Jc Jh Jd 9c))
    end
    it "should return Full House when three cards match and two cards match" do
      hand = FakeOrganizedHand.new(true, false, true)
      @organizer.stub(:organize).and_return(hand)
      FullHouse.should_receive(:new).with(hand)
      @sut.categorize(%w(Js Jc Jh 9d 9c))
    end
    it "should return High Card when no cards match" do
      hand = FakeOrganizedHand.new(false, false, false, false)
      @organizer.stub(:organize).and_return(hand)
      HighCard.should_receive(:new).with(hand)
      @sut.categorize(%w(Js Ac 7h 8d 9c))
    end
    it "should return Flush when suits all same" do
      hand = FakeOrganizedHand.new(false, false, false, false, true)
      @organizer.stub(:organize).and_return(hand)
      Flush.should_receive(:new).with(hand)
      @sut.categorize(%w(2h 3h 5h Kh Jh))
    end
    it "should return Straight when all five cards are in sequential order" do
      hand = FakeOrganizedHand.new(false, false, false, false, false, true)
      @organizer.stub(:organize).and_return(hand)
      Straight.should_receive(:new).with(hand)
      @sut.categorize(%w(2c 3d 4d 5c 6h))
    end
    it "should return a Straight Flush when all five cards are in sequential order and all suits match" do
      hand = FakeOrganizedHand.new(false, false, false, false, true, true)
      @organizer.stub(:organize).and_return(hand)
      StraightFlush.should_receive(:new).with(hand)
      @sut.categorize(%w(2c 3d 4d 5c 6h))
    end
    it "should return a Royal Flush when all five cards are in sequential order, all suits match and highest rank is an Ace" do
      hand = FakeOrganizedHand.new(false, false, false, false, true, true, true)
      @organizer.stub(:organize).and_return(hand)
      RoyalFlush.should_receive(:new).with(hand)
      @sut.categorize(%w(Ac Kc Qc Jc 10c))
    end
  end
  context "Three Card Hands" do

  end

end
