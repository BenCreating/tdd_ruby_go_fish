require_relative '../lib/go_fish_game'
require_relative '../lib/go_fish_player'

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
      player_2_card_count = game.players[0].card_count
      expect(player_1_card_count).to eq GoFishGame::STARTING_CARD_COUNT
      expect(player_2_card_count).to eq GoFishGame::STARTING_CARD_COUNT
    end
  end
end
