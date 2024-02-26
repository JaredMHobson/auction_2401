class Auction
  attr_reader :items

  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
  end

  def item_names
    @items.reduce([]) do |names, item|
      names << item.name
    end
  end

  def unpopular_items
    @items.select do |item|
      item.bids.empty?
    end
  end

  def potential_revenue
    @items.reduce(0) do |revenue, item|
      revenue += item.current_high_bid.to_i
    end
  end

  def bidders
    @items.flat_map do |item|
      item.list_all_bidders
    end.uniq
  end

  def bidder_names
    bidders.map do |bidder|
      bidder.name
    end
  end

  def bidder_info
    bidders_and_their_bidding_info = Hash.new { |hash, key| hash[key] = {} }
    bidders.each do |attendee|
      bidders_and_their_bidding_info[attendee] = attendee.bidding_info
    end
    bidders_and_their_bidding_info
  end
end