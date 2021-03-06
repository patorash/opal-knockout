module Knockout
  module ObservableArray

    def size
      self.to_a.size
    end

    def to_a
      self.call
    end

    def push(item)
      `#{self}.push(#{item})`
    end
    
    def pop
      `#{self}.pop()`
    end

    def shift
      `#{self}.shift()`
    end

    def reverse
      `#{self}.reverse()`
    end

    def remove(item)
      if item.is_a? Array
        `#{self}.removeAll(#{item})`
      else
        `#{self}.remove(#{item})`
      end
    end

    def remove_if(&block)
      %x{
        #{self}.remove(function(item) {
          return #{block.call(`item`)};
        });
      }
    end

    def remove_all
      `#{self}.removeAll()`
    end

    alias_method :clear, :remove_all

    def destroy(item)
      if item.is_a? Array
        `#{self}.destroyAll(#{item})`
      else
        `#{self}.destroy(#{item})`
      end
    end

    def destroy_if(&block)
      %x{
        #{self}.destroy(function(item) {
          return #{block.call(`item`)};
        });
      }
    end

    def destroy_all
      `#{self}.destroyAll()`
    end

    def index_of(str)
      `#{self}.indexOf(#{str})`
    end

    def slice(_start=0, _end=nil)
      if _end.nil?
        `#{self}.slice(#{_start})`
      else
        `#{self}.slice(#{_start}, #{_end})`
      end
    end
  end
end