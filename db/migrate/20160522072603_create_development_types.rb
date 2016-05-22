class CreateDevelopmentTypes < ActiveRecord::Migration
  def change
    create_table :development_types do |t|
      t.string :name
      t.string :title
      t.string :slug

      t.timestamps null: false
    end
    add_index :development_types, :slug, unique: true
  end
end
