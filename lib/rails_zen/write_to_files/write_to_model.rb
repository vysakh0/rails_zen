
require "model_level_validation"

class RailsZen::WriteToModel

  attr_reader :name, :scope_attr

  include RailsZen::ModelLeveLValidation

  def initialize(attr, model_name)
    @name                  = attr.name
    @attr_type             = attr.type
    @scope_attr            = attr.scope_attr
    @validator             = attr.validator
    @type_based_validators = attr.type_based_validators
    @model_name            = model_name
  end

  def write!
    if @validator
      if type_num?
        write_to_file(file_name, sends(@validator) + sends(@type_based_validators))
      else
        write_to_file file_name, sends(@validator)
      end
    end
  end

  def type_num?
    @attr_type == "integer" || @attr_type == "decimal"
  end
  private

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
