require "test_helper"
require "fried/dependency/dependency_definition"

class DependencyDefinitionDefinitionTest < Minitest::Spec
  DependencyDefinition = ::Fried::Dependency::DependencyDefinition

  it "has #reader returning name symbolized" do
    definition = DependencyDefinition.new("foo", String, "test")

    assert definition.reader == :foo
  end

  it "has #writer returning name symbolized with equal sign" do
    definition = DependencyDefinition.new(:foo, String, "test")

    assert definition.writer == :foo=
  end

  it "has #extract_default returning content of #default#call when Proc" do
    definition = DependencyDefinition.new(:foo, String, -> { "test" })

    assert definition.extract_default(Object.new) == "test"
  end

  it "has #extract_default passing type as first argument to Proc" do
    definition = DependencyDefinition.new(:foo, String, ->(a) { a })

    assert definition.extract_default(Object.new) == String
  end

  it "has #extract_default passing argument as second argument to Proc" do
    definition = DependencyDefinition.new(:foo, String, ->(_, a) { a })
    obj = Object.new

    assert definition.extract_default(obj) == obj
  end
end
