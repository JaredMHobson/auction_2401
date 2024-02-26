require './lib/item'
require './lib/auction'
require './lib/attendee'

RSpec.describe Auction do
  let (:item1) { Item.new('Chalkware Piggy Bank') }
  let (:item2) { Item.new('Bamboo Picture Frame') }
  let (:attendee) { Attendee.new({name: 'Megan', budget: '$50'}) }
  let (:auction) { Auction.new }

  describe '#initialize' do
    it 'exists' do
      expect(auction).to be_instance_of(Auction)
    end

    it 'has no items by default' do
      expect(auction.items).to eq([])
    end
  end

  describe '#add_item' do
    it 'can add items to its array of items' do
      auction.add_item(item1)

      expect(auction.items).to eq([item1])

      auction.add_item(item2)

      expect(auction.items).to eq([item1, item2])
    end
  end
end