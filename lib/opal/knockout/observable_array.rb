module Knockout
  class ObservableArray

    def initialize(array=nil)
      # なぜか@dataじゃないと動かない…。
      @data = `ko.observableArray()`
      self.set(array) unless array.nil?
    end

    def to_n
      @data
    end

    def to_a
      `#@data()`
    end

    def set(val)
      `#@data(#{val})`
    end

    def push(item)
      `#@data.push(#{item})`
    end

    def pop
      `#@data.pop()`
    end

    def shift
      `#@data.shift()`
    end

    def reverse
      `#@data.reverse()`
    end

    def remove(item)
      if item.is_a? Array
        `#@data.removeAll(#{item})`
      else
        `#@data.remove(#{item})`
      end
    end

    def remove_if(&block)
      %x{
        #@data.remove(function(item) {
          return #{block.call(`item`)};
        });
      }
    end

    def remove_all
      `#@data.removeAll()`
    end

    alias_method :clear, :remove_all

    def destroy(item)
      if item.is_a? Array
        `#@data.destroyAll(#{item})`
      else
        `#@data.destroy(#{item})`
      end
    end

    def destroy_if(&block)
      %x{
        #@data.destroy(function(item) {
          return #{block.call(`item`)};
        });
      }
    end

    def destroy_all
      `#@data.destroyAll()`
    end
  end
end