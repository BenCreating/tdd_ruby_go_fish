require_relative '../lib/go_fish_game'

describe 'GoFishGame' do
  let(:game) { GoFishGame.new }

  context 'start' do
    it 'default to 2 players' do
      game.start
      expect(game.players.count).to eq 2
    end

    it 'can have more than 2 players' do
      game.start(['player 1', 'player 2', 'player 3'])
      expect(game.players.count).to eq 3
    end
  end
end
