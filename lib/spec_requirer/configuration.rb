require 'pathname'

module SpecRequirer
  class Configuration
    attr_writer :app_root

    class MissingConfiguration < StandardError; end

    def app_root
      raise MissingConfiguration, 'app_root not set' if @app_root.nil?
      @app_root
    end
  end
end
