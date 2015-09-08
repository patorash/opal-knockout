class UserFormViewModel < Knockout::ViewModel
  attr_observable :name, :age
  attr_computed :data, :show_data

  validates :name, required: { only_if: Proc.new { puts self.age.call; self.age.to_s.to_i < 20 } }
  validates :age, required: true, number: true

  def initialize(list_view_model)
    @list_view_model = list_view_model
    self.name = ''
    self.age = 0
  end

  def add_user_list
    @list_view_model.users.push(User.new(self.name.to_s, self.age.to_s))
    clear_form
  end

  def increment_age
    if self.age.call.is_a? Integer
      # self.age += 1
      self.age = self.age.call + 1
    else
      self.age = self.age.call.to_i + 1
    end
  end

  private
  def show_data
    "#{name.to_s}さんは#{age.to_s}歳"
  end

  def clear_form
    self.name = ''
    self.age = 0
  end
end