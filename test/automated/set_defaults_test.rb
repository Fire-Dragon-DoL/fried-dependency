require "test_helper"
require "fried/dependency/definition"
require "fried/dependency/dependency_definition"
require "fried/dependency/set_defaults"

class SetDefaultsTest < Minitest::Spec
  DependencyDefinition = ::Fried::Dependency::DependencyDefinition
  Definition = ::Fried::Dependency::Definition
  SetDefaults = ::Fried::Dependency::SetDefaults

  it "sets dependency value" do
    definition1 = DependencyDefinition.new(:foo, Numeric, -> { 1 })
    schema = Definition.new
    schema.add_dependency(definition1)
    klass = Class.new { attr_accessor :foo }
    obj = klass.new

    SetDefaults.(obj, schema, {})

    assert obj.foo == 1
  end

  it "overwrites dependency value with one passed in deps" do
    definition1 = DependencyDefinition.new(:foo, Numeric, -> { 1 })
    schema = Definition.new
    schema.add_dependency(definition1)
    klass = Class.new { attr_accessor :foo }
    obj = klass.new

    SetDefaults.(obj, schema, { foo: 2 })

    assert obj.foo == 2
  end
end
