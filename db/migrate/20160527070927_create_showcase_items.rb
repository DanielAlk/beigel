class CreateShowcaseItems < ActiveRecord::Migration
  def change
    create_table :showcase_items do |t|
      t.references :showcaseable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
