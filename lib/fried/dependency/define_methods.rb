require "fried/core"
require "fried/call"

module Fried::Dependency
  # Define methods based on attributes registered in
  # {::Fried::Dependency::Definition}
  class DefineMethods
    include ::Fried::Call::OnBuild

    def self.build
      new
    end

    # Creates methods to read/write dependency
    # @param dep [DependencyDefinition]
    # @param klass [Class]
    # @return [Symbol] `dep#name`
    def call(dep, klass)
      klass.send(:attr_accessor, dep.reader)
      dep.name
    end
  end
end
