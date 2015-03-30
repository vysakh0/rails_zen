require 'rails_zen/write_to_files/write_to_model'
require 'shared/build_file_attr'

include Common

RSpec.describe RailsZen::WriteToModel do

  before do
    @write_to_model = build_file_attr("WriteToModel")
  end

  let(:file) { String.new("class User < ActiveRecord::Base\nend\n") }

  it { expect(@write_to_model).to respond_to :write!}

  describe "#write" do

    fit "appends to the file" do

      allow(File).to receive(:binread).with(anything()) { file }

      @write_to_model.write!
      expect(file).to include("validates :email, presence: true")
    end
  end
end
