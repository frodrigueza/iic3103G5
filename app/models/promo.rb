class Promo < ActiveRecord::Base
  scope :activas, lambda {where('created_at > ?', DateTime.now - 1.day)}
end
