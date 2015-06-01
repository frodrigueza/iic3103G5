class BodegaHash

	#Permite crear hash SHA1 y output en base 64
	def self.crear_hash(str)
		digest  = OpenSSL::Digest.new('sha1')
		aux = OpenSSL::HMAC.digest(digest, "0c0ifZEBkDKnsb", str)
		enc   = Base64.encode64(aux)
		enc = enc[0..enc.length-2]
		return enc
	end



end