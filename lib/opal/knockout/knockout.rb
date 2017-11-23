require 'forwardable'
require 'native'

module Knockout
  extend SingleForwardable
  @instance = Native(`ko`)
  class << @instance
    include Native
    alias_native :apply_bindings, :applyBindings
    alias_native :clean_node, :cleanNode
    alias_native :ovservable_array, :observableArray
    alias_native :pure_computed, :pureComputed
  end

  self.def_delegators :@instance, :apply_bindings, :observable
end