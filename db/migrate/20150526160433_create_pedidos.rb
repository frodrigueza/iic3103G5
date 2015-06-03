class CreatePedidos < ActiveRecord::Migration
  def change
    create_table :pedidos do |t|
      t.string :oc_id
      t.string :canal
      t.string :cliente
      t.string :movimientos_inventario
      t.string :cantidad_producida
      t.string :compras_insumos
      t.string :numero_facturas
      t.string :movimientos_bancarios
      t.boolean :producto_compuesto
      t.datetime :fecha_entrega
      t.string :sku
      t.integer :cantidad
      t.boolean :solicitado, default: false
      t.boolean :despachado, defaut: false
      t.timestamps null: false
    end
  end
end
