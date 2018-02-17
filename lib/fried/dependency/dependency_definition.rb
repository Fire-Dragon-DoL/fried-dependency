require "fried/core"

module Fried::Dependency
  # Value-type holding definition of dependency
  class DependencyDefinition < Struct.new(:name, :type, :default)
    # @!attribute [rw] name
    #   A {Symbol}
    # @!attribute [rw] type
    #   Any {Class} or object which responds to `#new`
    # @!attribute [rw] default
    #   A {Proc} it will be evaluated during initialization

    # Attribute reader method name
    # @return [Symbol]
    def reader
      name.to_sym
    end

    # Attribute writer method name
    # @return [Symbol]
    def writer
      :"#{reader}="
    end

    # Extracts content of {#default} if present, otherwise returns the value of
    # `type#new`
    def extract_default
      return default.() unless default.nil?
      type.new
    end
  end
end
