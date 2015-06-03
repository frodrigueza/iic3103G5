class Pedido < ActiveRecord::Base
  has_many :insumos
  has_many :logs

  scope :activos, lambda {where('fecha_entrega > ?', DateTime.now).order(:id)}

end
