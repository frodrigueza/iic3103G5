module Helpers

	def self.time_to_unix(time)
		return DateTime.parse(time.to_s).utc.to_i * 1000
	end 
end