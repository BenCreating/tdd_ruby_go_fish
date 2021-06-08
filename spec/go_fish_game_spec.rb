require_relative '../lib/go_fish_game'
require_relative '../lib/go_fish_player'
require_relative '../lib/shuffling_deck'
require_relative '../lib/player_hand'
require_relative '../lib/playing_card'

describe 'GoFishGame' do
  let(:game) { GoFishGame.new }

  context 'start' do
    it 'default to 2 players' do
      game.start
      expect(game.players.count).to eq 2
    end

    it 'can have more than 2 players' do
      game.start([GoFishPlayer.new, GoFishPlayer.new, GoFishPlayer.new])
      expect(game.players.count).to eq 3
    end

    it 'deals cards for a 2 player game' do
      game.start
      player_1_card_count = game.players[0].card_count
      player_2_card_count = game.players[1].card_count
      expect(player_1_card_count).to eq GoFishGame::STARTING_CARD_COUNT
      expect(player_2_card_count).to eq GoFishGame::STARTING_CARD_COUNT
    end

    it 'deals cards for a 3 player game' do
      game.start([GoFishPlayer.new, GoFishPlayer.new, GoFishPlayer.new])
      player_1_card_count = game.players[0].card_count
      player_2_card_count = game.players[1].card_count
      player_3_card_count = game.players[2].card_count
      expect(player_1_card_count).to eq GoFishGame::STARTING_CARD_COUNT
      expect(player_2_card_count).to eq GoFishGame::STARTING_CARD_COUNT
      expect(player_3_card_count).to eq GoFishGame::STARTING_CARD_COUNT
    end
  end

  context '#deal_starting_cards' do
    it 'deals cards to 2 players' do
      game.start([GoFishPlayer.new, GoFishPlayer.new])
      game.deal_starting_cards
      # the deck is dealt twice, once in start (where the deck is initialized), and once when we call deal_starting_cards
      expect(game.players[0].card_count).to eq GoFishGame::STARTING_CARD_COUNT * 2
      expect(game.players[1].card_count).to eq GoFishGame::STARTING_CARD_COUNT * 2
    end

    it 'deals cards to 3 players' do
      game.start([GoFishPlayer.new, GoFishPlayer.new, GoFishPlayer.new])
      game.deal_starting_cards
      # the deck is dealt twice, once in start (where the deck is initialized), and once when we call deal_starting_cards
      expect(game.players[0].card_count).to eq GoFishGame::STARTING_CARD_COUNT * 2
      expect(game.players[1].card_count).to eq GoFishGame::STARTING_CARD_COUNT * 2
      expect(game.players[2].card_count).to eq GoFishGame::STARTING_CARD_COUNT * 2
    end
  end
  context '#get_current_player' do
    let(:players) { [GoFishPlayer.new, GoFishPlayer.new] }

    it 'return player 1 on the first turn' do
      game.start(players)
      expect(game.get_current_player).to eq players[0]
    end

    it 'return player 2 on the second turn' do
      game.start(players)
      game.next_turn
      expect(game.get_current_player).to eq players[1]
    end

    it 'return to player 2 when player 1 has no cards and cannot draw' do
      skip_players = [GoFishPlayer.new(name: 'Player 1'), GoFishPlayer.new(name: 'Player 2', cards: PlayerHand.new([PlayingCard.new('A')]))]
      game.start(skip_players, ShufflingDeck.new([]))
      expect(game.get_current_player).to eq skip_players[1]
    end
  end

  context '#increment_turn_counter' do
    let(:players) { [GoFishPlayer.new, GoFishPlayer.new] }
    it 'adds 1 to the turn counter' do
      game.start(players)
      game.increment_turn_counter
      expect(game.turn_counter).to eq 1
    end

    it 'wraps the turn counter when when it is more than the number of players' do
      game.start(players)
      game.increment_turn_counter
      game.increment_turn_counter
      expect(game.turn_counter).to eq 0
    end
  end
end
