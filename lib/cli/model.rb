require "rails_zen/given_model_gen"
require "rails_zen/model_action"

module RailsZen
  module  CLI
    class Model < Thor
      desc "g MODELNAME ATTRIBUTES", "generate model, migration, spec files and step & step validations"
      long_desc %{

      Eg: rails_zen g model user name:string email:string score:integer

      The command generates the usual model, migration and model_spec files. After that,
      things we manually add such as validation or uniqueness are interactively asked by
      this command to write into model, migration and spec file.


      }
      def g(model, *attrs)
        attrs = attrs.join(' ')
        #system("rails g model #{attrs}")
        RailsZen::GivenModelGen.new(model, attrs).step_by_step

        #check_has_many
      end

      desc "act MODELNAME NAME ", "create an actions and action spec for a model"
      option :class
      def act(model_name, action_name)
        RailsZen::ModelAction.new(action_name, options[:class], model_name).write!
      end
    end
  end
end
