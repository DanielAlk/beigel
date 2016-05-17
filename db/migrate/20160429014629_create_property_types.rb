class CreatePropertyTypes < ActiveRecord::Migration
  def change
    create_table :property_types do |t|
      t.string :name
      t.string :title
      t.string :slug

      t.timestamps null: false
    end
    add_index :property_types, :slug, unique: true
  end
end
