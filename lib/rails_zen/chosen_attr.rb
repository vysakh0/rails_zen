require 'stringio'

module RailsZen
  class ChosenAttr
    attr_reader :name, :type, :validator, :type_based_validators, :scope_attr

    def initialize(name, type)
      @name = name
      @type = type
    end
    def get_user_inputs
      get_presence_req
      get_type_based_validations
    end

    def get_presence_req
      puts "Must :#{name} be present always? Reply with y or n eg: y"

      if $stdin.gets.strip.downcase == 'y'
        puts "Setting presence true in your models and migrations"

        @validator = "validates_presence_of"
        #puts "What should be the default value? If there is no default value enter n"
        #val = $stdin.gets.strip
        #if val != 'n'
        #@default_value = val
        #end
        get_uniqueness_req
        # append_to migration
      end
    end

    def get_uniqueness_req
      puts "Must :#{name} be unique? Reply with \n
                  1 if it is just unique \n
                  2 if it is unique with respect to another attr \n
                  n if it is not unique"

      inp = $stdin.gets.strip

      puts "this is the input"
      puts inp
      if inp == "2"
        #puts "Setting presence true in your models and migrations"
        puts "#{name} is unique along with ? Reply with attr name, if it is a relation reply along with id: eg: user_id "
        @scope_attr = $stdin.gets.strip
        @validator = "validates_uniqueness_scoped_to"
      elsif  inp == "1"
        @validator = "validates_uniqueness_of"
      end
    end

    def get_type_based_validations
      if(type == "integer" || type == "decimal")
        @validator_line = "#@validator_line, numericality: true"

        puts "#{name} is an integer do you want to check  \n
                  1 just the numericality? \n
                  2 check if it is only integer\n
        "
        input = $stdin.gets.strip

        map_input = {
          "1" => "validate_numericality", "2" => "validate_integer"
          #"3" => "validate_greater_than", "4" => "validate_lesser_than"
        }

        @type_based_validators = map_input[input]

      elsif(type =="belongs_to" || type == "references" || (type.end_with? "_id"))
        @type_based_validators = "validate_belongs_to"
      end
    end
  end
end
