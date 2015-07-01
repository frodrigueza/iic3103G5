module PedidosHelper
	def f_key(atr)
		atr = atr.gsub('_',' ')
		atr = atr.capitalize

		if atr.include?('Cantidad')
			atr = atr.insert(8, ' ')
		elsif atr.include?('Fecha')
			atr.insert(5, ' ')
		elsif atr.include?('Precio')
			atr.insert(6, ' ')
		end

		return atr
	end

	def f_value(val)
		val = val.to_s
		if val.include?('T') && val.include?('Z')
			val = val.to_time.strftime("%v - %R")
		elsif val == ("[]")
			val = "-"
		end
		
		return val
	end

	def f_date(date)
		date.to_time.strftime("%v - %R")
	end

	def previous_page(n)
		return n>1 ? n-1 : 1
	end

	def next_page(n)
		return n<@count ? n+1 : @count
	end
end
