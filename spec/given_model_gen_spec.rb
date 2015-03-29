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
    #context "when no simple attributes is given by user" do
      #it "returns attrs(object) that needs validations, extra specifications" do

        #given_model_gen.simple_attributes = "0".split
        #expect(given_model_gen.chosen_attrs).to match_array([
          #an_object_having_attributes(class: RailsZen::ChosenAttr, name:"email", type: "string"),
          #an_object_having_attributes(class: RailsZen::ChosenAttr, name:"phone", type: "integer")
        #])
      #end
    #end
  end
end
