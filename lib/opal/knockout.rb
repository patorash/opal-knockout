if RUBY_ENGINE == 'opal'
  require_relative 'knockout/knockout'
  require_relative 'knockout/observable'
  require_relative 'knockout/observable_array'
  require_relative 'knockout/computed'
  # require_relative 'knockout/view_model'
  # require_relative 'knockout/root_view_model'
  require_relative 'knockout/version'
else
  require 'opal'

  Opal.append_path File.expand_path('../..', __FILE__).untaint
end