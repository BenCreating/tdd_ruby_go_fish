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

  context '#fish_card_from_deck' do
    let(:fishing_players) { [GoFishPlayer.new, GoFishPlayer.new] }

    it 'draws the top card (7) from the deck' do
      target_card = PlayingCard.new('7')
      fishing_deck = CardDeck.new([PlayingCard.new('A'), target_card])
      turn = GoFishTurn.new(fishing_players[0], fishing_players, fishing_deck)
      expect(turn.fish_card_from_deck).to eq target_card
      expect(fishing_deck.cards_left).to eq 1
    end

    it 'draws the top card (J) from the deck' do
      target_card = PlayingCard.new('J')
      fishing_deck = CardDeck.new([PlayingCard.new('9'), target_card])
      turn = GoFishTurn.new(fishing_players[0], fishing_players, fishing_deck)
      expect(turn.fish_card_from_deck).to eq target_card
      expect(fishing_deck.cards_left).to eq 1
    end
  end

  context '#resolve_turn' do
    let(:player_hand) { PlayerHand.new([PlayingCard.new('A'), PlayingCard.new('A'), PlayingCard.new('A'), PlayingCard.new('A'), PlayingCard.new('5'), PlayingCard.new('5'), PlayingCard.new('5'), PlayingCard.new('5')]) }

    it 'removes and scores sets in hand' do
      player = GoFishPlayer.new(cards: player_hand)
      turn = GoFishTurn.new(player, [player], deck)
      turn.resolve_turn
      expect(player.card_count).to eq 0
      expect(player.score).to eq 2
    end
  end
end
