require_relative 'card_deck'
require_relative 'go_fish_game'

class PlayerHand < CardDeck
  def take_cards_by_rank(rank)
    taken_cards = cards.filter { |card| card.rank == rank }
    cards.reject! { |card| card.rank == rank }
    taken_cards
  end

  def remove_card_set_and_return_score
    score = 0
    RANKS.each do |rank|
      if full_card_set?(rank)
        cards.reject! { |card| card.rank == rank }
        score += 1
      end
    end
    score
  end

  def full_card_set?(rank)
    cards_of_rank = cards.filter { |card| card.rank == rank }
    if cards_of_rank.count >= GoFishGame::CARD_SET_SIZE
      true
    else
      false
    end
  end
end
