require 'rails_zen/write_to_files/write_to_model'
require 'rails_zen/write_to_files/write_to_spec'
require 'rails_zen/model_action'
require 'highline/import'

RSpec.describe RailsZen::ModelAction do


  let(:model_action){
    RailsZen::ModelAction.new("sum", false, "calculator")
  }

  describe "#write!" do
    before do
      loc = double('file')
      set_stream(StringIO.new("returns sum of two numbers\na,b\n1,2\n3"))
      @file = String.new
      allow(File).to receive(:open).with(any_args) { loc }
      allow(File).to receive(:binread).with(any_args) { @file }
      allow_any_instance_of(RailsZen::WriteToModel).to receive(:file_name) { '/randompath/yo'}
    end

    context "when user wants to write an instance method" do

      it "writes to the model file" do
        @file << "class Calculator < ActiveRecord::Base\nend\n"

        model_action.write!
        expect(@file).to include "sum(a, b)"
      end
      it "writes to the model spec file" do
        @file << "RSpec.describe Calculator, type: :model do\n pending '....'\nend"

        model_action.write!
        expect(@file).to include "describe \"#sum\""
      end

      it "writes expectation in the model spec file" do
        @file << "RSpec.describe Calculator, type: :model do\n pending '....'\nend"

        model_action.write!
        expect(@file).to include "expect(calculator.sum(1, 2)).to eq \"3\""
      end
    end
    context "when user wants to write a class method" do

      before do
        model_action.is_class_action = true
      end
      it "writes to the model file" do
        @file << "class Calculator < ActiveRecord::Base\nend\n"

        model_action.write!
        expect(@file).to include "self.sum(a, b)"
      end
      it "writes to the model spec file" do
        @file << "RSpec.describe Calculator, type: :model do\n pending '....'\nend"

        model_action.write!
        expect(@file).to include "describe \".sum\""
      end

      it "writes expectation in the model spec file" do
        @file << "RSpec.describe Calculator, type: :model do\n pending '....'\nend"

        model_action.write!
        expect(@file).to include "expect(Calculator.sum(1, 2)).to eq \"3\""
      end
    end
  end
end

def set_stream(input)
  $terminal.instance_variable_set(:@input, input)
end
