class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :orderid
      t.string :movimientos_inventario
      t.string :cantidad_producida
      t.string :compras_insumos
      t.string :numero_facturas
      t.string :movimientos_bancarios
      t.boolean :producto_compuesto
      t.datetime :fecha_entrega
      t.string :sku
      t.integer :cantidad

      t.timestamps null: false
    end
  end
end
