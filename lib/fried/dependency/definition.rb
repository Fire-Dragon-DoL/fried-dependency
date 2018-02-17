require "fried/core"

module Fried::Dependency
  # Holds definied dependencies for a given {Class}
  class Definition
    private

    attr_reader :dependencies

    public

    def initialize
      @dependencies = {}
    end

    # @param dep [DependencyDefinition]
    # @return [DependencyDefinition]
    def add_dependency(dep)
      name = dep.name
      dependencies[name] = dep
    end

    # List all dependencies. If no block is passed, returns an enumerator,
    # otherwise it returns the last value returned by the block
    # @return [Enumerator, Object]
    def each_dependency(&block)
      return dependencies_enumerator if block.nil?

      dependencies_enumerator.each(&block)
    end

    private

    def dependencies_enumerator
      Enumerator.new(dependencies.size) do |yielder|
        dependencies.each { |_, definition| yielder << definition }
      end
    end
  end
end
