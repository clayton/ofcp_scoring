require 'spec_helper'

describe "Hand Ranker" do
  it "should return nothing when no cards are present" do
    expect(rank(nil)).to eq("")
  end
  it "should return pair when two matching cards are found" do
    expect(rank(["Ah", "As", "8d", "6d", "4d"])).to be_a(Pair)
  end
  it "should return two pair when two sets of two matching cards are found" do
    expect(rank(["Ah", "As", "8d", "8d", "4d"])).to be_a(TwoPair)
  end
  it "should return Three of A Kind when three matching cards are found" do
    expect(rank(["Ah", "As", "Ad", "8d", "4d"])).to be_a(ThreeOfAKind)
  end
  it "should return Full House when three matching cards and two other matching cards are found" do
    expect(rank(["Ah", "As", "Ad", "8d", "8d"])).to be_a(FullHouse)
  end
  it "should return HighCard when no matching cards are found" do
    expect(rank(["Ah", "Ks", "Qd", "8d", "6d"])).to be_a(HighCard)
  end
  it "should return Flush when all cards have the same suit" do
    expect(rank(["Ah", "Kh", "Qh", "8h", "6h"])).to be_a(Flush)
  end
  it "should return Straight when all cards are in order" do
    expect(rank(["Ah", "Kh", "Qh", "Jd", "10h"])).to be_a(Straight)
  end
end

def rank(cards)
  return "" if cards.nil?

  suits_only = cards.map{|c| c[1]}
  ranks_only = cards.map{|c| c[0]}
  grouped_counts = ranks_only.map{|card| ranks_only.find_all{|c| c == card}}.uniq.map(&:size)

  return Flush.new if suits_only.uniq.size == 1
  return FullHouse.new if grouped_counts.one?{|count| count == 3} && grouped_counts.one?{|count| count == 2}
  return ThreeOfAKind.new if grouped_counts.one?{|count| count == 3}
  return Pair.new if grouped_counts.one?{|count| count == 2}
  return HighCard.new if grouped_counts.all?{|count| count == 1}
  return TwoPair.new
end

class Straight
end

class Flush
end

class HighCard
end

class Pair
end

class TwoPair
end

class ThreeOfAKind
end

class FullHouse
end
