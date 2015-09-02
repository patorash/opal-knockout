#= require opal
#= require knockoutjs
#= require opal-knockout
#= require_tree .
#= require_self

user_view_model = UserViewModel.new(name: 'Bob', age: 25)
%x{
  app_view_model = { user: #{user_view_model}};
  ko.applyBindings(app_view_model);
}
