class Item
  attr_reader :title, :price, :created_at

  def initialize(title, price, created_at)
    @title = title
    @price = price
    @created_at = created_at
  end
end