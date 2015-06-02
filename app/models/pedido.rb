class Pedido < ActiveRecord::Base
  has_many :insumos

  scope :activos, lambda {where('fecha_entrega > ?', DateTime.now).order(:id)}

end
