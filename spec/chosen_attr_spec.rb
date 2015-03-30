require 'rails_zen/chosen_attr'

RSpec.describe RailsZen::ChosenAttr do


  subject {
    RailsZen::ChosenAttr.new("name", "string")
  }

  #after do
    #$stdin = STDIN
  #end

  it { is_expected.to respond_to :get_user_inputs}


  describe "#get_presence_req" do

    context "when 'y' for presence" do

      context "when 0 for uniqueness" do
        it "sets validator to validates_presence_of" do
          set_stream(StringIO.new("y\n0\n"))
          subject.get_user_inputs
          expect(subject.validator).to eq "validates_presence_of"
        end
      end
      context "when '1' for uniqueness" do
        it "sets validator to validates_uniqueness_of" do
          set_stream(StringIO.new("y\nr\n1\n"))
          subject.get_user_inputs
          expect(subject.validator).to eq "validates_uniqueness_of"
        end
      end
      context "when '2' for uniqueness" do
        it "sets validator to validates_uniqueness_scoped_to" do
          set_stream(StringIO.new("y\n 2\n order_id\n"))
          subject.get_user_inputs
          expect(subject.validator).to eq "validates_uniqueness_scoped_to"
        end
      end
    end
    context "when n for presence" do

      fit "sets validator to validates_presence_of" do
        set_stream(StringIO.new("n\n"))
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
          fit "sets type_based_validators to validate_numericality" do
            set_stream(StringIO.new("1\n"))
            @chosen.get_type_based_validations
            expect(@chosen.type_based_validators).to eq "validate_numericality"
          end
        end
        context "when numericality with integer is chosen" do
          it "sets type_based_validators to validate_integer" do
            set_stream(StringIO.new("2\n"))
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

def set_stream(input)
  #inp = $terminal.instance_variable_get(:@input)
  #inp.flush
  $terminal.instance_variable_set(:@input, input)
  # highline set input, $stdin setting is not working. i.e $stdin = input
end
