require "rails_zen/write_to_files/model_level_validation_spec"
require "rails_zen/write_to_files/write_to_model"

class RailsZen::WriteToSpec < RailsZen::WriteToModel

  include RailsZen::ModelLeveLValidationSpec

  def write!
    if @validator
      adding_to_file!(send(@validator))
      unless File.foreach("spec/models/#{@model_name}_spec.rb").grep(factory_girl_match).any?
        adding_to_file!(factory_method)
      end

    end

    adding_to_file!(send(@type_based_validator)) if @type_based_validator
  end
  def adding_to_file!(output)
    inject_into_file(file_name, "  #{output}\n", after: "RSpec.describe #{@model_name.capitalize}, type: :model do\n" )
  end

  private
  def factory_girl_match
    Regexp.new("FactoryGirl.create(:#{@model_name})")
  end
  def factory_method
    "let(:#{@model_name}) { FactoryGirl.create(:#{@model_name}) }"
  end

  def file_name
    "spec/models/#{@model_name}_spec.rb"
  end

  def validates_presence_of
    "it { #{@model_name}; is_expected.to validate_presence_of(:#{name})}"
  end
  def validates_uniqueness_of
    "it { #{@model_name}; is_expected.to validate_uniqueness_of(:#{name})}"
  end
  def validates_uniqueness_scoped_to
    "it { #{@model_name}; is_expected.to validate_uniqueness_of(:#{name}).scoped_to(:#{scope_attr})}"
  end
end
