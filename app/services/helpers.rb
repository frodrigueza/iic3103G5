module Helpers

	def self.time_to_unix(time)
		return time.utc.to_i * 1000
	end 

end