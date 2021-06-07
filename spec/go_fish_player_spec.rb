require_relative '../lib/go_fish_player'
require_relative '../lib/playing_card'

class MockCardDeck
  attr_reader :cards

  def initialize(cards = default_cards())
    @cards = cards
  end

  def cards_left
    cards.count
  end

  def deal
    cards.pop
  end

  def add_card(card)
    cards.unshift(card)
  end

  def default_cards
    cards = []
    card_suit_count = 4
    %w(A 2 3 4 5 6 7 8 9 10 J Q K).each do |rank|
      card_suit_count.times { cards << PlayingCard.new(rank) }
    end
    cards
  end
end

describe 'GoFishPlayer' do
  let(:winning_hand) {  }
  it 'creates a player without specifying attributes' do
    player = GoFishPlayer.new
    expect(player.name).not_to be_nil
    expect(player.card_count).to eq 0
  end

  it 'creates a player with specified attributes' do
    player = GoFishPlayer.new(name: 'Alice', cards: MockCardDeck.new([PlayingCard.new]))
    expect(player.name).to eq 'Alice'
    expect(player.card_count).to eq 1
    player2 = GoFishPlayer.new(name: 'Bob', cards: MockCardDeck.new([PlayingCard.new, PlayingCard.new]))
    expect(player2.name).to eq 'Bob'
    expect(player2.card_count).to eq 2
  end

  it 'plays the top card from the hand' do
    player = GoFishPlayer.new(name: 'Alice', cards: MockCardDeck.new([PlayingCard.new('A'), PlayingCard.new('K')]))
    played_card = player.play_card
    expect(played_card.rank).to eq 'K'
    player2 = GoFishPlayer.new(name: 'Bob', cards: MockCardDeck.new([PlayingCard.new('2'), PlayingCard.new('3')]))
    played_card2 = player2.play_card
    expect(played_card2.rank).to eq '3'
  end

  it 'adds a card to the hand' do
    player = GoFishPlayer.new()
    player.pick_up_card(PlayingCard.new)
    expect(player.card_count).to eq 1
  end
end
