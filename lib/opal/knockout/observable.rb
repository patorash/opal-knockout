require 'delegate'

module Knockout
  class Observable < SimpleDelegator
    def initialize(value, options={})
      observable = `ko.observable()`
      observable.call(value.to_n)
      `#{observable.to_n}.extend(options)` unless options.empty?
      super(observable)
    end

    def to_s
      __getobj__.call
    end
  end
end
