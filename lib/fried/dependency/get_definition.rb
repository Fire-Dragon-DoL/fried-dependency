require "fried/core"

module Fried::Dependency
  # Get dependencies definition from {Class}
  class GetDefinition
    def self.build
      new
    end

    def self.call(obj)
      instance = build
      instance.(obj)
    end

    # @param obj [Class]
    # @return [Definition]
    def call(obj)
      obj.instance_variable_get(:@__fried_dependency__)
    end
  end
end
