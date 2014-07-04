module SpecRequirer
  class Loader < Module

    def initialize(configuration)
      @configuration = configuration || SpecRequirer.configuration
      define_methods
    end

    def add_to_load_path(path)
      path = path.to_s
      $LOAD_PATH.unshift path unless $LOAD_PATH.include?(path)
    end

    def extended(descendant)
      super
      descendant.module_eval { extend Methods }
    end

    def define_methods
      @configuration.components.each do |component|
        define_method "uses_#{component}" do
          add_to_load_path(SpecRequirer.configuration.app_root.join(component))
        end

        define_method "require_#{component}" do |*names|
          names.each do |name|
            require SpecRequirer.configuration.app_root.join(component, name.to_s).to_s
          end
        end
      end
    end

    module Methods
      private

      def add_to_load_path(path)
        path = path.to_s
        $LOAD_PATH.unshift path unless $LOAD_PATH.include?(path)
      end
    end
  end
end
