require "spec_requirer/version"

module SpecRequirer
  def self.setup
    container = Module.new do
      def respond_to?(method_name)
        [:uses_models, :require_model].include?(method_name) || super
      end
    end

    Kernel.extend(container)
  end
end
