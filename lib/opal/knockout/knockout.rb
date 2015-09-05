require 'native'

module Knockout
  module ModuleMethods
    def apply_bindings(view_model, element=nil)
      if element.nil?
        if view_model.is_a? Knockout::RootViewModel
          `ko.applyBindings(#{view_model.view_models.to_n})`
        else
          `ko.applyBindings(#{view_model.to_n})`
        end
      else
        `ko.applyBindings(#{view_model.to_n}, #{element})`
      end
    end
  end

  extend ModuleMethods
end