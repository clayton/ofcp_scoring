class ChinesePokerHandOrganizer
  def organize(hand)
    return "" if hand.nil?
    suits_only = Hash.new(0)
    ranks_only = Hash.new(0)
    sorted_ranks = []
    hand.each do |card|
      ranks_only[card[0..-2]] += 1
      suits_only[card[1]] += 1
      case card[0]
      when "A"
        sorted_ranks << 1
      when "K"
        sorted_ranks << 13
      when "Q"
        sorted_ranks << 12
      when "J"
        sorted_ranks << 11
      else
        sorted_ranks << card[0..-2].to_i
      end
    end

    sorted_ranks.sort!

    OrganizedHand.new(build_organized_hand(ranks_only, suits_only, sorted_ranks))
  end

private
  def build_organized_hand(ranks, suits, sorted)
    params = {:ranks => sorted}

    puts ranks.inspect

    params.merge!({:two_cards_match => true}) if ranks.values.include?(2)
    params.merge!({:two_different_cards_match => true}) if ranks.find_all{|k,v| v == 2}.size > 1
    params.merge!({:three_cards_match => true}) if ranks.values.include?(3)
    params.merge!({:four_cards_match => true}) if ranks.values.include?(4)
    params.merge!({:all_suits_match => true}) if suits.values.include?(5)
    params.merge!({:ranks_in_order => true}) if (sorted.first..sorted.last).to_a == sorted
    params.merge!({:ranks_in_order => true}) if (sorted & [1,10,11,12,13]) == sorted
    params.merge!({:high_card_ace => true}) if sorted.include?(1)
    params.merge!({:three_card_hand => true}) if sorted.size == 3

    params
  end
end
