class HandScorer
  def score(hand_1, hand_2)
    score = 0
    score +=1 if hand_1.top_rank > hand_2.top_rank
    score +=1 if hand_1.middle_rank > hand_2.middle_rank
    score +=1 if hand_1.bottom_rank > hand_2.bottom_rank

    score += 3 if score == 3
    score
  end
end
