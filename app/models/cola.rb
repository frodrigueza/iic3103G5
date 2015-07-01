class Cola < ActiveRecord::Base
  scope :activas, lambda {where('inicio < ?', DateTime.now).where('fin > ?', DateTime.now)}
end
