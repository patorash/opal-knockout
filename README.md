# opal-knockout: Knockout.js wrapper for Opal

opal-konckout is wraper of knockout.js.

## Installation

Add this line to your application's Gemfile:

    gem 'opal-knockout'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install opal-knockout

## Usage(Rails)

### Gemfile

```ruby:Gemfile
source 'https://rubygems.org'

gem 'opal-knockout'

source 'https://rails-assets.org' do
  gem 'rails-assets-knockoutjs', '3.3.0'
end
```

### Opal

app/assets/javascripts/user_view_model.rb

```ruby:assets/javascripts/user_view_model.rb
class User
  attr_accessor :first_name, :last_name
  
  def initialize(first_name, last_name)
    self.first_name = first_name
    self.last_name = last_name
  end
end

class UserViewModel < Knockout::ViewModel
  attr_observable :first_name, :last_name
  attr_observable_array :users
  attr_computed :full_name, :show_full_name
  
  def initialize(first_name, last_name)
    self.first_name = first_name
    self.last_name = last_name
  end
  
  def add_users
    self.users.push(User.new(
                      self.first_name.to_s,
                      self.last_name.to_s
                    )
    )
    clear_form
  end
  
  private
  def show_full_name
    "#{first_name.to_s} #{last_name.to_s}"
  end
  
  def clear_form
    self.first_name = ''
    self.last_name = ''
  end
end
```

app/assets/javascripts/application.rb


```ruby:assets/javascripts/application.rb
#= require opal
#= require knockoutjs
#= require opal-knockout
#= require_tree .
#= require_self

$root_view_model = Knockout::RootViewModel.new(
    user: UserViewModel.new('Taro', 'Yamada')
)
Knockout.apply_bindings($root_view_model)
```

### View

app/views/users/index.html.slim

```slim:views/users/index.html.slim
div data-bind="with: user"
  form
    label
      | First Name
    input type="text" data-bind="textInput: first_name"
    br
    label
      | Last Name
    input type="text" data-bind="textInput: last_name"
    p data-bind="text: full_name"
    button type="button" data-bind="click: $add_users"

  ul data-bind="foreach: users"
    li
      span data-bind="text: first_name"
      | &nbsp;
      span data-bind="text: last_name"
  
```

## Contributing

1. Fork it ( https://github.com/patorash/opal-knockout/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
