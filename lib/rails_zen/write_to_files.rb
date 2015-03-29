require 'write_to_files/*.rb'

class RailsZen::WriteToFiles
  def initialize(attr, model_name)
    @attr = attr
    @model_name = model_name
  end

  def write
    RailsZen::WriteToSpec.new(@attr, @model_name).write!
    RailsZen::WriteToMigration.new(@attr, @model_name).write!
    RailsZen::WriteToModel.new(@attr, @model_name).write!
  end
end

