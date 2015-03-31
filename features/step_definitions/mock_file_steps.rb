require 'rails_zen/write_to_files/write_to_model'

Given /I have all files/ do
  file  = String.new("class User < ActiveRecord::Base\nend\n")
  loc = double('file')

  allow(File).to receive(:open).with(any_args) { loc }
  allow(File).to receive(:binread).with(any_args) { file }
  if File.open == loc
    puts "Wowooo"
  end
  if File.binread == file
    puts "LOL LOL"
  end

  allow_any_instance_of(RailsZen::WriteToModel).to receive(:file_name) { '/randompath/yo'}

  allow(Dir).to receive(:glob).with(any_args) {["2023_create_users.rb"]}
end
