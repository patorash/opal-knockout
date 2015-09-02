class UserViewModel
  include Knockout::ViewModel

  attr_observable :name, :age

  def initialize(name: nil, age: nil)
    self.name = name
    self.age = age
  end
end