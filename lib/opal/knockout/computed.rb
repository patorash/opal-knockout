module Knockout
  class Computed
    def initialize(&block)
      @callback = %x{
        ko.computed(function() {
          return #{block.call};
        });
      }
    end

    def to_s
      `#{@callback}()`
    end

    def to_n
      `#{@callback}`
    end
  end
end