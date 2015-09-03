module Knockout
  module ModuleMethods
    def apply_bindings(view_model, element=nil)
      if element.nil?
        `ko.applyBindings(#{view_model})`
      else
        `ko.applyBindings(#{view_model}, #{element})`
      end
    end
  end

  extend ModuleMethods
end