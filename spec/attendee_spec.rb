require './lib/item'
require './lib/auction'
require './lib/attendee'

RSpec.describe Attendee do
  let (:item1) { Item.new('Chalkware Piggy Bank') }
  let (:item2) { Item.new('Bamboo Picture Frame') }
  let (:attendee) { Attendee.new({name: 'Megan', budget: '$50'}) }

  describe '#initialize' do
    it 'exists' do
      expect(attendee).to be_instance_of(Attendee)
    end

    it 'has a name' do
      expect(attendee.name).to eq('Megan')
    end

    it 'has a budget' do
      expect(attendee.budget).to eq(50)
    end

    it 'has not bidded on any items by default' do
      expect(attendee.items_bid_on).to eq([])
    end
  end

  describe '#bid_on' do
    it 'can bid on an item and store it in its items array' do
      attendee.bid_on(item1)

      expect(attendee.items_bid_on).to eq([item1])

      attendee.bid_on(item2)

      expect(attendee.items_bid_on).to eq([item1, item2])
    end
  end

  describe '#bidding_info' do
    it 'can return a hash with its budget and items bid on' do
      attendee.bid_on(item1)

      expect(attendee.bidding_info).to eq({budget: 50, items: [item1]})

      attendee.bid_on(item2)

      expect(attendee.bidding_info).to eq({budget: 50, items: [item1, item2]})
    end
  end
end