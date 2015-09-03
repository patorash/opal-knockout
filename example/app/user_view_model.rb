class UserViewModel < Knockout::ViewModel
  attr_observable :name, :age
  attr_observable_array :items, :words
  attr_accessor :hoge

  def initialize(name=nil, age=nil)
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
    self.items.push(Item.new("abcde", 4000, Time.new(2015,9,3)))
    self.words = %w(abcde fghij klmno)
    self.hoge = `ko.computed(function(){ return #{self.words.index_of("fghij")} }, this)`
  end

  def increment_age
    self.age += 1
  end

  def decrement_age
    self.age -= 1
  end
end