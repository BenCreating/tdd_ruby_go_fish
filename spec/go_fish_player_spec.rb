require_relative '../lib/go_fish_player'
require_relative '../lib/playing_card'
require_relative '../lib/card_deck'

describe 'GoFishPlayer' do
  it 'creates a player without specifying attributes' do
    player = GoFishPlayer.new
    expect(player.name).not_to be_nil
    expect(player.card_count).to eq 0
  end

  it 'creates a player with specified attributes' do
    player = GoFishPlayer.new(name: 'Alice', cards: CardDeck.new([PlayingCard.new]))
    expect(player.name).to eq 'Alice'
    expect(player.card_count).to eq 1
    player2 = GoFishPlayer.new(name: 'Bob', cards: CardDeck.new([PlayingCard.new, PlayingCard.new]))
    expect(player2.name).to eq 'Bob'
    expect(player2.card_count).to eq 2
  end

  it 'adds a card to the hand' do
    player = GoFishPlayer.new()
    player.pick_up_card(PlayingCard.new)
    expect(player.card_count).to eq 1
  end

  context '#give_cards' do
    let(:player) { player = GoFishPlayer.new(cards: CardDeck.new([PlayingCard.new('2'), PlayingCard.new('J'), PlayingCard.new('3')])) }
    it 'returns an array with 1 card when the player only has one card of a specified rank' do
      cards = player.give_cards('2')
      expect(cards.count).to eq 1
    end
  end
end
