require 'stringio'
require 'highline/import'

module RailsZen
  class ChosenAttr
    attr_accessor :name, :type, :validator, :type_based_validators, :scope_attr

    def initialize(name, type)
      @name = name
      @type = type
      @scope_attr = []
    end
    def get_user_inputs
      get_presence_req
      get_type_based_validations
    end

    def get_presence_req
      say "\n\nShould :#{name} be present always in your record?\n"
      say"--------------------------------------------------------------"
      inp = agree("Reply with y or n")

      if inp
        @validator = "validates_presence_of"
        #say "What should be the default value? If there is no default value enter n"
        #val = $stdin.gets.strip
        #if val != 'n'
        #@default_value = val
        #end
        get_uniqueness_req
      else
        @validator = nil
      end
    end

    def get_uniqueness_req
      say "Should :#{name} be an unique column?\n"
      say "-------------------------------------\n\n"
      say "Reply with \n
                  0 if it is not unique \n
                  1 if it is just unique \n
                  2 if it is unique with respect to another attr \n\n"

      inp = ask("Please enter", Integer) { |q| q.in = 0..2 }

      if inp == 2
        #say "Setting presence true in your models and migrations"
        say "\n#{name} is unique along with ?\n Reply with attr name\n "

        if is_relation?
          @scope_attr << "#{name}_id" unless name.end_with? "_id"
        end

        say("if it is a relation reply along with id: eg: user_id \n\n $->")
        @scope_attr << ask("Enter (comma sep list)  ", lambda { |str| str.split(/,\s*/) })
        @scope_attr = @scope_attr.flatten.map(&:to_sym)

        @validator = "validates_uniqueness_scoped_to"
      elsif  inp == 1
        @validator = "validates_uniqueness_of"
      end
    end

    def get_type_based_validations
      if(type == "integer" || type == "decimal")
        @validator_line = "#@validator_line, numericality: true"

        say "#{name} is an integer do you want to check  \n
                  1 just the numericality? \n
                  2 check if it is only integer\n\n $->
        "
        input = ask("Please enter", Integer) { |q| q.in = 1..2}

        map_input = {
          1 => "validate_numericality", 2 => "validate_integer"
          #"3" => "validate_greater_than", "4" => "validate_lesser_than"
        }

        @type_based_validators = map_input[input]

      elsif(is_relation?)
        @type_based_validators = "validate_belongs_to"
      end
    end
    def is_relation?
      type =="belongs_to" || type == "references" || (type.end_with? "_id")
    end
  end
end
