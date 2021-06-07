require_relative '../lib/shuffling_deck'

describe 'ShufflingDeck' do
  let(:deck) { ShufflingDeck.new }

  def get_all_deck_card_ranks(deck)
    card_ranks = []
    while deck.cards_left > 0
      card_ranks << deck.deal.rank
    end
    card_ranks
  end

  it 'should shuffle the deck' do
    # There is a tiny chance that a shuffled deck will equal an unshuffled one
    deck_shuffled = ShufflingDeck.new
    deck_shuffled.shuffle
    shuffled_card_ranks = get_all_deck_card_ranks(deck_shuffled)
    unshuffled_card_ranks = get_all_deck_card_ranks(deck)
    expect(shuffled_card_ranks.count).to eq 52
    expect(unshuffled_card_ranks.count).to eq 52
    expect(shuffled_card_ranks).not_to eq unshuffled_card_ranks
  end
end
