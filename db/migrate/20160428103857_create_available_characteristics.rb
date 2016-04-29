class CreateAvailableCharacteristics < ActiveRecord::Migration
  def change
    create_table :available_characteristics do |t|
      t.string :title
      t.integer :group
      t.string :options

      t.timestamps null: false
    end
  end
end
