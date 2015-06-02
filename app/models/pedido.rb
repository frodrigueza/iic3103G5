class Pedido < ActiveRecord::Base
  has_many :insumos
  has_many :movements

  scope :activos, lambda {where(:fecha_entrega > DateTime.now)}

end
