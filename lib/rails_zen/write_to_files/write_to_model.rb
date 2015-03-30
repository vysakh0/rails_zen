require 'thor'
require "rails_zen/write_to_files/model_level_validation"

module RailsZen
  class WriteToModel


    attr_accessor :name, :scope_attr, :validator, :type_based_validators, :model_name, :attr_type

    include RailsZen::ModelLeveLValidation
    include Thor::Base
    include Thor::Actions


    def write!
      if @validator
        output = send(@validator)
        if type_num?
          type_output = send(@type_based_validators)
          inject_into_class(file_name, "  #{output + type_output}\n" )
        else
          inject_into_class file_name, @model_name.capitalize, "  #{output}\n"
        end
      end
    end

    private

    def type_num?
      @attr_type == "integer" || @attr_type == "decimal"
    end
    def file_name
      "app/models/#{@model_name}.rb"
    end
    def validates_presence_of
      "validates :#{name}, presence: true"
    end
    def validates_uniqueness_of
      "validates :#{name}, presence: true, uniqueness: true"
    end
    def validates_uniqueness_scoped_to
      "validates_uniqueness_of :#{name}, scope: #{scope_attr}"
    end

  end
end
