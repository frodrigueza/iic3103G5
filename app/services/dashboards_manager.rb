class DashboardsManager

    def self.skus_by_canal
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

end