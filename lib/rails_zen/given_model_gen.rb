require 'rails_zen/chosen_attr'
require 'rails_zen/write_to_files'

module RailsZen
  class GivenModelGen
    attr_accessor :name, :raw_attributes, :simple_attributes

    def initialize(name, raw_attrs)
      @name = name
      @raw_attributes = raw_attrs
      @simple_attributes = []
    end
    def attrs
      raw_attributes.scan(/\w+(?=:)/)
    end

    def chosen_attrs

      attr_hash = attrs_with_types

      final_attr_objs = []
      i = -1
      attr_hash.each do |attr, type|
        i += 1
        unless simple_attributes.include? "#{i}"
          final_attr_objs << RailsZen::ChosenAttr.new(attr, type)
        end
      end
      final_attr_objs
    end

    def step_by_step
      puts "\nThese are your attributes"
      puts "---------------------------\n"

      attrs.each_with_index { |attr, i| puts "#{i} #{attr}" }
      puts "\n\nChoose the one that don't require 'presence true' or 'validations' or uniqueness.\n Enter like this eg: 0 1. \nDo not prese enter after one of the options, make it in a single line \n"
      puts "----------------------------------\n\n$.> "

      @simple_attributes = $stdin.gets.chomp.split

      puts "\n\n Great! Lets move on fast..\n\n"

      chosen_attrs.each do |attr_obj|
        attr_obj.get_user_inputs
        RailsZen::WriteToFiles.new(attr_obj, name).write
      end
    end

    private
    def attrs_with_types
      raw_attributes.scan(/(\w+):(\w+)/).to_h
    end
  end
end
