class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :orderid
      t.integer :movimientos_inventario
      t.integer :cantidad_producida
      t.integer :compras_insumos
      t.integer :numero_facturas
      t.integer :movimientos_bancarios

      t.timestamps null: false
    end
  end
end
