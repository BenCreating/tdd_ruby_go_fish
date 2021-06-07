require_relative '../lib/player_hand'
require_relative '../lib/playing_card'
require_relative '../lib/go_fish_game'

describe 'CardDeck' do
  let(:deck_cards) { [PlayingCard.new('2'), PlayingCard.new('J'), PlayingCard.new('J')] }
  let(:deck) { PlayerHand.new(deck_cards) }

  context '#found_cards' do
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

  context 'remove card sets' do
    let(:card_set_2s) { [PlayingCard.new('2'), PlayingCard.new('2'), PlayingCard.new('2'), PlayingCard.new('2')] }
    let(:card_set_Js) { [PlayingCard.new('J'), PlayingCard.new('J'), PlayingCard.new('J'), PlayingCard.new('J')] }
    let(:card_almost_set) { [PlayingCard.new('8'), PlayingCard.new('8'), PlayingCard.new('8')] }
    let(:card_non_set) { [PlayingCard.new('3'), PlayingCard.new('7')] }

    context '#remove_card_set_and_return_score' do
      it 'removes the full set of 2 cards from the hand' do
        deck = PlayerHand.new(card_non_set + card_set_2s)
        score = deck.remove_card_set_and_return_score
        expect(score).to eq 1
        expect(deck.cards_left).to eq card_non_set.count
      end
    end

    context '#remove_set?' do
      let(:deck) { PlayerHand.new(card_set_2s + card_almost_set) }
      it 'removes a set and returns true' do
        did_remove_set = deck.remove_set?('2')
        expect(did_remove_set).to eq true
        expect(deck.cards_left).to eq 3
      end

      it 'does not remove a set and returns false' do
        did_remove_set = deck.remove_set?('8')
        expect(did_remove_set).to eq false
        expect(deck.cards_left).to eq 7
      end
    end

    context '#full_card_set?' do
      let(:deck) { PlayerHand.new(card_set_2s + card_almost_set) }
      it 'returns true for a full set' do
        deck.full_card_set?('2')
      end

      it 'returns false for a partial set' do
        deck.full_card_set?('8')
      end

      it 'returns false for a set the player has no cards for' do
        deck.full_card_set?('Q')
      end
    end
  end
end