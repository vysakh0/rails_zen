require 'rails_zen/write_to_files/write_to_spec'
require 'rails_zen/write_to_files/write_to_model'
require 'rails_zen/write_to_files/write_to_migration'

class RailsZen::WriteToFiles
  attr_reader :attr, :model_name

  def initialize(attr, model_name)
    @attr = attr
    @model_name = model_name
  end

  def build_file_writers(type)
    # When including thor, could not use initialize hence building it
    Object.const_get("RailsZen::#{type}").new.tap do |w|
      w.name                  = attr.name
      w.attr_type             = attr.type
      w.scope_attr            = attr.scope_attr
      w.validator             = attr.validator
      w.type_based_validators = attr.type_based_validators
      w.model_name            = model_name
    end
  end

  def write
    ["WriteToSpec", "WriteToMigration", "WriteToModel"].each do |type|
      build_file_writers(type).write!
    end
  end
end

