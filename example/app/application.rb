# for 0.7.x
#= require opal
#= require knockoutjs
#= require opal-knockout
#= require_tree .
#= require_self

user_view_model = UserViewModel.new('Bob', 25)
`var app_view_model = { user: #{user_view_model} };`
Knockout.apply_bindings(`app_view_model`)
