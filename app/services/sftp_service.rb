class SftpService
	# nuevas ordenes
	def self.read_new_orders
		session = Net::SSH.start(GroupInfo.url_ftp, 'integra5', :password => GroupInfo.clave_servidor, :port => 22)
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
			order[:fechaEntrega] = DateTime.strptime(order[:fechaEntrega], '%m.%d.%Y')
			order[:_id] = order[:oc]
			OrdersManager.create_order_db(order)
		end
	return orders.length
	end
end