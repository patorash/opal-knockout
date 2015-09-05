# for 0.7.x
#= require opal
#= require knockoutjs
#= require opal-knockout
#= require_tree .
#= require_self


user_list_view_model = UserListViewModel.new
$root_view_model = Knockout::RootViewModel.new(
    user: UserViewModel.new('Bob', 25),
    user_form_view_model: UserFormViewModel.new(user_list_view_model),
    user_list_view_model: user_list_view_model
)
Knockout.apply_bindings($root_view_model)