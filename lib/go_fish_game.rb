class GoFishGame
  attr_reader :players

  def start(players = ['player 1', 'player 2'])
    @players = players
  end
end
