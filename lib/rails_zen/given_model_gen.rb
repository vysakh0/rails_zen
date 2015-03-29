require 'rails_zen/chosen_attr'

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

      final = []
      i = -1
      attr_hash.each do |attr, type|
        i += 1
        unless simple_attributes.include? "#{i}"
          final << RailsZen::ChosenAttr.new(attr, type)
        end
      end
      final
    end

    private
    def attrs_with_types
      raw_attributes.scan(/(\w+):(\w+)/).to_h
    end
  end
end
