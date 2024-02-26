class Item
  attr_reader :name, :bids

  def initialize(name)
    @name = name
    @bids = {}
    @bidding_open = true
  end

  def add_bid(attendee, bid_amount)
    if bidding_open?
      attendee.bid_on(self)
      @bids[attendee] = bid_amount
    end
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

  def bidding_open?
    @bidding_open
  end

  def close_bidding
    @bidding_open = false
  end
end