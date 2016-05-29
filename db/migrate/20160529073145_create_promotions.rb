class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
    	t.references :promotionable, polymorphic: true, index: true

    	t.timestamps null: false
    end
  end
end
