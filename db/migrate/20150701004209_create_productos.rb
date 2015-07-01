class CreateProductos < ActiveRecord::Migration
  def change
    create_table :productos do |t|
      t.integer :sku
      t.string :nombre
      t.integer :precio
      t.string :categoria
      t.string :tipo

      t.timestamps null: false
    end
  end
end
