module SpecRequirer
  class Loader < Module

    def initialize(configuration)
      @configuration = configuration || SpecRequirer.configuration
      define_methods
    end

    def included(receiver)
      super
      receiver.send :include, Methods
    end

    def define_methods
      @configuration.components.each do |component|
        define_method "utilizes_#{component}" do
          utilizes(component)
        end

        define_method "require_#{component}" do |*names|
          names.each do |name|
            require app_root.join(component, name.to_s).to_s
          end
        end
      end
    end

    module Methods
      def utilizes(*components)
        components.each do |component|
          add_to_load_path(app_root.join(component.to_s))
        end
      end

      private

      def app_root
        configuration.app_root
      end

      def configuration
        SpecRequirer.configuration
      end

      def add_to_load_path(path)
        path = path.to_s
        $LOAD_PATH.unshift path unless $LOAD_PATH.include?(path)
      end
    end
  end
end
