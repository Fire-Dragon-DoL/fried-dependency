require "fried/core"

module Fried::Dependency
  # Set defaults values for all dependencies in definition
  class SetDefaults
    def self.build
      new
    end

    def self.call(obj, schema, deps)
      instance = build
      instance.(obj, schema, deps)
    end

    # @param obj [Object]
    # @param schema [Definition]
    # @param deps [Hash{Symbol => Object}]
    # @return [void]
    def call(obj, schema, deps)
      schema.each_dependency do |definition|
        value = pick_value(deps, definition)
        obj.send(definition.writer, value)
      end
    end

    private

    def pick_value(deps, definition)
      return deps[definition.name] if deps.has_key?(definition.name)
      definition.extract_default
    end
  end
end
