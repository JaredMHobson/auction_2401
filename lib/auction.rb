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
end