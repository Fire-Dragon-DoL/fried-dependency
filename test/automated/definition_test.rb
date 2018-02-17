require "test_helper"
require "fried/dependency/dependency_definition"
require "fried/dependency/definition"

class DefinitionTest < Minitest::Spec
  DependencyDefinition = ::Fried::Dependency::DependencyDefinition
  Definition = ::Fried::Dependency::Definition

  it "adds dependency to definition" do
    definition = Definition.new
    dependency = DependencyDefinition.new(:name, Numeric, -> { 1 })

    definition.add_dependency(dependency)
    other_attribute = definition.each_dependency.first

    assert other_attribute == dependency
  end
end
