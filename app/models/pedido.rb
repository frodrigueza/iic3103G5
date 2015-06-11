class Pedido < ActiveRecord::Base
  has_many :insumos
  has_many :logs

  scope :activos, lambda {where('fecha_entrega > ?', DateTime.now).where(despachado: false).order(:id)}

end
