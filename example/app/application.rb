# for 0.7.x
#= require opal
#= require active_support
#= require knockoutjs
#= require knockout-validation
#= require knockout-validation/localization/ja-JP
#= require opal-knockout
#= require_tree .
#= require_self

Knockout.validation_locale('ja-JP')

user_list_view_model = UserListViewModel.new
$root_view_model = Knockout::RootViewModel.new(
    user: UserViewModel.new('Bob', 25),
    user_form_view_model: UserFormViewModel.new(user_list_view_model),
    user_list_view_model: user_list_view_model
)
# root_node = Native(`document.getElementsByTagName('body')[0]`)
# Knockout.apply_bindings($root_view_model, root_node)
# Knockout.apply_bindings($root_view_model)
validation_config = {
    insertMessages: false,
}
Knockout.apply_bindings_with_validation($root_view_model, validation_config)
