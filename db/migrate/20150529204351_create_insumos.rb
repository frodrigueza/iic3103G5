class CreateInsumos < ActiveRecord::Migration
  def change
    create_table :insumos do |t|
      t.string :sku
      t.integer :cantidad

      t.timestamps null: false
    end
  end
end
