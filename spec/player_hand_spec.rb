require_relative '../lib/player_hand'
require_relative '../lib/playing_card'

describe 'CardDeck' do
  let(:deck_cards) { [PlayingCard.new('2'), PlayingCard.new('J'), PlayingCard.new('J')] }
  let(:deck) { PlayerHand.new(deck_cards) }

  it 'should return a 2 when 1 is in the deck' do
    found_cards = deck.take_cards_by_rank('2')
    expect(found_cards.count).to eq 1
    expect(found_cards[0].rank).to eq '2'
  end

  it 'should return both Js in the deck' do
    found_cards = deck.take_cards_by_rank('J')
    expect(found_cards.count).to eq 2
    expect(found_cards[0].rank).to eq 'J'
    expect(found_cards[1].rank).to eq 'J'
  end
end
