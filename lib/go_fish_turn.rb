require_relative 'go_fish_game'

class GoFishTurn
  attr_reader :turn_player, :all_players, :deck

  def initialize(turn_player, all_players, deck)
    @turn_player = turn_player
    @all_players = all_players
    @deck = deck
  end

  def play(target_player = default_target_player(turn_player), target_rank = turn_player.cards.deck_ranks[0])
    refill_hand(turn_player)
    turn_player.take_from(target_player, target_rank)
    resolve_turn
  end

  def refill_hand(player)
    if player.card_count == 0
      GoFishGame::REFILL_CARDS_AMOUNT.times do
        player.pick_up_card(deck.deal)
      end
    end
  end

  def fish_card_from_deck
    deck.deal
  end

  def default_target_player(current_player)
    possible_players = all_players.reject { |player| player == current_player }
    possible_players[0]
  end

  def resolve_turn
    turn_score = turn_player.cards.remove_card_set_and_return_score
    if turn_score > 0
      turn_player.score += turn_score
    else
      turn_player.pick_up_card(fish_card_from_deck)
    end
  end
end
