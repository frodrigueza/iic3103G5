class GruposInfo

	produccion = 

	def self.get_cuenta_id(group_id)
		case group_id

	      when "1"
	        return "55648ad3f89fed0300524ffe" if GroupInfo.en_produccion
	        return "556489daefb3d7030091bab3" if not GroupInfo.en_produccion
	      when "2"
	        return "55648ad3f89fed0300525000" if GroupInfo.en_produccion
	        return "556489daefb3d7030091bab5" if not GroupInfo.en_produccion
	      when "3"
	        return "55648ad3f89fed0300525002" if GroupInfo.en_produccion
	        return "556489daefb3d7030091bab7" if not GroupInfo.en_produccion
	      when "4"
	        return "55648ad3f89fed0300525004" if GroupInfo.en_produccion
	        return "556489daefb3d7030091bab9" if not GroupInfo.en_produccion
	      when "6"
	        return "55648ad3f89fed0300524fff" if GroupInfo.en_produccion
	        return "556489daefb3d7030091bab4" if not GroupInfo.en_produccion
	      when "7"
	        return "55648ad3f89fed0300525001" if GroupInfo.en_produccion
	        return "556489daefb3d7030091bab6" if not GroupInfo.en_produccion
	      when "8"
	        return "55648ad3f89fed0300525003" if GroupInfo.en_produccion
	        return "556489daefb3d7030091bab8" if not GroupInfo.en_produccion
	      
	    end

	end

	def self.get_recepcion_id(group_id)

    case group_id

      when "1"
        return "55648ae6f89fed030052500d" if GroupInfo.en_produccion
        return "556489e6efb3d7030091bac2" if not GroupInfo.en_produccion
      when "2"
        return "55648ae6f89fed0300525061" if GroupInfo.en_produccion
        return "556489e7efb3d7030091bb7d" if not GroupInfo.en_produccion
      when "3"
        return "55648ae7f89fed030052512f" if GroupInfo.en_produccion
        return "556489e7efb3d7030091bc67" if not GroupInfo.en_produccion
      when "4"
        return "55648ae6f89fed03005251d0" if GroupInfo.en_produccion
        return "556489e7efb3d7030091bd07" if not GroupInfo.en_produccion
      when "6"
        return "55648ae7f89fed0300525293" if GroupInfo.en_produccion
        return "556489e7efb3d7030091bf2b" if not GroupInfo.en_produccion
      when "7"
        return "55648ae7f89fed0300525369" if GroupInfo.en_produccion
        return "556489e7efb3d7030091bf6f" if not GroupInfo.en_produccion
      when "8"
        return "55648ae7f89fed0300525420" if GroupInfo.en_produccion
        return "556489e7efb3d7030091bf89" if not GroupInfo.en_produccion
      
    end
    #TODO: Cambiar con paso a produccion
    
  end

end


