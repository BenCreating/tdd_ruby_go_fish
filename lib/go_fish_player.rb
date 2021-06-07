class GoFishPlayer
  attr_reader :name, :cards

  def initialize(name: 'Anonymous', cards: CardDeck.new([]))
    @name = name
    @cards = cards
  end

  def card_count
    cards.cards_left
  end

  def pick_up_card(card)
    cards.add_card(card)
  end

  def give_cards_by_rank(rank)
    cards.take_cards_by_rank(rank)
  end
end
