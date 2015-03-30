require "rails_zen/given_model_gen"

module RailsZen
  module  CLI
    class Model < Thor
      desc "g", "generate model, migration, spec files and step & step validations"

      def g(*args)
        #system("rails g model #{args.join(' ')}")
        #puts "0 name" # checking aruba
        RailsZen::GivenModelGen.new(args[0], args[1..-1].join(" ")).step_by_step

        #check_has_many
      end
    end
  end
end
