class Attendee
  attr_reader :name, :budget, :items_bid_on

  def initialize(details)
    @name = details[:name]
    @budget = details[:budget].gsub(/\D/,'').to_i
    @items_bid_on = []
  end

  def bid_on(item)
    @items_bid_on << item
  end
end