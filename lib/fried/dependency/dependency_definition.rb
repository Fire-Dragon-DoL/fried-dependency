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
    # @param obj [Object] instance being initialized with this dependency
    def extract_default(obj)
      default_with_arity(obj)
    end

    private

    def default_with_arity(obj)
      case default.arity
      when 0 then default.()
      when 1 then default.(type)
      else
        default.(type, obj)
      end
    end
  end
end
