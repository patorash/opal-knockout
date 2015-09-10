require 'bundler'
Bundler.require

require 'opal-rspec'
require 'opal-jquery'
Opal.append_path File.expand_path('../spec', __FILE__)

run Opal::Server.new { |s|
  s.main = 'opal/rspec/sprockets_runner'
  s.append_path 'spec'
  s.debug = false
  s.index_path = 'spec/knockout/index.html.erb'
}