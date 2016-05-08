class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.integer :format, :default=>0
      t.string :url
      t.references :mediable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
