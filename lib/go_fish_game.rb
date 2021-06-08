require_relative 'go_fish_player'
require_relative 'shuffling_deck'

class GoFishGame
  attr_reader :players, :deck
  attr_accessor :turn_counter

  STARTING_CARD_COUNT = 5
  CARD_SET_SIZE = 4
  REFILL_CARDS_AMOUNT = 1

  def start(players = [GoFishPlayer.new(name: 'Player 1'), GoFishPlayer.new(name: 'Player 2')], deck = ShufflingDeck.new)
    @turn_counter = 0
    @players = players
    @deck = deck
    deck.shuffle
    deal_starting_cards()
  end

  def deal_starting_cards
    players.each do |player|
      STARTING_CARD_COUNT.times { player.pick_up_card(deck.deal) }
    end
  end
  def get_current_player
    current_player = players[turn_counter]
    players.count.times do
      break if deck.cards_left != 0 or current_player.card_count != 0
      increment_turn_counter
      current_player = players[turn_counter]
    end
    current_player
  end

  def increment_turn_counter
    self.turn_counter = (turn_counter + 1) % players.count
  end
end
