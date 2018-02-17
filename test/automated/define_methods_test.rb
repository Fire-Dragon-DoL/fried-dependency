require "test_helper"
require "fried/dependency/dependency_definition"
require "fried/dependency/define_methods"

class DefineMethodsTest < Minitest::Spec
  DependencyDefinition = ::Fried::Dependency::DependencyDefinition
  DefineMethods = ::Fried::Dependency::DefineMethods

  it "adds a writer and reader method based on dependency definition" do
    klass = Class.new
    definition = DependencyDefinition.new(:foo, String)

    DefineMethods.(definition, klass)
    instance = klass.new
    instance.foo = "foo"
    value = instance.foo

    assert value == "foo"
  end

  it "returns dependency name" do
    klass = Class.new
    definition = DependencyDefinition.new(:foo, String)

    name = DefineMethods.(definition, klass)

    assert name == :foo
  end
end
