class CreateMovements < ActiveRecord::Migration
  def change
    create_table :movements do |t|
      t.text :content
      t.belongs_to :pedido, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
