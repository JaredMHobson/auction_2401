class Item
  attr_reader :name, :bids

  def initialize(name)
    @name = name
    @bids = {}
  end

  def add_bid(attendee, bid_amount)
    attendee.bid_on(self)
    @bids[attendee] = bid_amount
  end

  def current_high_bid
    @bids.values.max
  end

  def list_all_bidders
    @bids.keys
  end

  def list_all_bidder_names
    list_all_bidders.map do |bidder|
      bidder.name
    end
  end
end