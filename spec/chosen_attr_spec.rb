require 'rails_zen/chosen_attr'

RSpec.describe RailsZen::ChosenAttr do

  subject {
    RailsZen::ChosenAttr.new("name", "string")
  }


  it { is_expected.to respond_to :get_user_inputs}


  describe "#get_presence_req" do
    after do
      $stdin = STDIN
    end

    context "when 'y' for presence" do

      context "when 'n' for uniqueness" do
        before do
          $stdin = StringIO.new("y\n n\n")
        end

        it "sets validator to validates_presence_of" do
          subject.get_user_inputs
          expect(subject.validator).to eq "validates_presence_of"
        end
      end
      context "when '1' for uniqueness" do
        before do
          $stdin = StringIO.new("y\n 1\n")
        end

        it "sets validator to validates_uniqueness_of" do
          subject.get_user_inputs
          expect(subject.validator).to eq "validates_uniqueness_of"
        end
      end
    end
  end
end
