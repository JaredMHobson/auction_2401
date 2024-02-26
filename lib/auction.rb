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
end