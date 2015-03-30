require "rails_zen/given_model_gen"

module RailsZen
  module  CLI
    class Model < Thor
      desc "g", "generate model, migration, spec files and step & step validations"

      def g(*args)
        puts args[0]
        #system("rails g model #{args.join(' ')}")
        RailsZen::GivenModelGen.new(args[0], args[1..-1].join(" ")).step_by_step

        #check_has_many
      end
    end
  end
end
