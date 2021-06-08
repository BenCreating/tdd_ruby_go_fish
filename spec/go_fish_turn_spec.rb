require_relative '../lib/go_fish_turn'
require_relative '../lib/player_hand'
require_relative '../lib/playing_card'
require_relative '../lib/go_fish_player'

describe 'GoFishTurn' do
  let(:player_1_cards) { [PlayingCard.new('K'), PlayingCard.new('7'), PlayingCard.new('7'), PlayingCard.new('7')] }
  let(:player_2_cards) { [PlayingCard.new('K'), PlayingCard.new('2'), PlayingCard.new('7')] }
  let(:player_3_cards) { [PlayingCard.new('K'), PlayingCard.new('K')] }
  let(:players) { [GoFishPlayer.new(cards: PlayerHand.new(player_1_cards)), GoFishPlayer.new(cards: PlayerHand.new(player_2_cards)), GoFishPlayer.new(cards: PlayerHand.new(player_3_cards))] }

  context '#play' do
    let(:player_1_turn) { GoFishTurn.new(players[0], players) }
    let(:player_2_turn) { GoFishTurn.new(players[1], players) }

    it 'rank defaults to the first card in the hand of player 1 (K)' do
      player_1_turn.play(players[1])
      expect(players[0].card_count).to eq 5
    end

    it 'player 1 asks player 2 for K, and recieves a card' do
      player_1_turn.play(players[1], 'K')
      expect(players[0].card_count).to eq 5
    end

    it 'player 2 asks player 3 for K, and recieves 2 cards' do
      player_2_turn.play(players[2], 'K')
      expect(players[1].card_count).to eq 5
    end
  end
end
