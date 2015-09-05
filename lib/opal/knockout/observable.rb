module Knockout
  class Observable

    def initialize(value=nil)
      @native = `ko.observable()`
      set(value) unless value.nil?
    end

    def to_s
      # `#@native`
      get_value
    end

    def to_n
      @native
    end

    def get_value()
      `#@native()`
    end

    def set(val)
      `#@native(#{val})`
    end

    def +(val)
      get_value.to_n.+(val)
    end

    def -(val)
      get_value.to_n.-(val)
    end
  end
end