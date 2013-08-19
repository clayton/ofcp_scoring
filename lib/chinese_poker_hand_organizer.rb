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

    {
      :ranks_only   => ranks_only,
      :suits_only   => suits_only,
      :sorted_ranks => sorted_ranks,
      :hand         => hand
    }

  end
end
