require 'native'

module Knockout
  module ModuleMethods
    def apply_bindings(view_model, element=nil)
      if element.nil?
        `ko.applyBindings(#{view_model.to_n})`
      else
        `ko.applyBindings(#{view_model.to_n}, #{element})`
      end
    end
  end

  extend ModuleMethods
end