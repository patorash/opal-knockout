module Knockout
  class RootViewModel
    attr_accessor :view_models

    def initialize(view_models=nil)
      self.view_models = {}
      self.add_view_models(view_models) unless view_models.nil?
    end

    def add_view_model(name, view_model)
      if name.is_a?(String || Symbol) && view_model.is_a?(Knockout::ViewModel)
        self.view_models[name] = view_model
      else
        # TODO: 例外
      end
    end

    def add_view_models(view_models)
      view_models.each do |name, view_model|
        add_view_model(name, view_model)
      end
    end

    def find_view_model_by_name(name)
      self.view_models[name]
    end

  end
end