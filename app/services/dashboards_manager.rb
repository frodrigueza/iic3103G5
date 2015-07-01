class DashboardsManager


    # pedidos segun SKU, agrupados por canal
    def self.orders_by_sku_group_by_canal
        aux_array = [
            {
                name: 'ftp',
                data: skus_counts_for_canal('ftp')
            },
            {
                name: 'b2b',
                data: skus_counts_for_canal('b2b')
            },
            {
                name: 'e-commerce',
                data: skus_counts_for_canal('e-commerce')
            }
        ]
    end

    def self.sku_count_for_canal(canal, sku)
        Pedido.where(sku: sku, canal: canal).count
    end

    def self.skus_counts_for_canal(canal)
        array = []
        GroupInfo.skus.each do |s|
            array << sku_count_for_canal(canal, s)
        end

        array
    end

    # cantidad ordenada segun SKU, agrupados por canal
    def self.quantities_by_sku_group_by_canal
        aux_array = [
            {
                name: 'ftp',
                data: total_ordered_quantities('ftp')
            },
            {
                name: 'b2b',
                data: total_ordered_quantities('b2b')
            },
            {
                name: 'e-commerce',
                data: total_ordered_quantities('e-commerce')
            }
        ]
    end

    def self.total_ordered_quantity(canal, sku)
        Pedido.where(sku: sku, canal: canal).inject(0){|sum, o| o.cantidad ? sum + o.cantidad : sum }
    end

    def self.total_ordered_quantities(canal)
        array = []
        GroupInfo.skus.each do |s|
            array << total_ordered_quantity(canal, s)
        end

        array
    end


    # pedidos por fecha de entrega
    def self.orders_by_created_at_date(canal)
        array = []

        (self.arrivals_dates).each do |date|
            count = Pedido.all.select{ |pedido| pedido.created_at.to_date == date.to_date && pedido.canal == canal }.count
            new_object = [date.to_time.to_i * 60 *24, count]
            array << new_object
        end

        array
    end

    def self.arrivals_dates
        (Pedido.all.min_by{|x| x.created_at.to_date}.created_at.to_date..Pedido.all.max_by{|x| x.created_at.to_date}.created_at.to_date)
    end


    # nivel de servicio por pais
    def self.service_level(pais_id)
        if pais_id == (9 || 10)
            delivered_orders = Pedido.where(canal: 'ftp', cliente: 9, despachado: true) + Pedido.where(canal: 'ftp', cliente: 10, despachado: true)
            total_orders = Pedido.where(canal:'ftp', cliente: 9) + Pedido.where(canal:'ftp', cliente: 10)
        elsif pais_id == (20 || 21)
            delivered_orders = Pedido.where(canal: 'ftp', cliente: 20, despachado: true) + Pedido.where(canal: 'ftp', cliente: 21, despachado: true)
            total_orders = Pedido.where(canal:'ftp', cliente: 21) + Pedido.where(canal:'ftp', cliente: 20)
        else
            delivered_orders = Pedido.where(canal: 'ftp', cliente: pais_id, despachado: true)
            total_orders = Pedido.where(canal:'ftp', cliente: pais_id)
        end

        if total_orders.count == 0 
            return nil
        else
            return [total_orders.count, delivered_orders.count]
        end
    end

    def self.service_levels_by_countries
        delivered = []
        received = []
        countries = []

        (1..21).each do |i|
            if i != 10 && i != 21
                ser_level = service_level(i)

                if ser_level != nil
                    received << ser_level[0]
                    delivered << ser_level[1]
                    countries << GruposInfo.get_pais(i.to_s)
                end
            end
        end

        [
            countries,
            {
                name: 'No Despachadas',
                data: received
            },
            {
                name: 'Despachadas',
                data: delivered
            }
        ]
    end


    # cartola del banco
    def self.bank_transactions
        start_date = Helpers.time_to_unix(DateTime.now - 200.days)
        end_date = Helpers.time_to_unix(DateTime.now)
        bank_account_id = GroupInfo.cuenta_banco

        body = {
            fecha_inicio: start_date,
            fecha_fin: end_date,
            id_cb: bank_account_id,
            limit: 10
        }
        aux = HttpManager.obtener_cartola(body)
        transacciones = JSON.parse("["+aux.split('[').last.to_s)
    end

end