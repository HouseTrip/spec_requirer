require 'spec_requirer/version'
require 'spec_requirer/configuration'
require 'spec_requirer/loader'

module SpecRequirer
  def self.setup(config_options = {})
    config_options.each { |k,v| configuration.send("#{k}=", v) }

    Object.send(:include, Loader.new(configuration))
  end

  def self.configuration
    @configuration ||= Configuration.new # TODO: thread-safe...
  end

  def self.configure
    yield(configuration)
  end
end
