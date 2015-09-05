module Knockout
  class Observable

    def initialize(value=nil)
      @native = `ko.observable()`
      set(value) unless value.nil?
    end

    def to_s
      @native.call.to_s
    end

    def to_n
      @native
    end

    def get_value()
      @native.call
    end

    def set(value)
      @native.call(value)
    end

    def +(value)
      get_value.to_n.+(value)
    end

    def -(value)
      get_value.to_n.-(value)
    end
  end
end