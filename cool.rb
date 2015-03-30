class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :vid
      t.belongs_to :developer, index: true, foreign_key: true
      t.string :title, required: true

      t.timestamps null: false
    end
  end
end
