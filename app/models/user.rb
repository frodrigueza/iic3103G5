class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
	before_create :generate_token


	def f_name
		email.split("@")[0]
	end

	def generate_token
		self.token = SecureRandom.urlsafe_base64(nil, false)
	end
end
