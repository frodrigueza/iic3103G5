class SftpService
	# nuevas ordenes
	def self.read_new_orders
		session = Net::SSH.start('chiri.ing.puc.cl', 'integra5', :password => 'M8yF.3@Pd', :port => 22)
		@sftp = Net::SFTP::Session.new(session).connect!
		orders = []
		@sftp.dir.foreach("/Pedidos") do |entry|
			if entry.name != "." and entry.name != ".."		
				local_path_aux = "sftp_files/" + entry.name
				@sftp.download!("/Pedidos/" + entry.name, local_path_aux)

				file = File.open(local_path_aux, "rb")
				contents = file.read

				hash = Hash.from_xml(contents)
				final_hash = hash["xml"]["Pedido"]
				final_hash["canal"] = 'ftp'
				orders.push final_hash
			end
		end
		orders.each do |order|
			order = order.symbolize_keys
			pedidos = Pedido.find_by oc_id: order[:oc]
			if pedidos == nil
				order[:fechaEntrega] = DateTime.strptime(order[:fechaEntrega], '%m.%d.%Y')
				OrdersManager.create_order_db(order)
			end
		end
	return orders.length
	end
end