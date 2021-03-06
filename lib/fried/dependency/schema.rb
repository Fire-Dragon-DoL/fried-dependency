require "fried/core"
require "fried/dependency/create_definition_if_missing"
require "fried/dependency/set_defaults"
require "fried/dependency/define_methods"
require "fried/dependency/dependency_definition"

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
        ns = ::Fried::Dependency
        definition = ns::CreateDefinitionIfMissing.(self.class)
        ns::SetDefaults.(self, definition, deps)
      end
    end

    module ClassMethods
      DefaultInit = ->(type) { type.new }

      # Defines a dependency
      # @param name [Symbol] defines a public attr_accessor using given Symbol
      # @param klass [Class] defines the class to use in case the dependency is
      #   not provided in `initialize`. When it's not provided, the default
      #   value of the dependency will be `klass.new`
      # @param default [Proc] lambda which optionally accepts `type` and `obj`,
      #   which are the class of the dependency and the object being
      #   initialized. The returned value is used as default value when the
      #   dependency is not passed in the initializer.
      #   This lambda is optional, in which case the default value will just be
      #   `->(type) { type.new }`
      # @return [Symbol] the value passed as `name`
      def dependency(name, klass, default = DefaultInit)
        ns = ::Fried::Dependency
        definition = ns::CreateDefinitionIfMissing.(self)
        dep = ns::DependencyDefinition.new(name, klass, default)
        definition.add_dependency(dep)
        ns::DefineMethods.(dep, self)
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
