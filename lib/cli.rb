require 'thor'
require 'cli/model'

module RailsZen
  class Dexterity < Thor

    desc "model COMMANDS", "Generator related to Rails modules"
    subcommand "model", RailsZen::CLI::Model
  end
end
