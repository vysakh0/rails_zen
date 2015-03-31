require 'rails_zen/chosen_attr'
require 'rails_zen/write_to_files'
require 'highline/import'

module RailsZen
  class GivenModelGen
    attr_accessor :name, :raw_attributes, :simple_attributes

    def initialize(name, raw_attrs)
      @name = name
      @raw_attributes = raw_attrs
      @simple_attributes = []
    end


    def step_by_step
      say "\nThese are your attributes"
      say "---------------------------\n"

      attrs.each_with_index { |attr, i| puts "#{i} #{attr}" }
      say "\n\nChoose the one that don't require 'presence true' or 'validations' or uniqueness.\n Enter like this eg: 0,1. or just enter "
      say "\n----------------------------------\n\n$.> "

      @simple_attributes =  ask("Enter (comma sep list)  ", lambda { |str| str.split(/,\s*/) })

      chosen_attrs.each do |attr_obj|
        attr_obj.get_user_inputs
        RailsZen::WriteToFiles.new(attr_obj, name).write
      end

      ask_for_has_many_relations
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
      final_attr_objs.partition { |attr| attr.scope_attr == false}.flatten
    end


    def ask_for_has_many_relations
      say "\nDo you have any has_many relations? Enter the name if so, otherwise leave it. eg: posts,comments"

      @has_many_relations =  ask("Enter (comma sep list)  ", lambda { |str| str.split(/,\s*/) })

      @has_many_relations.each do |rel|

        m = RailsZen::WriteToModel.new
        m.model_name = @name
        m.adding_to_file!("  has_many :#{rel}\n")

        s = RailsZen::WriteToSpec.new
        s.model_name = @name
        s.adding_to_file!("it { is_expected.to have_many(:#{rel}) }")
      end

    end
    def attrs
      raw_attributes.scan(/\w+(?=:)/)
    end
    private
    def attrs_with_types
      raw_attributes.scan(/(\w+):(\w+)/).to_h
    end


  end
end
