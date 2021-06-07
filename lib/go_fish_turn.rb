class GoFishTurn
  attr_reader :turn_player

  def initialize(turn_player, all_players)
    @turn_player = turn_player
    @all_players = all_players
  end

  # def play_round
  #   table_cards = play_all_round_cards()
  #   self.last_round_table_cards = table_cards
  #   round_result = WarRoundResult.new(table_cards, players)
  #   award_cards_to_winner(round_result.winner, table_cards)
  #   round_result.description
  # end
end
