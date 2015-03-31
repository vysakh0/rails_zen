require 'rails_zen/write_to_files/write_to_spec'
require 'shared/build_file_attr'

include Common

RSpec.describe RailsZen::WriteToSpec do

  before do
    @write_to_spec = build_file_attr("WriteToSpec")
  end

  let(:file) { String.new("RSpec.describe User, type: :model do\n pending '....'\nend") }

  it { expect(@write_to_spec).to respond_to :write!}

  describe "#write!" do

    before do

      @loc = double('file')
      allow(File).to receive(:open).with(any_args) { @loc }
      allow(File).to receive(:binread).with(any_args) { file }
      allow(File).to receive(:foreach).with(any_args).and_return(@loc)
      allow(@loc).to receive(:grep).with(any_args).and_return([])
    end
    it "inserts factory girl instance" do

      @write_to_spec.write!
      expect(file).to include("FactoryGirl.create(:user)")
    end
    it "appends to the file" do

      @write_to_spec.write!
      expect(file).to include "it { user; is_expected.to validate_presence_of(:email)}"
    end
  end
end
