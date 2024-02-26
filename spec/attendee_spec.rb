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
  end
end