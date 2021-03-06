if RUBY_ENGINE == 'opal'
  require 'opal/knockout/observable'
  require 'opal/knockout/observable_array'
  require 'opal/knockout/computed'
  require 'opal/knockout/view_model'
  require 'opal/knockout/root_view_model'
  require 'opal/knockout/knockout'
else
  require 'opal'
  require 'opal/knockout/version'

  Opal.append_path File.expand_path('../..', __FILE__).untaint
end