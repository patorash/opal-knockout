require 'native'

module Knockout
  module ModuleMethods
    def apply_bindings(view_model, element=nil)
      `ko.applyBindings(#{binding_view_model(view_model).to_n}, #{element.to_n})`
    end

    def clean_node(element=nil)
      element ||= Native(`document.body`)
      `ko.cleanNode(#{element.to_n})`
    end

    def apply_bindings_with_validation(view_model, element=nil, options=nil)
      `ko.applyBindingsWithValidation(#{binding_view_model(view_model).to_n}, #{element.to_n}, #{options.to_n})`
    end

    def binding_view_model(vm)
      vm.is_a?(Knockout::RootViewModel) ? vm.view_models : vm
    end

    def validation_locale(locale)
      `ko.validation.locale(#{locale})`
    end
  end

  extend ModuleMethods
end