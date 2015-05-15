class ApplicationController < ActionController::Base

	before_action :test

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def test
	# sftp = SftpService.new('chiri.ing.puc.cl', 'integra5', 'M8yF.3@Pd')
	# sftp.read_new_orders
  end
end
