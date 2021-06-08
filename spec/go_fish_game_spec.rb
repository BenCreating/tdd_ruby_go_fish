require_relative '../lib/go_fish_game'
require_relative '../lib/go_fish_player'
require_relative '../lib/shuffling_deck'
require_relative '../lib/player_hand'
require_relative '../lib/playing_card'

describe 'GoFishGame' do
  context '#initialize' do
    it 'default to 2 players' do
      game = GoFishGame.new
      expect(game.players.count).to eq 2
    end

    it 'can have more than 2 players' do
      game = GoFishGame.new([GoFishPlayer.new, GoFishPlayer.new, GoFishPlayer.new])
      expect(game.players.count).to eq 3
    end
  end

  context 'start' do
    it 'deals cards for a 2 player game' do
      game = GoFishGame.new
      game.start
      expect(game.players[0].card_count).to eq GoFishGame::STARTING_CARD_COUNT
      expect(game.players[1].card_count).to eq GoFishGame::STARTING_CARD_COUNT
    end

    it 'deals cards for a 3 player game' do
      game = GoFishGame.new([GoFishPlayer.new, GoFishPlayer.new, GoFishPlayer.new])
      game.start
      expect(game.players[0].card_count).to eq GoFishGame::STARTING_CARD_COUNT
      expect(game.players[1].card_count).to eq GoFishGame::STARTING_CARD_COUNT
      expect(game.players[2].card_count).to eq GoFishGame::STARTING_CARD_COUNT
    end
  end

  context '#deal_starting_cards' do
    it 'deals cards to 2 players' do
      game = GoFishGame.new([GoFishPlayer.new, GoFishPlayer.new])
      game.deal_starting_cards
      expect(game.players[0].card_count).to eq GoFishGame::STARTING_CARD_COUNT
      expect(game.players[1].card_count).to eq GoFishGame::STARTING_CARD_COUNT
    end

    it 'deals cards to 3 players' do
      game = GoFishGame.new([GoFishPlayer.new, GoFishPlayer.new, GoFishPlayer.new])
      game.deal_starting_cards
      expect(game.players[0].card_count).to eq GoFishGame::STARTING_CARD_COUNT
      expect(game.players[1].card_count).to eq GoFishGame::STARTING_CARD_COUNT
      expect(game.players[2].card_count).to eq GoFishGame::STARTING_CARD_COUNT
    end
  end

  context '#play_next_turn' do
    def build_deck(ranks)
      cards = ranks.map { |rank| PlayingCard.new(rank) }
      ShufflingDeck.new(cards)
    end

    def build_hand(ranks)
      cards = ranks.map { |rank| PlayingCard.new(rank) }
      PlayerHand.new(cards)
    end

    let(:no_match_deck) { build_deck((3..50).to_a) }
    let(:all_match_deck) { build_deck(['A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A']) }
    let(:empty_deck) { ShufflingDeck.new([]) }
    let(:two_players) { [GoFishPlayer.new, GoFishPlayer.new] }
    let(:three_players) { [GoFishPlayer.new(cards: build_hand(['A', '2'])), GoFishPlayer.new, GoFishPlayer.new(cards: build_hand(['2', '2', '2', 'A']))] }

    it 'plays the next player\'s turn' do
      game = GoFishGame.new(two_players, all_match_deck)
      game.start
      game.play_next_turn
      expect(two_players[0].score).to eq 1
    end

    it 'skips players with no cards when they cannot draw' do
      game = GoFishGame.new(three_players, empty_deck)
      game.play_next_turn # player 1 turn
      # player 2 has no cards
      game.play_next_turn # player 3 turn
      expect(three_players[2].score).to eq 1
    end
  end

  context '#get_current_player' do
    let(:players) { [GoFishPlayer.new, GoFishPlayer.new] }

    it 'return player 1 on the first turn' do
      game = GoFishGame.new(players)
      expect(game.get_current_player).to eq players[0]
    end

    it 'return player 2 on the second turn' do
      game = GoFishGame.new(players)
      game.play_next_turn
      expect(game.get_current_player).to eq players[1]
    end

    it 'return to player 2 when player 1 has no cards and cannot draw' do
      skip_players = [GoFishPlayer.new(name: 'Player 1'), GoFishPlayer.new(name: 'Player 2', cards: PlayerHand.new([PlayingCard.new('A')]))]
      game = GoFishGame.new(skip_players, ShufflingDeck.new([]))
      expect(game.get_current_player).to eq skip_players[1]
    end

    it 'gives player 1 another turn if they get a card from another player' do
      players = [GoFishPlayer.new(name: 'Player 1', cards: PlayerHand.new([PlayingCard.new('A')])), GoFishPlayer.new(name: 'Player 2', cards: PlayerHand.new([PlayingCard.new('A')]))]
      game = GoFishGame.new(players, ShufflingDeck.new([]))
      game.play_next_turn
      expect(game.get_current_player).to eq players[0]
      game.play_next_turn
      expect(game.get_current_player).to eq players[0]
    end
  end

  context '#winners' do
    it 'player 1 wins when they have the highest score' do
      player_1 = GoFishPlayer.new(score: 5, name: 'Player 1')
      player_2 = GoFishPlayer.new(score: 0, name: 'Player 2')
      game = GoFishGame.new([player_1, player_2], ShufflingDeck.new([]))
      winner_array = game.winners
      expect(winner_array).to match_array [player_1]
    end

    it 'player 3 wins when they have the highest score' do
      player_1 = GoFishPlayer.new(score: 3, name: 'Player 1')
      player_2 = GoFishPlayer.new(score: 4, name: 'Player 2')
      player_3 = GoFishPlayer.new(score: 7, name: 'Player 3')
      game = GoFishGame.new([player_1, player_2, player_3], ShufflingDeck.new([]))
      winner_array = game.winners
      expect(winner_array).to match_array [player_3]
    end

    it 'player 1 and player 3 tie when they both have the highest score' do
      player_1 = GoFishPlayer.new(score: 5, name: 'Player 1')
      player_2 = GoFishPlayer.new(score: 2, name: 'Player 2')
      player_3 = GoFishPlayer.new(score: 5, name: 'Player 3')
      game = GoFishGame.new([player_1, player_2, player_3], ShufflingDeck.new([]))
      winner_array = game.winners
      expect(winner_array).to match_array [player_1, player_3]
    end

    it 'returns nil when there are still cards in the deck' do
      player_1 = GoFishPlayer.new(score: 5, name: 'Player 1')
      player_2 = GoFishPlayer.new(score: 0, name: 'Player 2')
      game = GoFishGame.new([player_1, player_2], ShufflingDeck.new)
      winner_array = game.winners
      expect(winner_array).to eq nil
    end

    it 'returns nil when any player still has cards' do
      player_1 = GoFishPlayer.new(score: 5, name: 'Player 1', cards: PlayerHand.new([PlayingCard.new('A')]))
      player_2 = GoFishPlayer.new(score: 0, name: 'Player 2')
      game = GoFishGame.new([player_1, player_2], ShufflingDeck.new([]))
      winner_array = game.winners
      expect(winner_array).to eq nil
    end
  end

  context '#highest_scoring_players' do
    it 'returns player 1 when only they have the highest score' do
      player_1 = GoFishPlayer.new(score: 5, name: 'Player 1')
      player_2 = GoFishPlayer.new(score: 0, name: 'Player 2')
      game = GoFishGame.new([player_1, player_2], ShufflingDeck.new([]))
      winning_players = game.highest_scoring_players
      expect(winning_players).to match_array [player_1]
    end

    it 'returns player 1 and player 2 when they are tied for the highest score' do
      player_1 = GoFishPlayer.new(score: 5, name: 'Player 1')
      player_2 = GoFishPlayer.new(score: 5, name: 'Player 2')
      player_3 = GoFishPlayer.new(score: 0, name: 'Player 3')
      game = GoFishGame.new([player_1, player_2, player_3], ShufflingDeck.new([]))
      winning_players = game.highest_scoring_players
      expect(winning_players).to match_array [player_1, player_2]
    end

    it 'returns all players when all scores are equal' do
      player_1 = GoFishPlayer.new(score: 0, name: 'Player 1')
      player_2 = GoFishPlayer.new(score: 0, name: 'Player 2')
      player_3 = GoFishPlayer.new(score: 0, name: 'Player 3')
      game = GoFishGame.new([player_1, player_2, player_3], ShufflingDeck.new([]))
      winning_players = game.highest_scoring_players
      expect(winning_players).to match_array [player_1, player_2, player_3]
    end
  end

  context '#all_players_out_of_cards?' do
    let(:two_players_no_cards) { [GoFishPlayer.new, GoFishPlayer.new] }
    let(:three_players_no_cards) { [GoFishPlayer.new, GoFishPlayer.new, GoFishPlayer.new] }

    it 'returns true for 2 players with no cards' do
      game = GoFishGame.new(two_players_no_cards, ShufflingDeck.new([]))
      all_out = game.all_players_out_of_cards?
      expect(all_out).to eq true
    end

    it 'returns true for 3 players with no cards' do
      game = GoFishGame.new(three_players_no_cards, ShufflingDeck.new([]))
      all_out = game.all_players_out_of_cards?
      expect(all_out).to eq true
    end
  end
end
