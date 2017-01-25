class Item
  attr_accessor :name, :code, :price
  def initialize(name, code, price)
    @name = name
    @code = code
    @price = price
  end

  def get_price
    @price
  end

end

fruit_tea = Item.new("fruit tea", "FR1", 311)
strawberry = Item.new("strawberry", "SR1", 500)
coffee = Item.new("coffee", "SR1", 1123)

puts fruit_tea.get_price
