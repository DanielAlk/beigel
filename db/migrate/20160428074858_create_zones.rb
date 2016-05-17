class CreateZones < ActiveRecord::Migration
  def change
    create_table :zones do |t|
      t.string :name
      t.string :slug

      t.timestamps null: false
    end
    add_index :zones, :slug, unique: true
  end
end
