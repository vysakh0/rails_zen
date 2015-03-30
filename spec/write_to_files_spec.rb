require 'rails_zen/write_to_files.rb'

RSpec.describe RailsZen::WriteToFiles do

  subject {
    RailsZen::WriteToFiles.new(instance_double(RailsZen::ChosenAttr), "user")
  }
  it { is_expected.to respond_to :write }
end
