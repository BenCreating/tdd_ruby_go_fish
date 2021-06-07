require_relative 'card_deck'

class PlayerHand < CardDeck
  def take_cards_by_rank(rank)
    taken_cards = cards.filter { |card| card.rank == rank }
    cards.reject! { |card| card.rank == rank }
    taken_cards
  end
end
