module Knockout
  class Observable

    def initialize(value=nil)
      @data = `ko.observable(#{value})`
    end

    def to_s
      get_value
    end

    def get
      @data
    end

    def get_value()
      `#{@data}()`
    end

    def set(val)
      `#{@data}(#{val})`
    end
  end
end