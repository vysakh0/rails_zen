require "rails_zen/write_to_files/write_to_model"
require 'active_support/core_ext/string'

class RailsZen::WriteToMigration < RailsZen::WriteToModel

  def write!
    if @validator
      line = send(@validator)
      append_to_line(line)
    end
    if scope_attr.any?
      inject_into_file file_name, "t.index #{scope_attr.to_s}\n", before: "t.timestamps"
    end
  end
  def append_to_line(line)
    gsub_file file_name, /t.#{attr_type}.+#{name}.*$/ do |match|
      match = line
    end
  end

  def file_name
    Dir.glob("db/migrate/*create_#{@model_name.pluralize}.rb")[0]
    # need to use pluralize here
  end

  private
  def validates_presence_of
    "t.#{attr_type} :#{name}, required: true, null: false"
  end
  def validates_uniqueness_of
    "t.#{attr_type} :#{name}, required: true, null: false, index: true"
  end
  def validates_uniqueness_scoped_to
    "t.#{attr_type} :#{name}, required: true, null: false, index: true"
  end
end

