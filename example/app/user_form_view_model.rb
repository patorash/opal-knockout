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
    if self.age.get_value.is_a? Integer
      self.age += 1
    else
      self.age = self.age.get_value.to_i + 1
    end
  end

  private
  def show_data
    "#{name}さんは#{age}歳"
  end
end