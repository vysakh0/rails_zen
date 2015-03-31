require 'rails_zen/given_model_gen'

RSpec.describe RailsZen::GivenModelGen do

  let(:given_model_gen) {
    RailsZen::GivenModelGen.new("user", "name:string email:string phone:integer")
  }

  it "#attrs returns just attributes' name without types " do
    expect(given_model_gen.attrs).to eq ["name", "email", "phone"]
  end

  describe "#chosen_attrs" do

    context "when no simple attributes is given by user" do
      it "returns attrs(object) that needs validations, extra specifications" do

        expect(given_model_gen.chosen_attrs).to match_array([
          an_object_having_attributes(class: RailsZen::ChosenAttr, name:"name", type: "string"),
          an_object_having_attributes(class: RailsZen::ChosenAttr, name:"email", type: "string"),
          an_object_having_attributes(class: RailsZen::ChosenAttr, name:"phone", type: "integer")
        ])
      end
    end
    context "when no simple attributes is given by user" do

      it "returns attrs(object) that needs validations, extra specifications except simple attributes" do

        given_model_gen.simple_attributes = "0".split
        expect(given_model_gen.chosen_attrs).to match_array([
          an_object_having_attributes(class: RailsZen::ChosenAttr, name:"email", type: "string"),
          an_object_having_attributes(class: RailsZen::ChosenAttr, name:"phone", type: "integer")
        ])
      end
    end
  end
  describe "#ask_for_has_many_relations" do

    before do
      @loc = double('file')
      set_stream(StringIO.new("posts\n"))
      @file = String.new
      allow(File).to receive(:open).with(any_args) { @loc }
      allow(File).to receive(:binread).with(any_args) { @file }
      allow_any_instance_of(RailsZen::WriteToModel).to receive(:file_name) { '/randompath/yo'}

    end
    context "when a hasmany relation is given" do
    it "writes to the model file" do
      @file << "class User < ActiveRecord::Base\nend\n"
      given_model_gen.ask_for_has_many_relations
      expect(@file).to include "has_many :posts"
    end
    it "writes to the model spec file" do
      @file << "RSpec.describe User, type: :model do\n pending '....'\nend"
      given_model_gen.ask_for_has_many_relations
      expect(@file).to include "it { is_expected.to have_many(:posts) }"
    end
    end
    context "when no hasmany relation is given" do
      before do
        set_stream(StringIO.new("\n"))
      end
    it "does not write to the model file" do
      @file << "class User < ActiveRecord::Base\nend\n"
      given_model_gen.ask_for_has_many_relations
      expect(@file).not_to include "has_many :posts"
    end
    it "does not write to the model spec file" do
      @file << "RSpec.describe User, type: :model do\n pending '....'\nend"
      given_model_gen.ask_for_has_many_relations
      expect(@file).not_to include "it { is_expected.to have_many(:posts) }"
    end
    end

  end
end

def set_stream(input)
  $terminal.instance_variable_set(:@input, input)
end
