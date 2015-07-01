class CreatePromos < ActiveRecord::Migration
  def change
    create_table :promos do |t|
      t.string :sku
      t.string :codigo
      t.integer :precio
      t.timestamps null: false
    end
  end
end
