require 'rails_zen/write_to_files/write_to_model'

Then /^For this (\w+) model, the exit status should be (\d+)$/ do |model, exit_status|
  #File.open("app/models/#{model}.rb", 'w+') {|f| f.write("class #{model.capitalize} < ActiveRecord::Base\nend\n") }
  assert_exit_status(exit_status.to_i)
end

Given /I have all files/ do
  file  = String.new("class User < ActiveRecord::Base\nend\n")
  loc = double('file')

  allow(File).to receive(:open).with(any_args) { loc }
  allow(File).to receive(:binread).with(any_args) { file }

  allow_any_instance_of(RailsZen::WriteToModel).to receive(:file_name) { '/randompath/yo'}

  allow(Dir).to receive(:glob).with(any_args) {["2023_create_users.rb"]}
end
