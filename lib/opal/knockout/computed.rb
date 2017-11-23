require 'delegate'

module Knockout
  class ComputedObservable < SimpleDelegator
    def initialize(&block)
      super(`ko.computed`.call(block))
    end

    def to_s
      __getobj__.call
    end
  end
end