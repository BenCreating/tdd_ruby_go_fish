require_relative '../lib/go_fish_player'
require_relative '../lib/playing_card'
require_relative '../lib/player_hand'

describe 'GoFishPlayer' do
  it 'creates a player without specifying attributes' do
    player = GoFishPlayer.new
    expect(player.name).not_to be_nil
    expect(player.card_count).to eq 0
  end

  it 'creates a player with specified attributes' do
    player = GoFishPlayer.new(name: 'Alice', cards: PlayerHand.new([PlayingCard.new]))
    expect(player.name).to eq 'Alice'
    expect(player.card_count).to eq 1
    player2 = GoFishPlayer.new(name: 'Bob', cards: PlayerHand.new([PlayingCard.new, PlayingCard.new]))
    expect(player2.name).to eq 'Bob'
    expect(player2.card_count).to eq 2
  end

  it 'adds a card to the hand' do
    player = GoFishPlayer.new()
    player.pick_up_card(PlayingCard.new)
    expect(player.card_count).to eq 1
  end

  context '#give_cards' do
    let(:player) { GoFishPlayer.new(cards: PlayerHand.new([PlayingCard.new('2'), PlayingCard.new('J'), PlayingCard.new('3')])) }
    it 'returns an array with 1 card when the player only has one card of a specified rank' do
      cards = player.give_cards_by_rank('2')
      expect(cards.count).to eq 1
    end
  end

  context '#take_from' do
    let(:player_1_cards) { [PlayingCard.new('3'), PlayingCard.new('8')] }
    let(:player_2_cards) { [PlayingCard.new('5'), PlayingCard.new('5')] }
    let(:player_1) { GoFishPlayer.new(cards: PlayerHand.new(player_1_cards)) }
    let(:player_2) { GoFishPlayer.new(cards: PlayerHand.new(player_2_cards)) }

    it 'asks player 2 for, and recieves, both 5s' do
      taken_cards = player_1.take_from(player_2, '5')
      expect(taken_cards[0].rank).to eq '5'
      expect(taken_cards[1].rank).to eq '5'
      expect(player_1.card_count).to eq 4
    end

    it 'asks player 1 for, and recieves, the 3' do
      taken_cards = player_2.take_from(player_1, '3')
      expect(taken_cards[0].rank).to eq '3'
      expect(player_2.card_count).to eq 3
    end
  end
end
