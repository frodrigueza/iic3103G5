# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
#set :environment, "development"

every 20.minutes do
  runner "PedidoManager.check_pedidos", :output => 'tmp/check_pedidos.log'
end

every 6.hours do
  runner "SftpService.read_new_orders", :output => 'tmp/read_new_orders.log'
end

#Revisar pedidos en la cola a cada 30 minutos
every 5.minutes do
  runner "ColaManager.recibir"
end

every 1.minutes do
  runner "ProductoManager.actualizar_precios"
end

