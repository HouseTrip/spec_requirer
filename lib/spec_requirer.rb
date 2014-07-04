require 'spec_requirer/version'
require 'spec_requirer/configuration'
require 'spec_requirer/loader'

module SpecRequirer
  def self.setup
    container = Module.new do
      def respond_to?(method_name)
        [:uses_models, :require_model].include?(method_name) || super
      end

      def uses_models
        Loader.instance.uses_models
      end

      def require_model(name)
        Loader.instance.require_model(name)
      end
    end

    Kernel.extend(container)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
