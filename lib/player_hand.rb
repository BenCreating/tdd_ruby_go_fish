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
      score += 1 if remove_set?(rank)
    end
    score
  end

  def remove_set?(rank)
    did_remove_set = false
    if full_card_set?(rank)
      cards.reject! { |card| card.rank == rank }
      did_remove_set = true
    end
    did_remove_set
  end

  def full_card_set?(rank)
    cards_of_rank = cards.filter { |card| card.rank == rank }
    if cards_of_rank.count >= GoFishGame::CARD_SET_SIZE
      true
    else
      false
    end
  end

  def deck_ranks
    deck_ranks = cards.map { |card| card.rank }
    deck_ranks.uniq!
  end
end
