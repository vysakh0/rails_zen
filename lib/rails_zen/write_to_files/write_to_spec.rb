require "rails_zen/write_to_files/model_level_validation_spec"
require "rails_zen/write_to_files/write_to_model"

class RailsZen::WriteToSpec < RailsZen::WriteToModel

  include RailsZen::ModelLeveLValidationSpec

  def write!
    write_to_file file_name, sends(@validator) if @validator
    write_to_file file_name, sends(@type_based_validators) if @type_based_validators
  end

  private
  def file_name
    "spec/models/#{@model_name}_spec.rb"
  end

  def validates_presence_of
    "it { is_expected.to validate_presence_of(:#{name})}"
  end
  def validates_uniqueness_of
    "it { is_expected.to validates_uniqueness_of(:#{name})}"
  end
  def validates_uniqueness_scoped_to
    "it { is_expected.to validates_uniqueness_of(:#{name}).scoped_to(:#{scope_attr})}"
  end
end
