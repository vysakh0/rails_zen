require 'thor'
require "rails_zen/write_to_files/model_level_validation"

module RailsZen
  class WriteToModel


    attr_accessor :name, :scope_attr, :validator, :type_based_validators, :model_name, :attr_type, :file_name
    include RailsZen::ModelLeveLValidation
    include Thor::Base
    include Thor::Actions


    def write!

      if @validator
        output = send(@validator)
        if type_num?
          type_output = send(@type_based_validators)
          adding_to_file!("  #{output + type_output}\n" )
        else
          adding_to_file!("  #{output}\n")
        end
      end
    end

    def adding_to_file!(line)
      inject_into_class(file_name, model_name.capitalize, line)
    end

    def file_name
      "app/models/#{model_name}.rb"
    end
    private

    def type_num?
      @attr_type == "integer" || @attr_type == "decimal"
    end
    def validates_presence_of
      "validates :#{name}, presence: true"
    end
    def validates_uniqueness_of
      "validates :#{name}, presence: true, uniqueness: true"
    end
    def validates_uniqueness_scoped_to
      "validates_uniqueness_of :#{name}, scope: #{scope_attr.to_s}"
    end

  end
end
