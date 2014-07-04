require 'singleton'

module SpecRequirer
  class Loader
    include Singleton

    def uses_models
      add_to_load_path(app_root.join('models'))
    end

    def require_model(name)
      require app_root.join('models', name.to_s)
    end

    private

    # needs a configuration option
    def app_root
      Pathname(File.dirname(__FILE__))
    end

    def add_to_load_path(path)
      $LOAD_PATH.unshift path unless $LOAD_PATH.include?(path)
    end
  end
end
