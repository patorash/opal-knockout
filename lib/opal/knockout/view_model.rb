module Knockout
  class ViewModel
    class << self
      def attr_observable(*names)
        case
          when names.instance_of?(Array)
            names.each { |name| define_observable_accessor(name) }
          when names.instance_of?(String) || names.instance_of?(Symbol)
            define_observable_accessor(names)
          else
            raise_error
        end
      end

      def attr_observable_array(*names)
        case
          when names.instance_of?(Array)
            names.each { |name| define_observable_array_accessor(name) }
          when names.instance_of?(String) || names.instance_of?(Symbol)
            define_observable_array_accessor(names)
          else
            raise_error
        end
      end

      private
      def define_observable_accessor(name)
        define_method name do
          instance_variable_set(:"@#{name}", Knockout::Observable.new) unless instance_variable_defined?(:"@#{name}")
          instance_variable_get(:"@#{name}")
        end

        define_method "#{name}=" do |val|
          instance_variable_set(:"@#{name}", Knockout::Observable.new) unless instance_variable_defined?(:"@#{name}")
          observable = instance_variable_get(:"@#{name}")
          observable.set(val)
        end
      end

      def define_observable_array_accessor(name)
        define_method name do
          instance_variable_set(:"@#{name}", Knockout::ObservableArray.new) unless instance_variable_defined?(:"@#{name}")
          instance_variable_get(:"@#{name}")
        end

        define_method "#{name}=" do |val|
          instance_variable_set(:"@#{name}", Knockout::ObservableArray.new) unless instance_variable_defined?(:"@#{name}")
          observable_array = instance_variable_get(:"@#{name}")
          observable_array.set(val)
          self
        end
      end
    end

    def computed(&block)
      %x{
        return ko.computed(function() {
          return #{block.call};
        }, this);
      }
    end
  end
end