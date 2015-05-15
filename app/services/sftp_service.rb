class SftpService
	def initialize(host, user, password)
		# session = Net::SSH.start('chiri.ing.puc.cl', 'integra5', :password => 'M8yF.3@Pd', :port => 22)
		session = Net::SSH.start(host, user, :password => password, :port => 22)
		@sftp = Net::SFTP::Session.new(session).connect!
	end

	# nuevas ordenes
	def read_new_orders

		orders_manager = OrdersManager.new()

		@sftp.dir.foreach("/Pedidos") do |entry|
			if entry.name != "." && entry.name != ".."		
				local_path_aux = "sftp_files/" + entry.name
				@sftp.download!("/Pedidos/" + entry.name, local_path_aux)


				file = File.open(local_path_aux, "rb")
				contents = file.read

				hash = Hash.from_xml(contents)
				final_hash = hash["xml"]["Pedido"]
				final_hash[:canal] = 'ftp'
				final_hash[:precio] = final_hash[:precioUnitario]

				# enviamos el pedido al orders manager
				orders_manager.send_new_order(final_hash)
				a.a
			end
		end
		a.a
	end
end