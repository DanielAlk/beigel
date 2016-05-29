class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :subject
      t.string :name
      t.string :email
      t.string :tel
      t.text :message
      t.string :data
      t.references :contactable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
