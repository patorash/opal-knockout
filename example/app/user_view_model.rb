class UserViewModel < Knockout::ViewModel
  attr_observable :name, :age
  attr_observable_array :items

  def initialize(name: nil, age: nil)
    self.name = name
    self.age = age
    self.items = (1..10).map {|i| Item.new("title_#{i}", i*1000, Time.new(2015,9,i)) }
    # 10.times { |i| self.items.push(Item.new("title_#{i}", i*1000, Time.new(2015,9,i))) }
    # self.items.pop()
    # self.items = self.items.reverse
    self.items.remove_if do |item|
      item.price < 3000
    end
    items = self.items.to_a.first(3)
    self.items.remove(items)
    self.items.reverse
  end
end