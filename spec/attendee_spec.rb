require './lib/item'
require './lib/auction'
require './lib/attendee'

RSpec.describe Attendee do
  describe '#initialize' do
    it 'exists' do
      expect(Attendee).to be_instance_of(Attendee)
    end
  end
end