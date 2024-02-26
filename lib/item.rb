class Item
  attr_reader :name, :bids

  def initialize(name)
    @name = name
    @bids = {}
  end

  def add_bid(attendee, bid_amount)
    @bids[attendee] = bid_amount
  end

  def current_high_bid
    @bids.values.max
  end

  def list_all_bidders
    @bids.keys.reduce([]) do |names, bidder|
      names << bidder.name
    end
  end
end