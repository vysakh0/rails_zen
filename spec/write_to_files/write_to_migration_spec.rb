require 'rails_zen/write_to_files/write_to_migration'
require 'shared/build_file_attr'

include Common

RSpec.describe RailsZen::WriteToMigration do

  before do
    @write_to_migration = build_file_attr("WriteToMigration")
  end

  let(:file) {
    str = %{
    class CreateUsers < ActiveRecord::Migration
      def change
        create_table :developers do |t|
          t.string :email
          t.timestamps null: false
        end
      end
    end
    }
    String.new(str)
  }

  it { expect(@write_to_migration).to respond_to :write!}

  describe "#write!" do

    before do
      loc = double('file')
      allow(File).to receive(:open).with(any_args) { loc }
      allow(File).to receive(:binread).with(any_args) { file }
      allow(Dir).to receive(:glob).with(any_args) {["2023_create_users.rb"]}
    end
    it "appends to the line" do

      @write_to_migration.write!
      expect(file).to include("t.string :email, required: true, null: false")
    end
    fit "inserts an index line to the file" do

      @write_to_migration.scope_attr = "post_id"
      @write_to_migration.write!

      expect(file).to include("t.index [:user_id, :post_id]")
    end
  end
end
