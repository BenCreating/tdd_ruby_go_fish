class GoFishTurn
  attr_reader :turn_player

  def initialize(turn_player, all_players)
    @turn_player = turn_player
    @all_players = all_players
  end

  def play(target_player, target_rank = turn_player.cards[0].rank)
    turn_player.take_from(target_player, target_rank)
  end
end
