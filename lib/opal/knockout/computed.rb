require 'delegate'

module Knockout
  class ComputedObservable < Delegator
    def initialize(&block)
      super(`ko.computed`.call(block))
    end

    def to_s
      __getobj__.call
    end

    def __getobj__
      @native
    end

    def __setobj__(obj)
      @native = obj
    end
  end
end