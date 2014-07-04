require 'spec_requirer/version'
require 'spec_requirer/configuration'
require 'spec_requirer/loader'

begin
  require 'pry'
rescue LoadError
end

module SpecRequirer
  def self.setup(config_options = {})

    config_options.each do |k,v|
      configuration.send("#{k}=", v)
    end

    container = Module.new do
      def respond_to?(method_name)
        [:uses_models, :require_model].include?(method_name) || super
      end

      def uses_models
        __loader.uses_models
      end

      def require_model(name)
        __loader.require_model(name)
      end

      private

      def __loader
        @loader ||= Loader.new
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
