class GruposInfo


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

    def self.get_id_cuenta(cuenta)
        case cuenta
        when "55648ad3f89fed0300524ffe" || "556489daefb3d7030091bab3"
            "Grupo 1"
        when "55648ad3f89fed0300525000" || "556489daefb3d7030091bab5"
            "Grupo 2"
        when "55648ad3f89fed0300525002" || "556489daefb3d7030091bab7"
            "Grupo 3"
        when "55648ad3f89fed0300525004" || "556489daefb3d7030091bab9"
            "Grupo 4"
        when "55648ad3f89fed0300524ffd" || "556489daefb3d7030091bab2"
            "Grupo 5"
        when "55648ad3f89fed0300524fff" || "556489daefb3d7030091bab9"
            "Grupo 6"
        when "55648ad3f89fed0300525001" || "556489daefb3d7030091bab6"
            "Grupo 7"
        when "55648ad3f89fed0300525003" || "556489daefb3d7030091bab8"
            "Grupo 8"
        when "55648ad2f89fed0300524ff3" || "556489daefb3d7030091baa8"
            "Fabrica"
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
        return "55648ae7f89fed03005251d0" if GroupInfo.en_produccion
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

    def self.get_direccion(cliente)

        case cliente
        when "1"
            return "Mohrenstraße 82, 10117 Berlin, Germany"
        when "2"
            return "Denezhnyy per., 9 стр. 1, Moscow, Russia"
        when "3"
            return "Rigillis 15, 10674 Atenas, Grecia"
        when "4"
            return "Nº2 Saleh Ayoub Suite 41, Zamalek, Cairo, Egipto"
        when "5"
            return "2290 Yan An West Road. Shanghai, China"
        when "6"
            return "Calle de Lagasca, 89, 29010 Madrid, Spain"
        when "7"
            return "10 Culgoa CircuitO'Malley, Australia"
        when "8"
            return "169 Garsfontein Road,  Delmondo Office Park, Sudafrica"
        when "9"
            return "Balvanera Buenos Aires, Argentina"      
        when "10"
            return "Alvarez Condarco 740 Las Heras, Mendoza, Argentina"
        when "11"
            return "Avda Cristobal Colon 3707, Santiago" 
        when "12"
            return "Republica de Chile 504 Jesús María, Peru"
        when "13"
            return "Arenal Grande 2193 Montevideo, Uruguay"
        when "14"
            return "Anahí, Santa Cruz de la Sierra, Bolivia"
        when "15"
            return "Tte. Fariña Nº 166 esq. Yegros, Paraguay"
        when "16"
            return "45 CC Monterrey Locales 326 y 327 Carrera 50 # 10, Medellín, Antioquia, Colombia"
        when "17"
            return "Av. Sanatorio del Ávila, Edif. Yacambú, Piso 3, Boleita Norte, Caracas, Venezuela."
        when "18"
            return "Rua Deputado Lacerda Franco, 553 - Pinheiros São Paulo - SP, Brazil"
        when "19"
            return "Laguna de Mayrán 300 Anáhuac, Miguel Hidalgo, Ciudad de México, D.F., Mexico"
        when "20"
            return "5641 Dewey St Hollywood, FL, United States"
        when "21"
            return "448 S Hill St #712 Los Angeles, CA, United States"

        end

    end

    def self.get_pais(cliente)

        case cliente
        when "1"
            "Germany"
        when "2"
            "Russia"
        when "3"
            "Grecia"
        when "4"
            "Egipto"
        when "5"
            "China"
        when "6"
            "Spain"
        when "7"
            "Australia"
        when "8"
            "Sudafrica"
        when "9"
            "Argentina"      
        when "10"
            "Argentina"
        when "11"
            "Chile" 
        when "12"
            "Peru"
        when "13"
            "Uruguay"
        when "14"
            "Bolivia"
        when "15"
            "Paraguay"
        when "16"
            "Colombia"
        when "17"
            "Venezuela"
        when "18"
            "Brazil"
        when "19"
            "Mexico"
        when "20"
            "USA"
        when "21"
            "USA"
        end

    end

end


