class LogManager

	def self.new_log( pedido , mensaje )

		log = Log.create(:content => mensaje)
		log.pedido  = pedido
		log.save
	end

end