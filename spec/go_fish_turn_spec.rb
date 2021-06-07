require_relative '../lib/go_fish_turn'
require_relative '../lib/player_hand'
require_relative '../lib/playing_card'

class MockGoFishPlayer
  attr_reader :name, :cards

  def initialize(name: 'Anonymous', cards: PlayerHand.new([]))
    @name = name
    @cards = cards
  end

  def pick_up_card(card)
    cards.add_card(card)
  end

  def give_cards_by_rank(rank)
    cards.take_cards_by_rank(rank)
  end

  def take_from(target_player, target_rank)
    target_player.give_cards_by_rank(target_rank)
  end
end

describe 'GoFishTurn' do
  let(:player_1_cards) { [PlayingCard.new('5'), PlayingCard.new('7')] }
  let(:player_2_cards) { [PlayingCard.new('K'), PlayingCard.new('2')] }
  let(:players) { [MockGoFishPlayer.new(cards: PlayerHand.new(player_1_cards)), MockGoFishPlayer.new(cards: PlayerHand.new(player_2_cards))] }


end
