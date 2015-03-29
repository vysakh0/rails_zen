require 'write_to_model'
class RailsZen::WriteToMigration < RailsZen::WriteToModel

  def write!
    append_to_line file_name, sends(@validator) if @validator
    if scope_attr
    write_to_file file_name, "t.index [:#{name}_id, #{scope_attr}]"
    end
  end
  private
  def file_name
    ls_grep = "db/migrate/*create_#{@model_name.pluralize}.rb"
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

