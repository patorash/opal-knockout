require 'jquery'
require 'knockoutjs'
require 'opal'
require 'opal-jquery'
require 'opal-knockout'

# user_list_view_model = UserListViewModel.new
# $root_view_model = Knockout::RootViewModel.new(
#     user: UserViewModel.new('Bob', 25),
#     user_form_view_model: UserFormViewModel.new(user_list_view_model),
#     user_list_view_model: user_list_view_model
# )

# root_node = Native(`document.getElementsByTagName('body')[0]`)
# Knockout.apply_bindings($root_view_model, root_node)
# Knockout.apply_bindings($root_view_model)

# validation_config = {
#     insertMessages: false,
# }
# Knockout.apply_bindings_with_validation($root_view_model, validation_config)
Document.ready? do
  baz = Knockout::Observable.new("baz")
  computed_baz = Knockout::ComputedObservable.new do
    "Hello #{baz.to_s}!"
  end
  array = [
      {name: 'Bob', age: 23},
      {name: 'Tom', age: 24},
      {name: 'Aran', age: 25},
      {name: 'Taro', age: 26},
      {name: 'Kim', age: 27},
  ]
  user_list = Knockout::ObservableArray.new(array)

  Knockout.apply_bindings(
      foo: 'bar',
      baz: baz,
      computed_baz: computed_baz,
      user_list: user_list
  )

  # Knockout.apply_bindings(foo: 'bar')
end
