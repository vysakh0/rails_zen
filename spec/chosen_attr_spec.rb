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

        fit "sets validator to validates_presence_of" do
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
      context "when '2' for uniqueness" do
        before do
          $stdin = StringIO.new("y\n 2\n order_id\n")
        end

        it "sets validator to validates_uniqueness_scoped_to" do
          subject.get_user_inputs
          expect(subject.validator).to eq "validates_uniqueness_scoped_to"
        end
      end
    end
    context "when n for presence" do
      before do
        $stdin = StringIO.new("n\n")
      end

      it "sets validator to validates_presence_of" do
        subject.get_user_inputs
        expect(subject.validator).to be nil
      end

    end

    describe "#get_type_based_validations" do
      context "when type is integer" do

        before do
          @chosen = RailsZen::ChosenAttr.new("phone", "integer")
        end
        context "when just the numericality is chosen" do
          it "sets type_based_validators to validate_numericality" do
            $stdin = StringIO.new("1\n")
            @chosen.get_type_based_validations
            expect(@chosen.type_based_validators).to eq "validate_numericality"
          end
        end
        context "when numericality with integer is chosen" do
          it "sets type_based_validators to validate_integer" do
            $stdin = StringIO.new("2\n")
            @chosen.get_type_based_validations
            expect(@chosen.type_based_validators).to eq "validate_integer"
          end
        end
      end
      context "when type is a relation" do
        before do
          @chosen = RailsZen::ChosenAttr.new("user", "belongs_to")
        end
        it "sets type_based_validators to validate_belongs_to" do
          @chosen.get_type_based_validations
          expect(@chosen.type_based_validators).to eq "validate_belongs_to"
        end
      end
    end
  end
end
