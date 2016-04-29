class CreateCharacteristics < ActiveRecord::Migration
  def change
    create_table :characteristics do |t|
      t.references :characterizable, polymorphic: true, index: true
      t.references :available_characteristic, index: true, foreign_key: true
      t.string :option_value

      t.timestamps null: false
    end
  end
end
