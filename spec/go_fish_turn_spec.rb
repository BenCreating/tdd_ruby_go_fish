require_relative '../lib/go_fish_game'
require_relative '../lib/go_fish_turn'
require_relative '../lib/card_deck'
require_relative '../lib/player_hand'
require_relative '../lib/playing_card'
require_relative '../lib/go_fish_player'

describe 'GoFishTurn' do
  let(:player_1_cards) { [PlayingCard.new('K'), PlayingCard.new('7'), PlayingCard.new('7'), PlayingCard.new('7')] }
  let(:player_2_cards) { [PlayingCard.new('K'), PlayingCard.new('2'), PlayingCard.new('7')] }
  let(:player_3_cards) { [PlayingCard.new('K'), PlayingCard.new('K')] }
  let(:players) { [GoFishPlayer.new(cards: PlayerHand.new(player_1_cards)), GoFishPlayer.new(cards: PlayerHand.new(player_2_cards)), GoFishPlayer.new(cards: PlayerHand.new(player_3_cards))] }
  let(:deck) { CardDeck.new }

  context '#play' do
    let(:player_1_turn) { GoFishTurn.new(players[0], players, deck) }
    let(:player_2_turn) { GoFishTurn.new(players[1], players, deck) }
    let(:player_3_turn) { GoFishTurn.new(players[2], players, deck) }

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

    it 'cards are removed when player 2 asks player 1 for 7 and completes a set' do
      player_2_turn.play(players[0], '7')
      expect(players[1].card_count).to eq 2
      expect(players[1].score).to eq 1
    end

    it 'score increases when a players completes a set' do
      player_1_turn.play(players[1], 'K')
      player_1_turn.play(players[2], 'K')
      expect(players[0].score).to eq 1
    end

    it 'draws a card at the start of a turn when the player has none' do
      # empty hand
      player_3_turn.play(players[0], 'K')
      player_3_turn.play(players[1], 'K')
      # try to play without a card
      player_3_turn.play(players[1])
      expect(players[2].cards.cards_left).to eq 1
    end
  end

  context '#refill_hand' do
    let(:empty_player) { GoFishPlayer.new }
    let(:turn) { GoFishTurn.new(empty_player, [empty_player], deck) }
    it 'draws a card and adds it to the hand' do
      turn.refill_hand(empty_player)
      expect(empty_player.cards.cards_left).to eq GoFishGame::REFILL_CARDS_AMOUNT
    end
  end

  context '#default_target_player' do
    it 'returns the first player (player 2) that is not the current player (player 1)' do
      current_player = players[0]
      turn = GoFishTurn.new(current_player, players, deck)
      default_player = turn.default_target_player(current_player)
      expect(default_player).to eq players[1]
    end

    it 'returns player 1 when player 2 is the current player' do
      current_player = players[1]
      turn = GoFishTurn.new(current_player, players, deck)
      default_player = turn.default_target_player(current_player)
      expect(default_player).to eq players[0]
    end
  end
end
