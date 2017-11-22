# require 'bundler'
# Bundler.require

require 'opal/rspec'
require 'opal-jquery'
require 'opal-knockout'
require 'opal/knockout/rspec'

Opal.append_path File.expand_path('../spec', __FILE__)

sprockets_env = Opal::RSpec::SprocketsEnvironment.new

run Opal::Server.new(sprockets: sprockets_env) { |s|
  s.main = 'opal/rspec/sprockets_runner'
  sprockets_env.add_spec_paths_to_sprockets
  s.append_path 'spec'
  s.debug = false
  s.index_path = 'spec/knockout/index.html.erb'
}