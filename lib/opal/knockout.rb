if RUBY_ENGINE == 'opal'
  # require 'opal/knockout/observable'
else
  require 'opal'
  require 'opal/knockout/version'

  Opal.append_path File.expand_path('../..', __FILE__).untaint
end