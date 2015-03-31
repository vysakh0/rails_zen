require "rails_zen/write_to_files/write_to_model"
require 'active_support/core_ext/string'

class RailsZen::WriteToMigration < RailsZen::WriteToModel

  def write!
    if @validator
      line = send(@validator)
      append_to_line(line)
    end
    if scope_attr
      scope_attr.each_key do |key|
        inject_into_file file_name, "t.index [:#{key}, :#{scope_attr[key]}]\n", before: "t.timestamps"
      end
    end
  end
  def append_to_line(line)
    gsub_file file_name, /^\D+#{name}/ do |match|
      match << line
    end
  end

  def file_name
    Dir.glob("db/migrate/*create_#{@model_name.pluralize}.rb")[0]
    # need to use pluralize here
  end

  private
  def validates_presence_of
    ", required: true, null: false"
  end
  def validates_uniqueness_of
    ", required: true, null: false, index: true"
  end
  def validates_uniqueness_scoped_to
    ", required: true, null: false, index: true"
  end
end

