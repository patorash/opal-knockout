require 'delegate'

module Knockout
  class Observable < Delegator
    def initialize(value, options={})
      observable = `ko.observable()`
      observable.call(value)
      `#{observable.to_n}.extend(options)` unless options.empty?
      super(observable)
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
