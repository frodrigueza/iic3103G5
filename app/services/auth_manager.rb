class AuthManager
	def get_token(username, password)
		token = '16d662914c0397d0ec2b49614bbb48d2914b3f079e21bd645f61e78834f7367336b17738c6824903265569e8b54bde33809c9b486f011f0c41efdfe7292eab3e'
		case username
			when 'grupo_1'
				if password == 'grupo1abcd'
					return hash
				end
			when 'grupo_2'
				if password == 'grupo2abcd'
					return hash
				end
			when 'grupo_3'
				if password == 'grupo3abcd'
					return hash
				end
			when 'grupo_4'
				if password == 'grupo4abcd'
					return hash
				end
			when 'grupo_5'
				if password == 'grupo5abcd'
					return hash
				end
			when 'grupo_6'
				if password == 'grupo6abcd'
					return hash
				end
			when 'grupo_7'
				if password == 'grupo7abcd'
					return hash
				end
			else
				return false
		end
	end
end