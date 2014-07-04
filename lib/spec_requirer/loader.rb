module SpecRequirer
  class Loader

    def uses_models
      add_to_load_path(app_root.join('models'))
    end

    def require_model(name)
      require app_root.join('models', name.to_s)
    end

    private

    def app_root
      SpecRequirer.configuration.app_root
    end

    def add_to_load_path(path)
      path = path.to_s
      $LOAD_PATH.unshift path unless $LOAD_PATH.include?(path)
    end
  end
end
