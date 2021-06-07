require_relative 'go_fish_player'
require_relative 'shuffling_deck'

class GoFishGame
  attr_reader :players, :deck

  STARTING_CARD_COUNT = 5

  def start(players = [GoFishPlayer.new(name: 'Player 1'), GoFishPlayer.new(name: 'Player 2')])
    @players = players
    @deck = ShufflingDeck.new
    deal_starting_cards()
  end

  def deal_starting_cards
    players.each do |player|
      STARTING_CARD_COUNT.times { player.pick_up_card(deck.deal) }
    end
  end
end
