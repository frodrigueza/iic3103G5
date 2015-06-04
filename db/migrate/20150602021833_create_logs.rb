class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.text :content
      t.references :pedido

      t.timestamps null: false
    end
  end
end
