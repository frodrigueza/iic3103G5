class CreateColas < ActiveRecord::Migration
  def change
    create_table :colas do |t|
      t.datetime :inicio
      t.datetime :fin
      t.integer :precio
      t.string :sku

      t.timestamps null: false
    end
  end
end
