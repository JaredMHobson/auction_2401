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
    it 'can list all of its bidders names' do
      item1.add_bid(attendee3, 18)
      
      expect(item1.list_all_bidders).to eq(['Mike'])
      
      item1.add_bid(attendee1, 22)
      
      expect(item1.list_all_bidders).to eq(['Mike', 'Megan'])
      
      item1.add_bid(attendee2, 20)

      expect(item1.list_all_bidders).to eq(['Mike', 'Megan', 'Bob'])
    end
  end
end