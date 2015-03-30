require 'rails_zen/write_to_files/write_to_model'
Given /I have all file/ do
  loc = double('file')
  allow(File).to receive(:open).with(any_args) { loc }
  allow(File).to receive(:binread).with(any_args) { file }
  allow_any_instance_of(RailsZen::WriteToModel).to receive(:file_name) { '/randompath/yo'}
  allow(Dir).to receive(:glob).with(any_args) {["2023_create_users.rb"]}
end
