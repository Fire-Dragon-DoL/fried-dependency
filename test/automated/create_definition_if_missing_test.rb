require "test_helper"
require "fried/dependency/create_definition_if_missing"
require "fried/dependency/get_definition"
require "fried/dependency/definition"
require "fried/typings"

class CreateDefinitionIfMissingTest < Minitest::Spec
  include Fried::Typings

  CreateDefinitionIfMissing = ::Fried::Dependency::CreateDefinitionIfMissing
  Definition = ::Fried::Dependency::Definition
  GetDefinition = ::Fried::Dependency::GetDefinition

  it "creates schema definition on instance variable" do
    obj = Object.new

    CreateDefinitionIfMissing.(obj)
    schema = GetDefinition.(obj)

    assert IsStrictly[Definition].valid?(schema)
  end

  it "returns existing definition if already created" do
    obj = Object.new

    schema1 = CreateDefinitionIfMissing.(obj)
    schema2 = CreateDefinitionIfMissing.(obj)

    assert schema1 == schema2
  end
end
