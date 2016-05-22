class CreateDevelopments < ActiveRecord::Migration
  def change
    create_table :developments do |t|
      t.string :title
      t.string :info
      t.text :description
      t.integer :status, :default=>0
      t.references :development_type, index: true, foreign_key: true
      t.integer :stage, :default=>0
      t.integer :delivery_month
      t.integer :delivery_year
      t.references :zone, index: true, foreign_key: true
      t.string :address
      t.string :zip_code
      t.decimal :lat, :precision=>10, :scale=>6
      t.decimal :lng, :precision=>10, :scale=>6
      t.string :slug

      t.timestamps null: false
    end
    add_index :developments, :slug, unique: true
  end
end
