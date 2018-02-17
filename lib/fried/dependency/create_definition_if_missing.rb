require "fried/core"
require "fried/call"
require "fried/dependency/get_definition"
require "fried/dependency/definition"

module Fried::Dependency
  # Creates schema definition if missing
  class CreateDefinitionIfMissing
    include ::Fried::Call::OnBuild

    attr_accessor :get_definition

    def self.build
      new.tap do |instance|
        instance.get_definition = GetDefinition.build
      end
    end

    # @param obj [Class]
    # @return [Definition]
    def call(obj)
      schema = get_definition.(obj)

      schema || obj.instance_variable_set(
        :@__fried_dependency__,
        Definition.new
      )
    end
  end
end
