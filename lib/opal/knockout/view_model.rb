module Knockout
  module ViewModel

    def self.included(klass)
      klass.extend ClassMethods
    end

    module ClassMethods
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
          instance_variable_get(:"@#{name}")
        end

        define_method "#{name}=" do |val|
          if instance_variable_get(:"@#{name}").nil?
            instance_variable_set(:"@#{name}", Knockout::Observable.new)
          end
          observable = instance_variable_get(:"@#{name}")
          observable.set(val)
        end
      end

      def define_observable_array_accessor(name)
        define_method name do
          observable_array = instance_variable_get(:"@#{name}")
          `#{observable_array}()` unless observable_array.nil?
        end

        define_method "#{name}=" do |val|
          if instance_variable_get(:"@#{name}").nil?
            instance_variable_set(:"@#{name}", `ko.observableArray()`)
          end
          observable_array = instance_variable_get(:"@#{name}")
          `#{observable_array}(#{val})`
          return
        end
      end
    end
  end
end