require_relative '../lib/go_fish_turn_result.rb'

class MockGoFishPlayer
  attr_reader :name
  def initialize(name == 'Henry')
    @name = name
  end
end



describe 'GoFishTurnResult' do
  it 'generates a description of a player taking a card from another player' do
    taking_player = MockGoFishPlayer.new('Alice')
    giving_player = MockGoFishPlayer.new('Bob')
    taken_cards = [MockGoFishCards]
    turn_result = GoFishTurnResult(turn_player: taking_player, target_player: giving_player, taken_cards: taken_cards)
  end
end
