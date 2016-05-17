class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :title
      t.string :info
      t.text :description
      t.integer :status, :default=>0
      t.references :property_type, index: true, foreign_key: true
      t.integer :age
      t.integer :environments
      t.integer :garages
      t.integer :bathrooms
      t.integer :toilettes
      t.integer :expenses
      t.integer :sale_price
      t.integer :sale_currency
      t.integer :rent_price
      t.integer :rent_currency
      t.integer :area_unit
      t.integer :constructed_area
      t.integer :unconstructed_area
      t.integer :area
      t.references :zone, index: true, foreign_key: true
      t.string :address
      t.string :zip_code
      t.decimal :lat, :precision=>10, :scale=>6
      t.decimal :lng, :precision=>10, :scale=>6
      t.string :slug

      t.timestamps null: false
    end
    add_index :properties, :slug, unique: true
  end
end
