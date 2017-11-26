require 'delegate'

module Knockout
  class ObservableArray < SimpleDelegator

    def initialize(array, options={})
      @observable_array = array
      observable_array = `ko.observableArray()`
      observable_array.call(@observable_array.to_n)
      `#{observable_array.to_n}.extend(options)` unless options.empty?
      super(observable_array)
    end

    def size
      @observable_array.size
    end

    def to_s
      @observable_array.to_json
    end

    def to_a
      @observable_array
    end

    def [](i)
      @observable_array[i]
    end

    def push(item)
      @observable_array.push(item)
      `#{self.__getobj__}.push(#{item.to_n})`
    end

    def pop
      `#{self.__getobj__}.pop()`
      @observable_array.pop
    end

    def shift
      `#{self.__getobj__}.shift()`
      @observable_array.shift
    end

    def reverse
      @observable_array.reverse
    end

    def delete_at(i)
      @observable_array.delete_at(i)
      self.__getobj__.call(@observable_array.to_n)
    end
    alias_method :remove_at, :delete_at

    def remove_all
      @observable_array.clear
      `#{self.__getobj__}.removeAll()`
    end
    alias_method :clear, :remove_all

    def destroy(item)
      `debugger`
      true
    end

    def destroy_at(i)
      item = @observable_array[i]
      if item.is_a? Hash
        item['_destroy'] = true
      else
        item.instance_variable_set(:@_destroy, true)
      end
      @observable_array[i] = item
      # `#{self.__getobj__}[#{i}].destroy()`
      self.__getobj__.call(@observable_array.to_n)
    end

    def destroy_all
      @observable_array.each do |item|
        if item.is_a? Hash
          item['_destroy'] = true
        else
          item.instance_variable_set(:@_destroy, true)
        end
      end
      self.__getobj__.call(@observable_array.to_n)
    end

    def slice(_start=0, _end=nil)
      if _end.nil?
        `#{self.__getobj__}.slice(#{_start})`
        @observable_array.slice!(_start)
      else
        `#{self.__getobj__}.slice(#{_start}, #{_end})`
        @observable_array.slice!(_start, _end)
      end
    end
  end
end

# module Knockout
#   module ObservableArray
#
#     def size
#       self.to_a.size
#     end
#
#     def to_a
#       self.call
#     end
#
#     def push(item)
#       `#{self}.push(#{item})`
#     end
#
#     def pop
#       `#{self}.pop()`
#     end
#
#     def shift
#       `#{self}.shift()`
#     end
#
#     def reverse
#       `#{self}.reverse()`
#     end
#
#     def remove(item)
#       if item.is_a? Array
#         `#{self}.removeAll(#{item})`
#       else
#         `#{self}.remove(#{item})`
#       end
#     end
#
#     def remove_if(&block)
#       %x{
#         #{self}.remove(function(item) {
#           return #{block.call(`item`)};
#         });
#       }
#     end
#
#     def remove_all
#       `#{self}.removeAll()`
#     end
#
#     alias_method :clear, :remove_all
#
#     def destroy(item)
#       if item.is_a? Array
#         `#{self}.destroyAll(#{item})`
#       else
#         `#{self}.destroy(#{item})`
#       end
#     end
#
#     def destroy_if(&block)
#       %x{
#         #{self}.destroy(function(item) {
#           return #{block.call(`item`)};
#         });
#       }
#     end
#
#     def destroy_all
#       `#{self}.destroyAll()`
#     end
#
#     def only_destroyed
#       self.to_a.select { |item| Native(`#{item}._destroy`) }
#     end
#
#     def without_destroyed
#       self.to_a.reject { |item| Native(`#{item}._destroy`) }
#     end
#
#     def index_of(str)
#       `#{self}.indexOf(#{str})`
#     end
#
#     def slice(_start=0, _end=nil)
#       if _end.nil?
#         `#{self}.slice(#{_start})`
#       else
#         `#{self}.slice(#{_start}, #{_end})`
#       end
#     end
#   end
# end