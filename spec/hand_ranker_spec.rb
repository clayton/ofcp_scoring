require 'spec_helper'

describe "Hand Categorization" do
  it "should return an empty string if no hand is present" do
    expect(categorize(nil)).to eq("")
  end
  it "should return an empty string for hands without five cards" do
     expect(categorize(%w(Ah Kh Jh))).to eq("")
  end
  it "should return a Pair when two cards match" do
    expect(categorize(%w(Ah Kh Jh Jd 9c))).to be_a(Pair)
  end
  it "should return two Pair when two sets of two cards match" do
    expect(categorize(%w(Ah Ac Jh Jd 9c))).to be_a(TwoPair)
  end
  it "should return Three Of a Kind when three cards match" do
    expect(categorize(%w(Ah Jc Jh Jd 9c))).to be_a(ThreeOfAKind)
  end
  it "should return Four of a kind when four cards match" do
    expect(categorize(%w(Js Jc Jh Jd 9c))).to be_a(FourOfAKind)
  end
  it "should return Full House when three cards match and two cards match" do
    expect(categorize(%w(Js Jc Jh 9d 9c))).to be_a(FullHouse)
  end
  it "should return High Card when no cards match" do
    expect(categorize(%w(Js Ac 7h 8d 9c))).to be_a(HighCard)
  end
  it "should return Flush when suits all same" do
    expect(categorize(%w(2h 3h 5h Kh Jh))).to be_a(Flush)
  end
  it "should return Straight when all five cards are in sequential order" do
    expect(categorize(%w(2c 3d 4d 5c 6h))).to be_a(Straight)
  end
  it "should return Straight when five cards starting with an ace are present" do
    expect(categorize(%w(Ac 2c 3d 4d 5c))).to be_a(Straight)
  end
  it "should return Straight when five cards starting with an 10 are present" do
    expect(categorize(%w(10c Jh Qs Kd Ac))).to be_a(Straight)
  end

end

def categorize(hand)
  return "" if hand.nil?
  return "" if hand.size < 5
  suits_only = Hash.new(0)
  ranks_only = Hash.new(0)
  sorted_ranks = []
  hand.each do |card|
    ranks_only[card[0..-2]] += 1
    suits_only[card[1]] += 1
    case card[0]
    when "A"
      sorted_ranks << "1"
    when "K"
      sorted_ranks << "13"
    when "Q"
      sorted_ranks << "12"
    when "J"
      sorted_ranks << "11"
    else
      sorted_ranks << card[0..-2]
    end
  end

  sorted_ranks.sort!

  return Straight.new if ((sorted_ranks.first..sorted_ranks.last).to_a & sorted_ranks) == sorted_ranks.sort
  return Flush.new if max_value_of(suits_only, 5)
  return HighCard.new if max_value_of(ranks_only, 1)
  return FourOfAKind.new if max_value_of(ranks_only,4)
  return FullHouse.new if max_value_of(ranks_only,3) && ranks_only.values.one?{|matches| matches == 2}
  return ThreeOfAKind.new if max_value_of(ranks_only, 3)
  return TwoPair.new if ranks_only.keys.size == 3
  Pair.new
end

def max_value_of(hash, max)
  hash.values.max == max
end

class Straight
end

class Flush
end

class HighCard
end

class FullHouse
end

class ThreeOfAKind
end

class FourOfAKind
end

class TwoPair
end

class Pair

end
