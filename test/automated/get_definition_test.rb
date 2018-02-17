require "test_helper"
require "fried/dependency/get_definition"

class GetDefinitionTest < Minitest::Spec
  GetDefinition = ::Fried::Dependency::GetDefinition

  it "gets schema definition from instance variable" do
    obj = Object.new
    obj.instance_variable_set(:@__fried_dependency__, 123)

    schema = GetDefinition.(obj)

    assert schema == 123
  end
end
