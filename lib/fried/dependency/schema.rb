require "fried/core"

module Fried::Dependency
  # Provides {.dependency} to define object dependencies. It automatically
  # defines an initializer that will create default objects for each dependency
  # (just calling `new` on the dependency class) and assign them to given
  # attributes
  module Schema
    module Initializer
      # @param deps [Hash{Symbol => Object}] dependencies to overwrite during
      #   initialization
      def initialize(**deps)
        definition = CreateDefinitionIfMissing.(self.class)
        SetDefaults.(self, definition, deps)
      end
    end

    module ClassMethods
      DefaultInit = ->(type, _) { type.new }

      # Defines a dependency
      # @param name [Symbol] defines a public attr_accessor using given Symbol
      # @param klass [Class] defines the class to use in case the dependency is
      #   not provided in `initialize`. When it's not provided, the default
      #   value of the dependency will be `klass.new`
      # @yield [Class, Object] accepts the class of the dependency and the
      #   instance being initialized. The returned value is used as default
      #   value when the dependency is not passed in the initializer.
      #   This block is optional, in which case the default value will just be
      #   `-> { |klass| klass.new }`
      # @return [Symbol] the value passed as `name`
      def dependency(name, klass, &default)
        definition = CreateDefinitionIfMissing.(self)
        dep = DependencyDefinition.new(name, klass, default || DefaultInit)
        definition.add_dependency(dep)
        DefineMethods.(dep, self)
      end
    end

    def self.included(klass)
      klass.instance_eval do
        extend ClassMethods
        include Initializer
      end
    end
  end
end
