require 'thor'

class Yolo

  include Thor::Base
  include Thor::Actions

  def yo
    puts "hello world"
  end
  def pp
    gsub_file "cool.rb", /\D+title/ do |match|
      puts match.inspect
      match << ", required: true"
    end
  end
end
Yolo.new.yo
