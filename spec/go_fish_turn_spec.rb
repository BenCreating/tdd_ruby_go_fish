require_relative '../lib/go_fish_turn'
require_relative '../lib/card_deck'
require_relative '../lib/playing_card'

class MockGoFishPlayer
  attr_reader :name, :cards

  def initialize(name: 'Anonymous', cards: CardDeck.new([]))
    @name = name
    @cards = cards
  end

  def pick_up_card(card)
    cards.add_card(card)
  end

  def give_cards_by_rank(rank)
    cards.take_cards_by_rank(rank)
  end

  def take_from(target_player, target_rank)
    target_player.give_cards_by_rank(target_rank)
  end
end

describe 'GoFishTurn' do
  before(:each) do
    @player_1_cards = [PlayingCard.new('5'), PlayingCard.new('7')]
    @player_2_cards = [PlayingCard.new('K'), PlayingCard.new('2')]
    @players = [MockGoFishPlayer.new(cards: CardDeck.new(@player_1_cards)), MockGoFishPlayer.new(cards: CardDeck.new(@player_2_cards))]
  end

  it 'player 1 asks for cards from player 2 and recieves what they asked for' do
    turn = GoFishTurn.new(@players[0], @players)
    taken_cards = turn.turn_player.take_from(@players[1], 'K')
    expect(taken_cards.first).to eq @player_2_cards.first
  end
end
