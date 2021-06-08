require_relative '../lib/go_fish_turn'
require_relative '../lib/player_hand'
require_relative '../lib/playing_card'
require_relative '../lib/go_fish_player'

describe 'GoFishTurn' do
  let(:player_1_cards) { [PlayingCard.new('K'), PlayingCard.new('7'), PlayingCard.new('7'), PlayingCard.new('7')] }
  let(:player_2_cards) { [PlayingCard.new('K'), PlayingCard.new('2'), PlayingCard.new('7')] }
  let(:player_3_cards) { [PlayingCard.new('K'), PlayingCard.new('K')] }
  let(:players) { [GoFishPlayer.new(cards: PlayerHand.new(player_1_cards)), GoFishPlayer.new(cards: PlayerHand.new(player_2_cards)), GoFishPlayer.new(cards: PlayerHand.new(player_3_cards))] }


end
