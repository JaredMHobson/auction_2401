require './lib/item'
require './lib/auction'
require './lib/attendee'

RSpec.describe Auction do
  describe '#initialize' do
    it 'exists' do
      expect(Auction).to be_instance_of(Auction)
    end
  end
end