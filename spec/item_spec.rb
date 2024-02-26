require './lib/item'
require './lib/auction'
require './lib/attendee'

RSpec.describe Item do
  describe '#initialize' do
    it 'exists' do
      expect(Item).to be_instance_of(Item)
    end
  end
end