class UserFormViewModel < Knockout::ViewModel
  attr_observable :name, :age
  attr_computed :data, :show_data

  def initialize
    # self.name = 'patorash'
    self.age = 0
  end

  def add_user_list

    list = `app_view_model.user_list_view_model`
    list.users.push(User.new(self.name.to_s, self.age.to_s))
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