require_relative '../lib/go_fish_game'

describe 'GoFishGame' do
  let(:game) { GoFishGame.new }

  context 'start' do
    it 'default to 2 players' do
      game.start
      expect(game.players.count).to eq 2
    end
  end
end
