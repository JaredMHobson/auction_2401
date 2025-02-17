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

  describe '#item_names' do
    it 'can list the names of all its items' do
      auction.add_item(item1)

      expect(auction.item_names).to eq(['Chalkware Piggy Bank'])

      auction.add_item(item2)

      expect(auction.item_names).to eq(['Chalkware Piggy Bank', 'Bamboo Picture Frame'])
    end
  end
end

describe '5 items and 3 attendees' do 
  let (:item1) { Item.new('Chalkware Piggy Bank') }
  let (:item2) { Item.new('Bamboo Picture Frame') }
  let (:item3) { Item.new('Homemade Chocolate Chip Cookies') }
  let (:item4) { Item.new('2 Days Dogsitting') }
  let (:item5) { Item.new('Forever Stamps') }
  let (:attendee1) { Attendee.new({name: 'Megan', budget: '$50'}) }
  let (:attendee2) { Attendee.new({name: 'Bob', budget: '$75'}) }
  let (:attendee3) { Attendee.new({name: 'Mike', budget: '$100'}) }
  let (:auction) { Auction.new }

  describe '#unpopular_items' do
    it 'can return an array of items that have no bids' do
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)

      expect(auction.unpopular_items).to eq([item1, item2, item3, item4, item5])

      item1.add_bid(attendee2, 20)

      expect(auction.unpopular_items).to eq([item2, item3, item4, item5])

      item1.add_bid(attendee1, 22)

      expect(auction.unpopular_items).to eq([item2, item3, item4, item5])

      item4.add_bid(attendee3, 50)

      expect(auction.unpopular_items).to eq([item2, item3, item5])
    end
  end

  describe '#potential_revenue' do
    it 'can return the total possible sale price of all items current highest bid' do
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)

      item1.add_bid(attendee2, 20)

      expect(auction.potential_revenue).to eq(20)

      item1.add_bid(attendee1, 22)

      expect(auction.potential_revenue).to eq(22)

      item4.add_bid(attendee3, 50)

      expect(auction.potential_revenue).to eq(72)

      item3.add_bid(attendee2, 15)

      expect(auction.potential_revenue).to eq(87)
    end
  end

  describe '#bidders' do
    it 'can list all bidders' do
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)

      item1.add_bid(attendee2, 20)

      expect(auction.bidders).to eq([attendee2])

      item1.add_bid(attendee1, 22)

      expect(auction.bidders).to eq([attendee2, attendee1])

      item4.add_bid(attendee3, 50)

      expect(auction.bidders).to eq([attendee2, attendee1, attendee3])

      item3.add_bid(attendee2, 15)

      expect(auction.bidders).to eq([attendee2, attendee1, attendee3])
    end
  end

  describe '#bidder_names' do
    it 'can list the names of all bidders' do
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)

      item1.add_bid(attendee2, 20)

      expect(auction.bidder_names).to eq(['Bob'])

      item1.add_bid(attendee1, 22)

      expect(auction.bidder_names).to eq(['Bob', 'Megan'])

      item4.add_bid(attendee3, 50)

      expect(auction.bidder_names).to eq(['Bob', 'Megan', 'Mike'])

      item3.add_bid(attendee2, 15)

      expect(auction.bidder_names).to eq(['Bob', 'Megan', 'Mike'])
    end
  end

  describe '#bidder_info' do
    it 'can return a hash of bidders with a subhash of their budget and items they have bid on' do
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)

      item1.add_bid(attendee2, 20)

      expect(auction.bidder_info).to eq({
        attendee2 => {budget: 75, items: [item1]}
      })

      item1.add_bid(attendee1, 22)

      expect(auction.bidder_info).to eq({
        attendee2 => {budget: 75, items: [item1]},
        attendee1 => {budget: 50, items: [item1]}
      })

      item4.add_bid(attendee3, 50)

      expect(auction.bidder_info).to eq({
        attendee2 => {budget: 75, items: [item1]},
        attendee1 => {budget: 50, items: [item1]},
        attendee3 => {budget: 100, items: [item4]}
      })

      item3.add_bid(attendee2, 15)

      expect(auction.bidder_info).to eq({
        attendee2 => {budget: 75, items: [item1, item3]},
        attendee1 => {budget: 50, items: [item1]},
        attendee3 => {budget: 100, items: [item4]}
      })
    end
  end
end