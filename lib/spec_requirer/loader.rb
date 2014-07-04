module SpecRequirer
  class Loader

    def initialize(configuration)
      @configuration = configuration || SpecRequirer.configuration
    end

    def uses_models
      add_to_load_path(app_root.join('models'))
    end

    def require_model(name)
      require app_root.join('models', name.to_s).to_s
    end

    private

    attr_reader :configuration

    def app_root
      configuration.app_root
    end

    def add_to_load_path(path)
      path = path.to_s
      $LOAD_PATH.unshift path unless $LOAD_PATH.include?(path)
    end
  end
end
