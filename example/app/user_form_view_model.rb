class UserFormViewModel < Knockout::ViewModel
  attr_observable :name, :age
  attr_computed :data, :show_data

  def initialize
    # self.name = 'patorash'
    self.age = 0
  end

  def add_user_list
    puts "Hello"
  end

  def increment_age
    self.age = self.age.to_i if self.age.is_a?(String)
    self.age += 1
  end

  private
  def show_data
    "#{name}さんは#{age}歳"
  end
end