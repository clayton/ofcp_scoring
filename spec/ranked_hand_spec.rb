require 'spec_helper'

class HandWithRankings
  def initialize(ranks)
    @ranks = ranks
  end
  def ranks
    @ranks
  end
  def grouped_ranks
    @ranks.group_by{|c| c}
  end
end

describe "Ranked Hands" do

  it "should rank RoyalFlushes above Straight Flushes" do
    royal_flush = OfcpScoring::RoyalFlush.new
    straight_flush = OfcpScoring::StraightFlush.new

    expect(royal_flush > straight_flush).to be
  end

  it "should rank Straight Flushes above Four of a Kind" do
    straight_flush = OfcpScoring::StraightFlush.new
    four_of_a_kind = OfcpScoring::FourOfAKind.new

    expect(straight_flush > four_of_a_kind).to be
  end

  it "should rank a Full House over a Pair" do
    full_house = OfcpScoring::FullHouse.new
    pair = OfcpScoring::Pair.new

    expect(full_house > pair).to be
  end

  it "should rank a Flush over a Pair" do
    flush = OfcpScoring::Flush.new
    pair = OfcpScoring::Pair.new

    expect(pair < flush).to be
  end

  it "should rank TwoPair over a Pair" do
    two_pair = OfcpScoring::TwoPair.new
    pair = OfcpScoring::Pair.new

    expect(pair < two_pair).to be
  end

  context "Breaking Ties" do
    context "When comparing High Card Hands" do
      it "the higest card should be greater" do
        ace_high  = OfcpScoring::HighCard.new(HandWithRankings.new([6,7,8,9,14]))
        king_high = OfcpScoring::HighCard.new(HandWithRankings.new([6,7,8,9,13]))
        expect(ace_high > king_high).to be
        expect(king_high < ace_high).to be
      end
    end
    context "When comparing Pairs" do
      it "should compare the value of the paired card" do
        eights  = OfcpScoring::Pair.new(HandWithRankings.new([6,7,8,8,13]))
        sixes = OfcpScoring::Pair.new(HandWithRankings.new([6,6,8,9,14]))
        expect(eights > sixes).to be
        expect(sixes < eights).to be
      end
      it "should break ties of pairs by comparing the rest of the cards" do
        with_six  = OfcpScoring::Pair.new(HandWithRankings.new([6,8,8,13,14]))
        with_five = OfcpScoring::Pair.new(HandWithRankings.new([5,8,8,13,14]))
        expect(with_six > with_five).to be
        expect(with_five < with_six).to be
      end
    end
    context "When comparing TwoPair Hands" do
      it "should compare the value of the highest paired card of the highest pair" do
        eights_and_sixes = OfcpScoring::TwoPair.new(HandWithRankings.new([6,6,8,8,14]))
        fives_and_fours  = OfcpScoring::TwoPair.new(HandWithRankings.new([4,4,5,5,14]))
        expect(eights_and_sixes > fives_and_fours).to be
        expect(fives_and_fours < eights_and_sixes).to be
      end
      it "should first break ties of pairs by comparing the lower pair" do
        eights_and_sixes = OfcpScoring::TwoPair.new(HandWithRankings.new([6,6,8,8,14]))
        eights_and_fours  = OfcpScoring::TwoPair.new(HandWithRankings.new([4,4,8,8,14]))
        expect(eights_and_sixes > eights_and_fours).to be
        expect(eights_and_fours < eights_and_sixes).to be
      end
      it "should lastly break ties of pairs by comparing the other cards" do
        with_ace  = OfcpScoring::TwoPair.new(HandWithRankings.new([6,6,8,8,14]))
        with_jack = OfcpScoring::TwoPair.new(HandWithRankings.new([6,6,8,8,11]))
        expect(with_ace > with_jack).to be
        expect(with_jack < with_ace).to be
      end
    end
    context "When comparing Three of a Kind Hands" do
      it "should compare the value of the three cards" do
        eights  = OfcpScoring::ThreeOfAKind.new(HandWithRankings.new([6,8,8,8,13]))
        sixes = OfcpScoring::ThreeOfAKind.new(HandWithRankings.new([6,6,6,9,14]))
        expect(eights > sixes).to be
        expect(sixes < eights).to be
      end
    end
    context "When comparing Full Houses" do
      it "should use the value of the trip cards" do
        eights  = OfcpScoring::ThreeOfAKind.new(HandWithRankings.new([5,8,8,8,5]))
        sixes = OfcpScoring::ThreeOfAKind.new(HandWithRankings.new([6,6,6,9,9]))
        expect(eights > sixes).to be
        expect(sixes < eights).to be
      end
    end
    context "When comparing Four of a Kind Hands" do
      it "should compare the value of the four cards" do
        eights  = OfcpScoring::FourOfAKind.new(HandWithRankings.new([8,8,8,8,13]))
        sixes = OfcpScoring::FourOfAKind.new(HandWithRankings.new([6,6,6,6,14]))
        expect(eights > sixes).to be
        expect(sixes < eights).to be
      end
    end
    context "When comparing OfcpScoring::Flushes" do
      it "should compare the highest card" do
        ten_high  = OfcpScoring::Flush.new(HandWithRankings.new([2,3,4,5,10]))
        eight_high = OfcpScoring::Flush.new(HandWithRankings.new([2,3,4,5,8]))
        expect(ten_high > eight_high).to be
        expect(eight_high < ten_high).to be
      end
    end
    context "When comparing straights" do
      it "should use the highest card when an ace is not involved" do
        ten_high  = OfcpScoring::Straight.new(HandWithRankings.new([2,3,4,5,10]))
        eight_high = OfcpScoring::Straight.new(HandWithRankings.new([2,3,4,5,8]))
        expect(ten_high > eight_high).to be
        expect(eight_high < ten_high).to be
      end
      context "When there is an ace" do
        it "should rank broadway straights above king high straights" do
          broadway  = OfcpScoring::Straight.new(HandWithRankings.new([10,11,12,13,14]))
          king_high = OfcpScoring::Straight.new(HandWithRankings.new([9,10,11,12,13]))
          expect(broadway > king_high).to be
          expect(king_high < broadway).to be
        end
        it "should rank six high straights above wheel straights" do
          six_high  = OfcpScoring::Straight.new(HandWithRankings.new([2,3,4,5,6]))
          wheel = OfcpScoring::Straight.new(HandWithRankings.new([14,2,3,4,5]))
          expect(six_high > wheel).to be
          expect(wheel < six_high).to be
        end
      end
    end
    context "When comparing straight flushes" do
      it "should use the highest card" do
        ten_high  = OfcpScoring::StraightFlush.new(HandWithRankings.new([2,3,4,5,10]))
        eight_high = OfcpScoring::StraightFlush.new(HandWithRankings.new([2,3,4,5,8]))
        expect(ten_high > eight_high).to be
        expect(eight_high < ten_high).to be
      end
    end
  end

end
