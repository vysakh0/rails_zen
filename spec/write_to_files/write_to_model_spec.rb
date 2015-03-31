require 'rails_zen/write_to_files/write_to_model'
require 'shared/build_file_attr'

include Common

RSpec.describe RailsZen::WriteToModel do

  before do
    @write_to_model = build_file_attr("WriteToModel")
  end

  let(:file) { String.new("class User < ActiveRecord::Base\nend\n") }

  it { expect(@write_to_model).to respond_to :write!}

  describe "#write!" do

    before do
      loc = double('file')
      allow(File).to receive(:open).with(any_args) { loc }
      allow(File).to receive(:binread).with(any_args) { file }
    end
    it "appends to the file" do

      allow(@write_to_model).to receive(:file_name) { '/randompath/yo'}

      @write_to_model.write!
      expect(file).to include("validates :email, presence: true")
    end
    context "when one scope" do

      before do
        @write = build_file_attr("WriteToModel", [:post_id, :comment_id], "validates_uniqueness_scoped_to")
      end

      fit "adds a scope to uniqueness" do
        allow(@write).to receive(:file_name) { '/randompath/yo'}
        @write.write!

        expect(file).to include("validates_uniqueness_of :post_id, scope: :comment_id")
      end
    end
    context "when multiple scope" do

      before do
        @write = build_file_attr("WriteToModel", [:post_id, :comment_id, :score_id], "validates_uniqueness_scoped_to")
      end

      fit "adds an array of scope to uniqueness" do
        allow(@write).to receive(:file_name) { '/randompath/yo'}
        @write.write!

        expect(file).to include("validates_uniqueness_of :post_id, scope: [:comment_id, :score_id]")
      end
    end
  end
end
