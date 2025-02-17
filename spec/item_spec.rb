require './lib/item'
require './lib/auction'
require './lib/attendee'

RSpec.describe Item do
  let (:item1) { Item.new('Chalkware Piggy Bank') }
  let (:item2) { Item.new('Bamboo Picture Frame') }
  let (:item3) { Item.new('Homemade Chocolate Chip Cookies') }
  let (:item4) { Item.new('2 Days Dogsitting') }
  let (:item5) { Item.new('Forever Stamps') }
  let (:attendee1) { Attendee.new({name: 'Megan', budget: '$50'}) }
  let (:attendee2) { Attendee.new({name: 'Bob', budget: '$75'}) }
  let (:attendee3) { Attendee.new({name: 'Mike', budget: '$100'}) }
  let (:auction) { Auction.new }

  describe '#initialize' do
    it 'exists' do
      expect(item1).to be_instance_of(Item)
    end

    it 'has a name' do
      expect(item1.name).to eq('Chalkware Piggy Bank')
    end

    it 'has no bids by default' do
      expect(item1.bids).to eq({})
    end
  end

  describe '#add_bid' do 
    it 'can add bids to itself' do
      item1.add_bid(attendee2, 20)

      expect(item1.bids).to eq({attendee2 => 20})

      item1.add_bid(attendee1, 22)

      expect(item1.bids).to eq({attendee2 => 20, attendee1 => 22})
    end

    it 'cannot add a bid if bidding is closed' do
      item1.add_bid(attendee2, 20)

      expect(item1.bids).to eq({attendee2 => 20})

      item1.close_bidding

      item1.add_bid(attendee1, 22)

      expect(item1.bids).to eq({attendee2 => 20})
    end
  end

  describe '#current_high_bid' do
    it 'can return the current highest bid amount' do
      item1.add_bid(attendee2, 20)

      expect(item1.current_high_bid).to eq(20)

      item1.add_bid(attendee1, 22)

      expect(item1.current_high_bid).to eq(22)

      item1.add_bid(attendee3, 18)

      expect(item1.current_high_bid).to eq(22)
    end
  end

  describe '#list_all_bidders' do
    it 'can list all of its bidders' do
      item1.add_bid(attendee3, 18)
      
      expect(item1.list_all_bidders).to eq([attendee3])
      
      item1.add_bid(attendee1, 22)
      
      expect(item1.list_all_bidders).to eq([attendee3, attendee1])
      
      item1.add_bid(attendee2, 20)

      expect(item1.list_all_bidders).to eq([attendee3, attendee1, attendee2])
    end
  end

  describe '#list_all_bidder_names' do
    it 'can list all of its bidders names' do
      item1.add_bid(attendee3, 18)
      
      expect(item1.list_all_bidder_names).to eq(['Mike'])
      
      item1.add_bid(attendee1, 22)
      
      expect(item1.list_all_bidder_names).to eq(['Mike', 'Megan'])
      
      item1.add_bid(attendee2, 20)

      expect(item1.list_all_bidder_names).to eq(['Mike', 'Megan', 'Bob'])
    end
  end

  describe '#bidding_open' do
    it 'is open to bidding by default' do
      expect(item1.bidding_open?).to be true
    end

    it 'can close its bidding' do
      item1.close_bidding

      expect(item1.bidding_open?).to be false
    end

    it 'will return a string of how much the item was sold for when closed' do
      item1.add_bid(attendee2, 20)

      expect(item1.close_bidding).to eq('Sold for $20 dollars!')
    end

    it 'will return a specific string if there were no bids on the item when closed' do
      expect(item1.bids).to be_empty

      expect(item1.close_bidding).to eq('No sale! Come back next week for another chance.')
    end
  end
end