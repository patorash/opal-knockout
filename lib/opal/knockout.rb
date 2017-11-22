if RUBY_ENGINE == 'opal'
  # require_relative 'opal/knockout/observable'
  # require_relative 'opal/knockout/observable_array'
  # require_relative 'opal/knockout/computed'
  # require_relative 'opal/knockout/view_model'
  # require_relative 'opal/knockout/root_view_model'
  require_relative 'knockout/knockout'
  require_relative 'knockout/version'
else
  require 'opal'

  Opal.append_path File.expand_path('../..', __FILE__).untaint
end