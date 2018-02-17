require "test_helper"
require "fried/dependency/schema"

class SchemaTest < Minitest::Spec
  def setup
    @klass = Class.new do
      include ::Fried::Dependency::Schema

      dependency :name, String
      dependency :age, Numeric, -> { 123 }
    end
  end

  it "initializes object with default values" do
    obj = @klass.new

    assert obj.name == "" && obj.age == 123
  end

  it "initializes object with overwritten values" do
    obj = @klass.new(name: "bar")

    assert obj.name == "bar" && obj.age == 123
  end
end
