require 'bundler'
Bundler.require

run Opal::Server.new { |s|
  RailsAssets.load_paths.each { |p| s.append_path p }
  s.append_path 'app'
  s.main = 'application'
  s.debug = true
  s.index_path = 'index.html.erb'
}