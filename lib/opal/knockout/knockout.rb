require 'forwardable'
require 'native'

module Knockout
  extend SingleForwardable
  @instance = Native(`ko`)
  class << @instance
    include Native
    alias_native :apply_bindings, :applyBindings
    alias_native :clean_node, :cleanNode
  end

  self.def_delegators :@instance, :apply_bindings

  def self.to_n
    @instance.to_n
  end
end