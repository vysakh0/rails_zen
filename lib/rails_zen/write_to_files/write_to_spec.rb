require "rails_zen/write_to_files/model_level_validation_spec"
require "rails_zen/write_to_files/write_to_model"

class RailsZen::WriteToSpec < RailsZen::WriteToModel

  include RailsZen::ModelLeveLValidationSpec

  def write!

    adding_to_file!(send(@validator)) if @validator
    adding_to_file!(send(@type_based_validator)) if @type_based_validator
  end
  def adding_to_file!(output)
    inject_into_file(file_name, "  #{output}\n", after: "RSpec.describe #{@model_name.capitalize}, type: :model do\n" )
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
