# for 0.7.x
#= require opal
#= require knockoutjs
#= require opal-knockout
#= require_tree .
#= require_self


user_view_model = UserViewModel.new('Bob', 25)
Knockout.apply_bindings(user: user_view_model)

