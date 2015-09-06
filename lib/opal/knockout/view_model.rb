module Knockout
  class ViewModel
    class << self
      attr_accessor :_observables
      attr_accessor :_observable_arrays
      attr_accessor :_computed_methods

      def new( *args, &blk )
        object = allocate
        object.before_initialize
        object.instance_eval{ initialize( *args, &blk ) }
        object.after_initialize
        object
      end

      def attr_observable(*names)
        names.each { |name| define_observable_accessor(name) }
      end

      def attr_observable_array(*names)
        names.each { |name| define_observable_array_accessor(name) }
      end

      def attr_computed(name, method_name=nil, &block)
        raise ArgumentError, "#{self.to_s}##{__method__}: You must set method_name or block" if method_name.nil? && !block_given?
        return if method_name.nil? && !block_given?
        self._computed_methods ||= {}
        self._computed_methods[name] = if method_name.nil?
                                   block
                                 else
                                   method_name
                                 end
      end

      private
      def define_observable_accessor(name)
        raise ArgumentError, "#{self.to_s}##{__method__}: name must String or Symbol" unless name.is_a?(String) || name.is_a?(Symbol)
        self._observables ||= []
        self._observables << name

        define_method name do
          instance_variable_get(:"@#{name}")
        end

        define_method "#{name}=" do |value|
          instance_variable_get(:"@#{name}").call(value)
        end
      end

      def define_observable_array_accessor(name)
        raise ArgumentError, "#{self.to_s}##{__method__}: name must String or Symbol" unless name.is_a?(String) || name.is_a?(Symbol)
        self._observable_arrays ||= []
        self._observable_arrays << name

        define_method name do
          instance_variable_get(:"@#{name}")
        end

        define_method "#{name}=" do |value|
          instance_variable_get(:"@#{name}").call(value)
        end
      end
    end

    private
      def before_initialize
        set_observables
        set_observable_arrays
      end

      def after_initialize
        set_computed_variables
      end

      def set_observables
        (self.class._observables || []).each do |name|
          observable = `ko.observable()`
          observable.instance_eval do
            extend Knockout::Observable
          end
          instance_variable_set(:"@#{name}", observable)
        end
      end

      def set_observable_arrays
        (self.class._observable_arrays || []).each do |name|
          observable_array = `ko.observableArray()`
          observable_array.instance_eval do
            extend Knockout::ObservableArray
          end
          instance_variable_set(:"@#{name}", observable_array)
        end
      end

      def set_computed_variables
        (self.class._computed_methods || {}).each do |name, method_name|
          if method_name.is_a? Proc
            block = method_name
            instance_variable_set(:"@#{name}", Knockout::Computed.new{ self.instance_eval(&block) } )
          else
            instance_variable_set(:"@#{name}", Knockout::Computed.new{ self.method(method_name).call } )
          end
        end
      end
  end
end