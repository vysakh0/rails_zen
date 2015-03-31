require 'rails_zen/write_to_files/write_to_model'
require 'rails_zen/write_to_files/write_to_spec'
require 'highline/import'

module RailsZen
  class ModelAction
    attr_writer :is_class_action

    def initialize(name, is_class_action, model)
      @name = name
      @model = model
      @is_class_action = is_class_action
      @arg_names = []
      @args = []
    end

    def write!
      get_necessary_info
      m = RailsZen::WriteToModel.new
      m.model_name = @model
      m.adding_to_file!(action_string)
      s = RailsZen::WriteToSpec.new
      s.model_name = @model
      s.adding_to_file!(action_spec_string)
    end

    private

    def get_necessary_info
      say "What does your method do?\n Please don't use it or should"
      @functionality = ask("Eg: returns sum of 2 numbers\n")

      say "------------ARGUMENTS-----------------\n"

      say "What name would you give your arguments for the #{@name} method? eg: first_name,last_name\n"

      @arg_names = ask("Enter (comma sep) list", lambda { |str| str.split(/,\s*/) })

      say "Give example arguments inputs\n"

      @args =  ask("Enter (comma sep list). Eg: 1,2 ", lambda { |str| str.split(/,\s*/) })


      @expected = ask("Enter the expected output for the previously entered arguments. eg: 3")
    end

    def action_string
      %{
      def #{method_with_args}
      end
      }
    end

    def action_spec_string
      if @is_class_action
      %{
      it { is_expected.to respond_to :#{@name}}

      describe ".#{@name}" do
        it "#{@functionality}" do
          expect(#{@model.capitalize}.#{@name}(#{sample_arguments})).to eq \"#{@expected}\"
        end
      end

      }
      else
        %{
        describe "##{@name}" do
          it "#{@functionality}" do
            expect(#{@model}.#{@name}(#{sample_arguments})).to eq \"#{@expected}\"
          end
        end

        }
      end
    end
    def method_with_args
      if @is_class_action
        "self.#{@name}(#{arguments})"
      else
        "#{@name}(#{arguments})"
      end
    end

    def sample_arguments
      @args.join(", ")
    end
    def arguments
      @arg_names.join(", ")
    end
  end
end
