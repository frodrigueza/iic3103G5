class AuthManager

	# devuelve un token si las credenciales son correctas
	def self.get_token(params)
		# hash que devolveremos
		response = {}

		if !params[:username] || !params[:password]
			response = {
				status: 200,
				content: {
					respuesta:"Debe completar todos los campos",
					request_correct_format: {
						username: "string",
						password: "string (min 8)"
					}
				}
			}
		else
			# construimos el email
			email = params[:username] + "@integra5.com"

			# password entregada desde controlador
			password = params[:password] 
			
			# buscamos el usuario
			user = User.find_for_authentication(email: email)
			
			# vemos si las credenciales son correctas
			if user && user.valid_password?(password)
				response = {
					status: 200, 
					content: {
						usuario: email.split('@')[0],
						token: user.token
					}
				}
			else
				response = {
					status: 401,
					content: {
						respuesta: "Autenticación errónea, credenciales inválidas"
					}
				}
			end
		end

		return response

	end

	# corroboramos el token recibido
	def self.check_token(new_token)
		if new_token
			new_token = new_token.split(' ')[1]
			if new_token
				User.all.each do |u|
					if u.token == new_token
						return true
					end
				end
			else
				false
			end
			return false
		else
			return false
		end
	end

	# creacion de nuevo usuario
	def self.register(params)
		response = {}

		if !params[:username] || !params[:password]
			response = {
				status: 200,
				content: {
					respuesta:"Debe completar todos los campos",
					request_correct_format: {
						username: "string",
						password: "string min 8 caracteres"
					}
				}
			}
		else
			email = params[:username] + "@integra5.com"
			password = params[:password]
			
			user = User.create(email: email, password: password)
			if user.id
				response = {
					status: 200,
					content:{
						username: user.f_name,
						token: user.token
					}
				}
			else
				response = {
					status: 400,
					content:{
						error: "No fue posible relizar el registro"
					}
				}
			end
		end

		return response
	end
end