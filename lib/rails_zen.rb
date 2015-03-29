require "rails_zen/version"
require "rails_zen/chosen_attr.rb"

module RailsZen
  # Your code goes here...
  puts "The model name"
  name = gets.chomp
  puts "Enter the attribute names along with their types eg: name:string description:text"

  raw_attributes = gets.chomp.split
  system("rails g #{model.attributes}")
  puts "These are your attributes"

  model = RailsZen::GivenModelGen.new(name, raw_attributes)

  model.attrs.each_with_index { |attr, i| puts "#{i} #{attr}" }
  puts "Choose the one that don't require 'presence true' or 'validations' or uniqueness. Enter like this eg: 0 2 3"

  model.simple_attributes = gets.chomp.split


  chosen_attrs = model.chosen_attrs

  chosen_attrs.each do |attr|
    attr.get_user_inputs
    WriteToFiles.new(attr, model.name).write
  end

  check_has_many
end
