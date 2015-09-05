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
        case
          when names.instance_of?(Array)
            names.each { |name| define_observable_accessor(name) }
          when names.instance_of?(String) || names.instance_of?(Symbol)
            define_observable_accessor(names)
          else
            # TODO: 例外
        end
      end

      def attr_observable_array(*names)
        case
          when names.instance_of?(Array)
            names.each { |name| define_observable_array_accessor(name) }
          when names.instance_of?(String) || names.instance_of?(Symbol)
            define_observable_array_accessor(names)
          else
            # TODO: 例外
        end
      end

      def attr_computed(name, method_name=nil, &block)
        # TODO: 例外
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
        self._observables ||= []
        self._observables << name

        define_method name do
          instance_variable_get(:"@#{name}").to_n
        end

        define_method "#{name}=" do |value|
          observable = instance_variable_get(:"@#{name}")
          observable.set(value)
        end
      end

      def define_observable_array_accessor(name)
        attr_reader name
        self._observable_arrays ||= []
        self._observable_arrays << name

        define_method "#{name}=" do |val|
          observable_array = instance_variable_get(:"@#{name}")
          observable_array.set(val)
          self
        end
      end
    end

    # def computed(&block)
    #   Knockout::Computed.new{ block.call }
    # end

    private
      def before_initialize
        puts "before initialize"
        set_observables
        set_observable_arrays
      end

      def after_initialize
        puts "after initialize"
        set_computed_variables
      end

      def set_observables
        (self.class._observables || []).each do |name|
          instance_variable_set(:"@#{name}", Knockout::Observable.new(''))
        end
      end

      def set_observable_arrays
        (self.class._observable_arrays || []).each do |name|
          instance_variable_set(:"@#{name}", Knockout::ObservableArray.new([]))
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