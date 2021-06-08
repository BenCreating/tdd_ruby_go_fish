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
      STARTING_CARD_COUNT.times do
        if deck.cards_left > 0
          player.pick_up_card(deck.deal)
        end
      end
    end
  end

  def next_turn
    current_player = get_current_player
    turn = GoFishTurn.new(current_player, players, deck)
    turn.play

    increment_turn_counter
  end

  def get_current_player
    current_player = players[turn_counter]
    players.count.times do
      # TODO add intention revealung name
      break if deck.cards_left != 0 or current_player.card_count != 0
      increment_turn_counter
      current_player = players[turn_counter]
    end
    current_player
  end

  def all_players_out_of_cards?
    players.each do |player|
      if player.card_count != 0
        return false
        break
      end
    end
    true
  end
  end

  def increment_turn_counter
    self.turn_counter = (turn_counter + 1) % players.count
  end
end
