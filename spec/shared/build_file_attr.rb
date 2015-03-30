require 'rails_zen/write_to_files'

module Common
  def build_file_attr(type)
    attr = RailsZen::ChosenAttr.new("email", "string").tap do |c|
      c.validator = "validates_presence_of"
      c.type_based_validators = nil
      c.scope_attr = nil
    end
    RailsZen::WriteToFiles.new(attr, 'user').build_file_writers(type)
  end
end
