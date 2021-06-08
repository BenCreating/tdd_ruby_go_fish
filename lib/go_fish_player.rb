class GoFishPlayer
  attr_reader :name, :cards
  attr_accessor :score

  def initialize(name: 'Anonymous', cards: PlayerHand.new([]), score: 0)
    @name = name
    @cards = cards
    @score = score
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

  def take_from(target_player, target_rank)
    taken_cards = target_player.give_cards_by_rank(target_rank)
    taken_cards.each { |card| pick_up_card(card) }
  end
end
